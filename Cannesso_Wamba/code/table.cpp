

/*
################################################
## Fait par Angelo Cannesso et Briand Wamba   ##
## Ce fichier sera optimiser avec le temps    ##
##  Il est totalement libre d'utilisation     ##
##   	Prof. Ahmed Roshenid                  ##
##   	Group Télecom Paristech  	      ##
##     bwamba@telecom-paristech.fr            ##
##    acannesso@telecom-paristech.fr          ##
################################################
*/



#include "my_lib.h"

using namespace std;


int main() 
{ 
   
	int i;
	string clair,hash;
   
        ifstream fichier(data_base_claire, ios::in); 
	ofstream output(data_base, ios::out);
 

        if(!fichier || !output)  
        {
		cerr << "Impossible d'ouvrir le fichier !" << endl;
		return -1;
	}

	cout << "DEBUT DE LA CREATION DE LA BASE DE DONNE " <<endl;


	while( !fichier.eof() ){   

		getline(fichier, clair); 

		if(clair.length()==0) ; 

		else {
			output << clair  ;

			for(i=0; i <=P ; i++){
				hash = sha256(clair);
				//cout <<  clair  << " "  << hash << endl;				
				clair = reduce_hash_to_pass(hash, i);	
			}

			output << " "  << hash  <<endl;
		}
	}


	cout << "FIN DE LA CREATION DE LA BASE DE DONNE " <<endl;

        fichier.close();
	output.close();

    	return 0;
}


