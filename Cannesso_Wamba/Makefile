################################################
## Fait par Angelo Cannesso et Briand Wamba   ##
## Ce Makefile sera optimiser avec le temps   ##
##  Il est totalement d'utilisation           ##
##   	Prof. Ahmed Roshenid                  ##
##   	Group Télecom Paristech               ##
################################################

.PHONY :builder_table clean  run


run: my_lib.o sha256.o main.o
	g++ -Wall -Werror -lcrypto my_lib.o sha256.o main.o -o main 
	rm -f *.o 
	./main 


builder_table:  table.o my_lib.o sha256.o
	g++ -lcrypto table.o  my_lib.o sha256.o -o table 
	rm -f *.o 
	./table




main.o: code/main.cpp  code/my_lib.h
	g++ -Wall -Werror  -c  code/main.cpp


sha256.o: code/sha256.cpp code/my_lib.h
	g++ -Wall -Werror  -c  code/sha256.cpp


table.o: code/my_lib.cpp code/my_lib.h
	g++ -Wall -Werror -c code/table.cpp


my_lib.o: code/my_lib.cpp code/my_lib.h
	g++ -Wall -Werror -c code/my_lib.cpp

clean :
	rm -f *.o 
	rm -f code/*.o
	
