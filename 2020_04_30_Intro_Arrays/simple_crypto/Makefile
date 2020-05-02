#Makefile
OBJECT_FILES	= simple_crypto_test.o util_functions.o simple_crypto_functions.o
SOURCE_FILES	= simple_crypto_test.cpp util_functions.s simple_crypto_functions.s
BINARY_OUTPUT	= simple_crypto_test.out

all: simple_crypto_test.out

simple_crypto_test.out: $(OBJECT_FILES)
	$(CC) -o $@ $^

%.o: %.s
	as -c -o $@ $<
%.o: %.c
	$(CC) -c -o $@ $<

clean:
	rm -f $(OBJECT_FILES) $(BINARY_OUTPUT)

run: $(BINARY_OUTPUT)
	./$(BINARY_OUTPUT)
