#include <stdio.h>
#define write_printf(file, str) fprintf(file, str, 10, 9, 34, str);fclose(file);
#define string	"#include <stdio.h>%1$c#define write_printf(file, str) fprintf(file, str, 10, 9, 34, str);fclose(file);%1$c#define string%2$c%3$c%4$s%3$c%1$c#define test()%2$cint main(void){write_printf(fopen(%3$c./Grace_kid.c%3$c, %3$cw%3$c),string)return 0;}%1$c// this is one comment btw%1$ctest()%1$c"
#define test()	int main(void){write_printf(fopen("./Grace_kid.c", "w"),string)return 0;}
// this is one comment btw
test()
