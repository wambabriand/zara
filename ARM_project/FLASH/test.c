#include "mylib.h"
#include "clocks.h"
#include "matrix.h"


int main()
{
    clocks_init();
    matrix_init();


    test_pixels();

    // elle contiene un while (1) pour voir l effet de l un il faut mettre l autre en cmmentaire


    return 0;
}
