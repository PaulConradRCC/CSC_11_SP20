#include <cstdio>

extern "C" int rotate_left(int x, int n);	// external function rol that rotates left x, n bits.
extern "C" int rotate_right(int x, int n);	// external function ror that rotates right x, n bits.
extern "C" int exclusive_or(int x, int n);	// external function xor that xor's x by n (just like
						// C/C++ ^ operator - this is solely for demonstrating
						// mixed language programming).
int main()
{
	int number, bits, key;

	printf("Enter your number in hexadecimal: ");
	scanf("%x", &number);				// %x is format specifier for hex.

	printf("Enter number of bits to rotate left: ");
	scanf("%d", &bits);

	printf("Enter a 32 bit integer as an encryption/decryption 'key': ");
	scanf("%d", &key);

	int result = rotate_left(number, bits);	// result holds result from external function, rotate_left

	printf("0x%0X rotated left %d bit is 0x%08X\n", number, bits, result);
	int result2 = rotate_right(result, bits);

	printf("0x%0X rotated right %d bit is 0x%08X\n", result, bits, result2);

	int result3 = exclusive_or(result, key);
	printf("0x%0X exclusive or'ed by %d is 0x%08X\n", result, key, result3);

	int result4 = exclusive_or(result3, key);
	printf("0x%0X exclusive or'ed by %d is 0x%08X\n", result3, key, result4);

	return 0;
}
