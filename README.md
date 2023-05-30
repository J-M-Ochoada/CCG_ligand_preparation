# CCG_ligand_preparation
Tools and scripts to prepare ligands for virtual screening in CCG MOE
linecount5.cpp and linecount5_cluster.sh - I use these two pieces of code to count lines in extremely large files such as the Enamine Real cxsmiles files up to 5 billion lines.  Then there is a shell wrapper which can be modified to count files with certain extentions.  In this use case it will count file with .cxsmiles extentions.  It will count the lines and output the results in a output text file
