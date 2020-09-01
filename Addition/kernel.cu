#include<iostream>
#include "common/book.h"

__global__ void add(int a, int b, int* c) {
	*c = a + b;
}

int main(void) {
	int c;
	//host variable
	int* dev_c;
	//device variable

	const char* file = __FILE__;
	int line = __LINE__;
	cudaError_t err;

	err = cudaMalloc((void**)&dev_c, sizeof(int));

	if (err != cudaSuccess) {
		printf("%s in %s at line %d\n", cudaGetErrorString(err),
			file, line);
		exit(EXIT_FAILURE);
	}

	add<<<1,1>>>(2, 7, dev_c);

	err = cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);

	if (err != cudaSuccess) {
		printf("%s in %s at line %d\n", cudaGetErrorString(err),
			file, line);
		exit(EXIT_FAILURE);
	}

	printf("\n 2 + 7 =  %d", c);
	cudaFree(dev_c);
	return 0;
}