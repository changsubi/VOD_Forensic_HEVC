#include "stdafx.h"

std::vector<char> chk_type;
std::vector<unsigned int> uiBits;
std::vector<int> nalu_pos;
std::vector<int> origin_qtc;
std::vector<int> re_forensic_mark;
std::vector<int> feature(256, 0);
std::vector<int> bin_arith_code;
std::vector<int> em_bin_arith_code;

bool extract_flag = false;
bool nalu_start_flag = false;
bool insert_bit_chk = false;
std::string forensic_mark_bin;
int insert_count = 0;
std::string forensic_mark = "";
char* output_file_name = "";
std::string QTC_and_BAC_name = "";