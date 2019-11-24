#include <bits/stdc++.h>

using namespace std;

int main (int argc, char *argv[]){
    setlocale(LC_ALL, "Portuguese");
    long long pos;

    if(argc == 1){
        cin >> hex >> pos;

        cout << "\n"
            << "Decimal: " << dec << pos << "\n"
            << "Binário: " << bitset<8>(pos) << "\n";
    }
    if(argc > 1){
        pos = stoi(string(argv[1]),nullptr,16);

        cout << "\n"
            << "Decimal: " << dec << pos << "\n"
            << "Binário: " << bitset<8>(pos) << "\n";
    }
    else if(argc > 1){
        cout
            << "Digite algo no formato\n"
            << "mempos ff";
    }

    return 0;
}
