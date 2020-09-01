#include<iostream>

__global__ void kernal(void) {
	printf("Hello World!! ...from kernal\n");
}

int main(void) {
	kernal<<<1,1>>> ();
	printf("Hello World!! ...from main\n");
	return 0;
}