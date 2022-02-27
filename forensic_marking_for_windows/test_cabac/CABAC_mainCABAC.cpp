#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <list>
#include <math.h>
#include <assert.h>
#include <atlstr.h>
#include <string>
#include <algorithm>
#include <sstream>
#include <iterator>
#include <time.h>
// CABAC library
#include "CABAC_ArithmeticEncoder.h"
#include "CABAC_ArithmeticDecoder.h"
#include "CABAC_BitstreamFile.h"
#include "CABAC_ContextModel.h"
#include "CABAC_CommonDef.h"


#define insert_MAX 256

using namespace std;

std::vector<std::vector<uint8_t>> slice_header;
extern string GenerateFile(std::string filename, std::string user_name, std::string user_email, std::string user_phone, std::string user_ip, std::string user_browser, std::string cur_time);
extern string HexStr2BinStr(std::string sHex);
extern string BinStr2HexStr(std::string sBinary);



void Read_Write_QTC()
{
	if (extract_flag == false)
	{
		// write QTC
		FILE* fp_qtc;
		if (fopen_s(&fp_qtc, "QTC.data", "wb") != 0) {
			fputs("error open QTC file \n", stderr);
			return;
		}

		for (int i = 0; i < origin_qtc.size(); i++) {
			fprintf(fp_qtc, "%c", origin_qtc[i]);
		}

		fclose(fp_qtc);
	}
	else if (extract_flag == true)
	{
		// read QTC
		size_t buf_Len;
		char buf16[16];
		FILE* fp_qtc;

		if (fopen_s(&fp_qtc, "QTC.data", "rb") != 0) {
			fputs("error open QTC file\n", stderr);
			return;
		}

		while ((buf_Len = fread(buf16, sizeof(char), sizeof(buf16), fp_qtc)) != NULL) {
			for (int i = 0; i < (int)buf_Len; i++) {
				origin_qtc.push_back((int)buf16[i]);
			}
		}

		fclose(fp_qtc);
	}
}

void encodeToFile()
{
	if (!extract_flag)
		Read_Write_QTC();

	// Create and open the bitstream to write to
	CABAC_BitstreamFile outStream;
	if (!outStream.openOutputFile(output_file_name))
	{
		fprintf(stderr, "\nfailed to open bitstream file `out.bin' for writing\n");
		return;
	}
	printf("Opened 'out.bin' for writing.\n");

	CABAC_ArithmeticEncoder arithmeticEncoder(&outStream);
	arithmeticEncoder.start();
	CABAC_ContextModel ctx0;
	ctx0.init(0, 20);

	int j = 0;
	while (j < uiBits.size())
	{
		//arithmeticEncoder.encodeBin(uiBits[j], &ctx0); // cabac updata version 
		arithmeticEncoder.encodeBinEP(uiBits[j]); // cabac non-update version
		j++;
	}

	// Finish coding
	arithmeticEncoder.finish();
	outStream.closeFile();
}

void decodeFromFile(const char* file_name)
{
	if (extract_flag)
		Read_Write_QTC();

	// Create and open the input bitstream
	CABAC_BitstreamFile inStream;
	if (!inStream.openInputFile(file_name))
	{
		fprintf(stderr, "\nfailed to open bitstream file `str.bin' for reading\n");
		return;
	}
	printf("Opened %s for reading.\n", file_name);

	// init CABCA
	CABAC_ArithmeticDecoder arithmeticDecoder(&inStream);
	arithmeticDecoder.start();
	unsigned int uiBit;
	// init context model
	CABAC_ContextModel ctx0;
	ctx0.init(0, 20);


	// Create and open the bitstream to write to
	CABAC_BitstreamFile outStream;
	if (!outStream.openOutputFile(output_file_name))
	{
		fprintf(stderr, "\nfailed to open bitstream file `out.bin' for writing\n");
		return;
	}
	printf("Opened 'out.bin' for writing.\n");

	CABAC_ArithmeticEncoder arithmeticEncoder(&outStream);
	arithmeticEncoder.start();
	CABAC_ContextModel ctx1;
	ctx1.init(0, 20);

	int j = 0;

	while (!!inStream.bitstreamFile)
	{
		//arithmeticDecoder.decodeBin(uiBit, &ctx0); // cabac updata version
		arithmeticDecoder.decodeBinEP(uiBit, &ctx0); // cabac non-update version
		uiBits.push_back(uiBit);
		
		if (insert_bit_chk)
		{
			while (j < uiBits.size())
			{
				//arithmeticEncoder.encodeBin(uiBits[j], &ctx0); // cabac updata version 
				arithmeticEncoder.encodeBinEP(uiBits[j]); // cabac non-update version
				j++;
			}
			uiBits.clear();
			j = 0;
			insert_bit_chk = false;
		}
	}



	// Finish coding
	arithmeticDecoder.finish();
	inStream.closeFile();

	// Finish coding
	arithmeticEncoder.finish();
	outStream.closeFile();

	if (!extract_flag)
		Read_Write_QTC();

}

