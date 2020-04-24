#include <cstdio>

int add2numbers(int x, int y)
{
	return x+y;
}

int main()
{
	int a, b;

	printf("Enter two integer values: ");
	scanf("%d %d", &a, &b);

	int c = add2numbers(a,b);

	printf("The sum of %d and %d is %d\n", a, b, c);
	return 0;
}

