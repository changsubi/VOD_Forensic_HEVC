#pragma once

#include<string>

using namespace std;

class DocWriter
{
public:
	DocWriter();
	DocWriter(const string& fileName, const string& content);
	~DocWriter();

	void setFileName(const string& fileName);

	void setContent(const string& content);

	void Write();

protected:
	string _fileName;
	string _content;
};