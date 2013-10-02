#include <stdlib.h>

int comp_double(const void *arg1, const void *arg2){
    if (*(double*)arg1 < *(double*)arg2) return -1;
    else if (*(double*)arg1 > *(double*)arg2) return 1;
    else return 0;
}

double median_double(double *array, size_t num){
    qsort((void *) array, num, sizeof(double), comp_double);
    return array[(num - 1) / 2];
}
