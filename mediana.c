#include <stdlib.h>

/* 
   Metodo de comparacion de doubles.
   Devuelve un un numero negativo, cero, o positivo
   en caso de que arg1 sea menor, igual o mayor que arg2,
   respectivamente
*/
int comp_double(const void *arg1, const void *arg2){
    if (*(double*)arg1 < *(double*)arg2) return -1;
    else if (*(double*)arg1 > *(double*)arg2) return 1;
    else return 0;
}


/*
   Devuelve la mediana de un array de doubles.
   Recibe un puntero a double, o nombre del array
   y el numero de elementos del array.
*/
double median_double(double *array, size_t num){
    qsort((void *) array, num, sizeof(double), comp_double);
    return array[(num - 1) / 2];
}
