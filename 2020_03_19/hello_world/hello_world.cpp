#include <cstdio>

int main()
{
	printf("Hello World!!!\n");

	return 0;
}

// we can rewrite this to reflect more closely to our bare_bones.s structure

// 1. take all string literals (or char *) and make them into named constants
// 2. take any variables and functions, and convert them to labels

#include <cstdio>

const char * greeting = "Hello World!!!\n";

int main()
{
	printf( greeting );

	return 0;
}