void ExtractFeature(char* file_name)
{
	int num_total_bit = 0;

	// read file for binary arithmetic coding
	size_t buf_Len;
	char buf16[16] = {0,};
	FILE* fp_feature;

	if (fopen_s(&fp_feature, file_name, "rb") != 0) {
		fputs("error open file\n", stderr);
		return;
	}

	while ((buf_Len = fread(buf16, sizeof(char), sizeof(buf16), fp_feature)) != NULL) {
		for (int i = 0; i < (int)buf_Len; i++) {
			if ((int)buf16[i] >= 0)
				feature[(int)buf16[i]]++;
			else
				feature[256 + (int)buf16[i]]++;

			num_total_bit++;
		}
	}

	fclose(fp_feature);
	
	// calculating arithmetic
	for (size_t i = 0; i < feature.size(); i++)
	{
		double bit_probability = (double)(feature[i]) / (double)(num_total_bit) * 10000;
		if (bit_probability > 39.5)
			bit_probability = 40;
		else
			bit_probability = 30;
		bin_arith_code.push_back((int)bit_probability);
	}
	sort(bin_arith_code.begin(), bin_arith_code.end());


	// inseting mark
	if (!extract_flag)
	{
		for (size_t i = 0; i < 256; i++)
		{
			if (forensic_mark_bin[i] == 48)
				bin_arith_code[i] ^= 0;
			else
				bin_arith_code[i] ^= 1;
		}

		// write binary arithmetic code
		FILE* fp_bac;
		if (fopen_s(&fp_bac, "BAC.data", "wb") != 0) {
			fputs("error open file \n", stderr);
			return;
		}

		for (int i = 0; i < bin_arith_code.size(); i++) {
			fprintf(fp_bac, "%c", bin_arith_code[i]);
		}

		fclose(fp_bac);
	}
	else
	{
		// read BAC
		size_t buf_Len;
		char buf16[16];
		FILE* fp_bac;

		if (fopen_s(&fp_bac, "BAC.data", "rb") != 0) {
			fputs("error open file\n", stderr);
			return;
		}

		while ((buf_Len = fread(buf16, sizeof(char), sizeof(buf16), fp_bac)) != NULL) {
			for (int i = 0; i < (int)buf_Len; i++) {
				em_bin_arith_code.push_back((int)buf16[i]);
			}
		}

		fclose(fp_bac);
		
		if (!em_bin_arith_code.empty())
		{
			for (size_t i = 0; i < 256; i++)
			{
				int re_mark = bin_arith_code[i] ^ em_bin_arith_code[i];

				/*if ((re_mark != 0) && (re_mark != 1))
					re_mark = 0;*/

				re_forensic_mark.push_back(re_mark);
				//printf("%c", re_forensic_mark[i]);
			}
		}
	}
}

void init_func()
{
	chk_type.clear();
	uiBits.clear();
	nalu_pos.clear();
	origin_qtc.clear();
	re_forensic_mark.clear();
	insert_count = 0;
	nalu_start_flag = false;
}


int main(int argc, char* argv[])
{
	extract_flag = true;	// switch insert and extract
	char* file_name = argv[1];
	output_file_name = argv[2];
	char* arith_name = "";
	// make mark
	/*--------------------------------------------------------------------------------------------*/	
	if (!extract_flag)
	{
		cout << "Mark generation.\n";
		string user_name(argv[4]);
		string user_email(argv[5]);
		string user_phone(argv[6]);
		string user_ip(argv[7]);
		string user_browser(argv[8]);
		string cur_time(argv[9]);
		// make forensic mark
		forensic_mark = GenerateFile(argv[3], user_name, user_email, user_phone, user_ip, user_browser, cur_time);
		forensic_mark_bin = HexStr2BinStr(forensic_mark); // hex -> bin
	}		
	/*--------------------------------------------------------------------------------------------*/
	
	// cabac decode
	decodeFromFile(file_name);
	
	
	if (!extract_flag)
		arith_name = output_file_name;
	else
		arith_name = file_name;

	// arithmetic code
	ExtractFeature(arith_name);
	
	// extract mark
	/*--------------------------------------------------------------------------------------------*/
	std::ostringstream oss;
	if (!re_forensic_mark.empty())
	{
		// Convert all but the last element to avoid a trailing ","
		std::copy(re_forensic_mark.begin(), re_forensic_mark.begin() + 256,
			std::ostream_iterator<int>(oss, ""));

		// Now add the last element with no delimiter
		oss << re_forensic_mark.back();
		string forensic_mark_hex = BinStr2HexStr(oss.str());
		init_func();
		cout << "Forensic Mark : " << forensic_mark_hex << std::endl;
		return 0;		
	}
	/*--------------------------------------------------------------------------------------------*/
	
	init_func();
	return 0;
}