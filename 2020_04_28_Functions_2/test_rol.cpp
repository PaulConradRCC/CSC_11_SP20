#include <cstdio>

extern "C" int rol(int x, int n);	// external function rol that rotates left x, n bits.

int main()
{
	int number, bits;

	printf("Enter your number in hexadecimal: ");
	scanf("%x", &number);				// %x is format specifier for hex.

	printf("Enter number of bits to rotate left: ");
	scanf("%d", &bits);

	int result = rol(number, bits);	// result holds result from our external function, rol

	printf("0x%0X rotated left %d bit is 0x%08X\n", number, bits, result);
	return 0;
}
