# Makefile
all: hello_world

hello_world: hello_world.o
	gcc -o $@ $+

hello_world.o: hello_world.s
	as -o $@ $<

clean:
	rm -rf hello_world *.o
