

#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>

using namespace std;


int check(string nom){

	string str=".'éè`";   // tout les carracteres indesiree
	int t = str.length();
	for(int i = 0 ; i< t ; i++){
		if( nom.find(str.at(i)) < nom.length() && nom.find(str.at(i)) >= 0 ){
			return -1;
		}
	}

	return 1 ;
}




int main() 
{ 
   

    	
	string nom;
   
        ifstream input1("/media/bwamba/A/in1.txt", ios::in);  
	ifstream input2("/media/bwamba/A/in2.txt", ios::in); 
	ifstream input3("/media/bwamba/A/in3.txt", ios::in); 
        ofstream output("/media/bwamba/A/out.txt", ios::out); 


        if(input1 && input2 && input3 && output)  
        {
		while( !input1.eof() ){

			input1 >> nom ;
			if( nom.length() < 11 && check(nom)==1){
				output << nom <<endl;
			}
		}

		while( !input2.eof() ){

			input2 >> nom ;
			if( nom.length() < 11 && check(nom)==1){
				output << nom <<endl;
			}
		}

		while( !input3.eof() ){

			input3 >> nom ;
			if(nom.length() < 11 && check(nom)==1 ){
				output << nom <<endl;
			}
		}

                input1.close();
                input2.close();
                input3.close();
		output.close();
        }
        else {
		cerr << "Impossible d'ouvrir le fichier !" << endl;
	}


	cout <<endl ;
    	return 0;
}

