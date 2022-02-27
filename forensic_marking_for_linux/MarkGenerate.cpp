#include "sha256.h"
#include "MarkGenerate.h"

#include <iostream>
#include <time.h> 
#include <string>
//#include <atlstr.h>
#include <fstream>
//#include <stdio.h>
//#include <io.h>
//#include <conio.h>
#include <vector>
#include <algorithm>
#include <iterator>
//#include <windows.h>

using std::string;
using std::cout;
using std::endl;
using namespace std;


// PRNG (WELL algorithm)
//namespace GRandom {
//	
//	unsigned long state[16];
//	unsigned int index = 0;
//	
//	void init(unsigned long seed) {
//		for (int i = 0; i < 16; ++i) {
//			state[i] = seed;
//		}
//	}
//	
//	unsigned long get() {
//		unsigned long a, b, c, d;
//		a = state[index];
//		c = state[(index + 13) & 15];
//		b = a ^ c ^ (a << 16) ^ (c << 15);
//		c = state[(index + 9) & 15];
//		c ^= (c >> 11);
//		a = state[index] = b ^ c;
//		d = a ^ ((a << 5) & 0xDA442D20UL);
//		index = (index + 15) & 15;
//		a = state[index];
//		state[index] = a ^ b^d ^ (a << 2) ^ (b << 18) ^ (c << 28);
//		return state[index];
//	}
//	
//	int getInt(int nMin, int nMax) {
//		return (int)(get() % (nMax - nMin)) + nMin;
//	}
//}

// Maker forensic mark bitstream
string HashMaker(std::string user_name, std::string user_email, std::string user_phone, std::string user_ip, std::string user_browser, std::string download_time, std::string user_id, std::string user_os)
{	
	//GRandom::init((unsigned long)time(NULL));
	//int prng_val = GRandom::getInt(1, 10000); //get PRNG from 1 to 10^15

	string input;
		
	input = user_name + user_email + user_phone + user_ip + user_browser + download_time + user_id + user_os;

	return sha256(input); //get forensic mark
}
/*
string GenerateFile(std::string filename, std::string user_name, std::string user_email, std::string user_phone, std::string user_ip, std::string user_browser, std::string cur_time)
{
	string mark_result;

	std::string mark_filename = filename + ".log";
	FILE* fp = fopen(mark_filename.c_str(), "w");

	fputs(user_name.c_str(), fp);
	fputs("\n", fp);
	fputs(user_email.c_str(), fp);
	fputs("\n", fp);
	fputs(user_phone.c_str(), fp);
	fputs("\n", fp);
	fputs(user_ip.c_str(), fp);
	fputs("\n", fp);
	fputs(user_browser.c_str(), fp);
	fputs("\n", fp);
	fputs(cur_time.c_str(), fp);
	fputs("\n", fp);

	mark_result = HashMaker(user_name, user_email, user_phone, user_ip, user_browser, cur_time);

	fputs(mark_result.c_str(), fp);
	fputs("\n", fp);

	fclose(fp);

	return mark_result;
}
*/
// Hex -> Bin
std::string HexStr2BinStr(std::string sHex)
{
	std::string sReturn = "";
	std::vector<int> bin_srr;
	for (int i = 0; i < sHex.length(); ++i)
	{
		switch (sHex[i])
		{
		case '0': sReturn.append("0000"); break;
		case '1': sReturn.append("0001"); break;
		case '2': sReturn.append("0010"); break;
		case '3': sReturn.append("0011"); break;
		case '4': sReturn.append("0100"); break;
		case '5': sReturn.append("0101"); break;
		case '6': sReturn.append("0110"); break;
		case '7': sReturn.append("0111"); break;
		case '8': sReturn.append("1000"); break;
		case '9': sReturn.append("1001"); break;
		case 'a': sReturn.append("1010"); break;
		case 'b': sReturn.append("1011"); break;
		case 'c': sReturn.append("1100"); break;
		case 'd': sReturn.append("1101"); break;
		case 'e': sReturn.append("1110"); break;
		case 'f': sReturn.append("1111"); break;
		}
	}

	return sReturn;
}

// Bin -> Hex
std::string BinStr2HexStr(std::string sBinary)
{
	std::string rest(""), tmp, chr = "0000";
	int len = sBinary.length() / 4;
	chr = chr.substr(0, len);
	sBinary = chr + sBinary;
	for (int i = 0; i < sBinary.length(); i += 4)
	{
		tmp = sBinary.substr(i, 4);
		if (!tmp.compare("0000"))
		{
			rest = rest + "0";
		}
		else if (!tmp.compare("0001"))
		{
			rest = rest + "1";
		}
		else if (!tmp.compare("0010"))
		{
			rest = rest + "2";
		}
		else if (!tmp.compare("0011"))
		{
			rest = rest + "3";
		}
		else if (!tmp.compare("0100"))
		{
			rest = rest + "4";
		}
		else if (!tmp.compare("0101"))
		{
			rest = rest + "5";
		}
		else if (!tmp.compare("0110"))
		{
			rest = rest + "6";
		}
		else if (!tmp.compare("0111"))
		{
			rest = rest + "7";
		}
		else if (!tmp.compare("1000"))
		{
			rest = rest + "8";
		}
		else if (!tmp.compare("1001"))
		{
			rest = rest + "9";
		}
		else if (!tmp.compare("1010"))
		{
			rest = rest + "a";
		}
		else if (!tmp.compare("1011"))
		{
			rest = rest + "b";
		}
		else if (!tmp.compare("1100"))
		{
			rest = rest + "c";
		}
		else if (!tmp.compare("1101"))
		{
			rest = rest + "d";
		}
		else if (!tmp.compare("1110"))
		{
			rest = rest + "e";
		}
		else if (!tmp.compare("1111"))
		{
			rest = rest + "f";
		}
		else
		{
			continue;
		}
	}
	
	rest.erase(0, 1);
	return rest;
}