#include <bits/stdc++.h>

using namespace std;

map<string,int> insts;
map<string,bool> single;

int main (int argc, char *argv[]){
    setlocale(LC_ALL, "Portuguese");
    int n,k;
    string s;
    ifstream infile;
    ofstream outfile;
    ifstream instfile ("insts.txt");

    if(argc > 1){
        if(argc != 4){
            cout
                << "Digite algo no formato\n"
                << "compiler insts.txt in.txt out.dat";

            return 0;
        }

        instfile = ifstream  (argv[1]);
        infile = ifstream  (argv[2]);
        outfile = ofstream (argv[3]);
    }
    else{
        instfile = ifstream ("insts.txt");
        infile = ifstream  ("in.txt");
        outfile = ofstream ("out.txt");
    }

    if (instfile.is_open()){
        cout << "Carregando instruções...\n\n";

        instfile >> s;
        while(instfile >> s){
            if(s == "insts")
                break;

            single[s] = true;
        }
        while(instfile >> s >> k){
            insts[s] = k;
        }
        instfile.close();
    }


    if (infile.is_open() && outfile.is_open()){
        cout << "Código Assembly\n\n";
        while(infile >> s){
            if(!single[s]){
                infile >> k;
                cout << s << " " << k << "\n";
                outfile << char(insts[s]) << char(k);
            }
            else{
                outfile << char(insts[s]) << char(0);;
                cout << s << "\n";
            }
        }

        cout << "\nCompilado\n";
        outfile.close();
        infile.close();
    }
    else
        cout << "File error\n";

    return 0;
}


