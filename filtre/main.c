#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc , char **argv)
{

	char name[30],sex[10] , sex2[30] ;
	int tmp1 , tmp2 ;
	FILE *in , *out ;

	in = fopen(argv[1],"r");
	if(in==NULL){
		printf("File non existant \n");
		return -1;
	}


	out = fopen("out.txt","r");
	if(out==NULL){
		printf("impossible cree le file out.txt \n");
		return -1;
	}


	while( fscanf (fp,"%d %s (%s) %d %s ",tmp1, name, sex, tmp2, sex ) !=EOF  ){

		fprintf( out,"%s",name);
	}

	return 0;

}
