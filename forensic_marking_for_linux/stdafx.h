#include <vector>
#include <string>

extern std::vector<char> chk_type;
extern std::vector<unsigned int> uiBits;
extern std::vector<int> nalu_pos;
extern std::vector<int> origin_qtc;
extern std::vector<int> re_forensic_mark;
extern std::vector<int> feature;
extern std::vector<int> bin_arith_code;
extern std::vector<int> em_bin_arith_code;

extern bool extract_flag;
extern bool nalu_start_flag;
extern bool insert_bit_chk;
extern std::string forensic_mark_bin;
extern int insert_count;
extern std::string forensic_mark;
extern char* output_file_name;
extern std::string QTC_and_BAC_name;

