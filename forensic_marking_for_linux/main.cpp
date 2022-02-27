#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <list>
#include <math.h>
#include <assert.h>
//#include <atlstr.h>
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
//
//#include "mysql_driver.h"
#include "mysql_connection.h"
#include "cppconn/driver.h"
#include "cppconn/exception.h"
#include "cppconn/resultset.h"
#include "cppconn/prepared_statement.h"

#define insert_MAX 256

using namespace std;

std::vector<std::vector<uint8_t>> slice_header;
//extern string GenerateFile(std::string filename, std::string user_name, std::string user_email, std::string user_phone, std::string user_ip, std::string user_browser, std::string cur_time);
extern string HashMaker(std::string user_name, std::string user_email, std::string user_phone, std::string user_ip, std::string user_browser, std::string download_time, std::string user_id, std::string user_os);
extern string HexStr2BinStr(std::string sHex);
extern string BinStr2HexStr(std::string sBinary);



void Read_Write_QTC()
{
	std::string qtc_data_name = "/var/www/html/WKstream/videos/QTC_dir/"+ QTC_and_BAC_name +"_QTC.data";

	if (extract_flag == false)
	{
		// write QTC
		FILE* fp_qtc = fopen(qtc_data_name.c_str(), "wb");
		if (fp_qtc == NULL) {
			fputs("error open QTC file \n", stderr);
			return;
		}

		for (int i = 0; i < origin_qtc.size(); i++) {
			fprintf(fp_qtc, "%c", origin_qtc[i]);
		}

		fclose(fp_qtc);
	}
	/*else if (extract_flag == true)
	{
		// read QTC
		size_t buf_Len;
		char buf16[16];
		FILE* fp_qtc = fopen("QTC.data", "rb");

		if (fp_qtc == NULL) {
			fputs("error open QTC file\n", stderr);
			return;
		}

		while ((buf_Len = fread(buf16, sizeof(char), sizeof(buf16), fp_qtc)) != NULL) {
			for (int i = 0; i < (int)buf_Len; i++) {
				origin_qtc.push_back((int)buf16[i]);
			}
		}

		fclose(fp_qtc);
	}*/
}

/*void encodeToFile()
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
}*/

void decodeFromFile(const char* file_name)
{
	if (extract_flag)
		Read_Write_QTC();

    // init CABCA Decode
	CABAC_BitstreamFile inStream;
	if (!inStream.openInputFile(file_name))
	{
		fprintf(stderr, "\nfailed to open bitstream file `str.bin' for reading\n");
		return;
	}
	//printf("Opened %s for reading.\n", file_name);
	CABAC_ArithmeticDecoder arithmeticDecoder(&inStream);
	arithmeticDecoder.start();
	unsigned int uiBit;
	// init context model
	CABAC_ContextModel ctx0;
	ctx0.init(0, 20);

    // init CABCA Encode
    CABAC_BitstreamFile outStream;
    if (!outStream.openOutputFile(output_file_name))
    {
        fprintf(stderr, "\nfailed to open bitstream file `out.bin' for writing\n");
        return;
    }
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

		if (insert_bit_chk){
		    while (j < uiBits.size()){
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
	FILE* fp_feature=fopen(file_name, "rb");

	if (fp_feature == NULL) {
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
		std::string bac_data_name = "/var/www/html/WKstream/videos/QTC_dir/"+ QTC_and_BAC_name +"_BAC.data";
		FILE* fp_bac = fopen(bac_data_name.c_str(), "wb");
		if (fp_bac == NULL) {
			fputs("error open file \n", stderr);
			return;
		}

		for (int i = 0; i < bin_arith_code.size(); i++) {
			fprintf(fp_bac, "%c", bin_arith_code[i]);
		}

		fclose(fp_bac);
	}
	/*else
	{
		// read QTC
		size_t buf_Len;
		char buf16[16];
		FILE* fp_bac=fopen("BAC.data", "rb");

		if (fp_bac == NULL) {
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

				if ((re_mark != 0) && (re_mark != 1))
					re_mark = 0;

				re_forensic_mark.push_back(re_mark);
				//printf("%c", re_forensic_mark[i]);
			}
		}
	}*/
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
    //DB conn
    sql::Driver *driver;
    sql::Connection *con;
    sql::PreparedStatement *pstmt;
    sql::ResultSet *result;

    driver = get_driver_instance();
    con = driver->connect("tcp://127.0.0.1:3306", "root", "1234");
    con->setSchema("test");

    pstmt = con->prepareStatement("INSERT INTO forensicmark(forensic, user, name, email, phone, os, browser, ip, downloaddate) VALUES(?,?,?,?,?,?,?,?,?)"); // insert forensic DB
    //pstmt->setString(1, "");
    //pstmt->executeQuery();

	extract_flag = false;	// switch insert and extract
	char* file_name = argv[1]; // input video [mp4]
	output_file_name = argv[2]; // output video [hevc]
	char* arith_name = "";

	// make mark to DB
	/*--------------------------------------------------------------------------------------------*/	
	if (!extract_flag)
	{
		cout << "Forensic Mark Generation.\n";
        string user_id(argv[3]);
        pstmt->setString(2, user_id);
        string user_name(argv[4]);
        pstmt->setString(3, user_name);
        string user_email(argv[5]);
        pstmt->setString(4, user_email);
        string user_phone(argv[6]);
        pstmt->setString(5, user_phone);
        string user_os(argv[7]);
        pstmt->setString(6, user_os);
        string user_browser(argv[8]);
        pstmt->setString(7, user_browser);
        string user_ip(argv[9]);
        pstmt->setString(8, user_ip);
        string download_time(argv[10]);
        pstmt->setString(9, download_time);

		// make forensic mark
		//forensic_mark = GenerateFile(argv[3], user_name, user_email, user_phone, user_ip, user_browser, download_time);
        forensic_mark = HashMaker(user_name, user_email, user_phone, user_ip, user_browser, download_time, user_id, user_os);
		pstmt->setString(1, forensic_mark);
        pstmt->executeQuery();
		forensic_mark_bin = HexStr2BinStr(forensic_mark); // hex -> bin
	}
	/*--------------------------------------------------------------------------------------------*/


	QTC_and_BAC_name = std::string(argv[11]);

	// cabac decode
	decodeFromFile(file_name);
	
	// cabac encode
	//encodeToFile();
	
	if (!extract_flag)
		arith_name = output_file_name;
	else
		arith_name = file_name;

	// arithmetic code
	ExtractFeature(arith_name);

	return 0;
}
