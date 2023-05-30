#include <iostream>
#include <fstream>
#include <string>
#include <dirent.h>

int main(int argc, char* argv[])
{
    if (argc < 3) {
        std::cerr << "Error: No input file and/or output file specified!" << std::endl;
        return 1;
    }

    std::ifstream infile(argv[1]);
    unsigned long long line_count = 0;

    std::string line;
    while (std::getline(infile, line) && line_count < 5000000000) {
        ++line_count;
    }

    std::ofstream outfile(argv[2]);
    outfile << "The file contains " << line_count << " lines." << std::endl;

    std::cout << "The result is written to " << argv[2] << std::endl;

    return 0;
}