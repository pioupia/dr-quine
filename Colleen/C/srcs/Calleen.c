#include <stdio.h>

void	useless_stuff(void) {
	return ;
}

/**
 * The main function can be used like this...
 */
int	main(void) {
	// This is the second comment type
	char buffer[] = "#include <stdio.h>%1$c%1$cvoid%2$cuseless_stuff(void) {%1$c%2$creturn ;%1$c}%1$c%1$c/**%1$c * The main function can be used like this...%1$c */%1$cint%2$cmain(void) {%1$c%2$c// This is the second comment type%1$c%2$cchar buffer[] = %3$c%4$s%3$c;%1$c%2$cprintf(buffer, 10, 9, 34, buffer);%1$c%2$cuseless_stuff();%1$c%2$creturn (0);%1$c}%1$c";
	printf(buffer, 10, 9, 34, buffer);
	useless_stuff();
	return (0);
}
