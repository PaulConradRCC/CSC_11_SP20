//
// how to compile/assemble:
//
// g++ simple_crypto_test.cpp simple_crypto_functions.s util_functions.s -g  -o simple_crypto_test
//
// or just type in the command: make
//

#include <cstdio>

extern "C" void clear_keyboard();
extern "C" int string_length(char *strng);
extern "C" void display_message(char *message, int mlength);
extern "C" void encrypt(char *message, int mlength, char *key, int klength);
extern "C" void decrypt(char *message, int mlength, char *key, int klength);

int main()
{
	char message[101]; // 100 characters plus 1 for the null terminator
	int mlen, klen;

	char key[101]; // allow encryption/decryption key to be up to same length as message

	printf("Enter your message (up to 100 characters): ");
	scanf("%100[^\n]", &message);
	mlen = string_length(message);

	clear_keyboard();

	printf("Enter your key (up to 100 characters): ");
	scanf("%100[^\n]", &key);
	klen = string_length(key);

	printf("------------------------------------------------------------\nOriginal message:\n");
	display_message(message,mlen);
	printf("------------------------------------------------------------\nEncrypted message:\n");
	encrypt(message,mlen,key,klen);
	display_message(message,mlen);
	printf("------------------------------------------------------------\nDecrypted message:\n");
	decrypt(message,mlen,key,klen);
	display_message(message,mlen);

	return 0;
}
