#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int i = 5;
	if (i <= 0)
		return (1);
	char buffer[] = "#include <stdio.h>%1$c#include <stdlib.h>%1$c%1$cint main(void) {%1$c%2$cint i = %4$d;%1$c%2$cif (i <= 0)%1$c%2$c%2$creturn (1);%1$c%2$cchar buffer[] = %3$c%5$s%3$c;%1$c%2$cchar name[100] = {0};%1$c%2$cchar filename[100] = {0};%1$c%2$cchar cmd[100] = {0};%1$c%2$csprintf(name, %3$c./Sully_%6$cd%3$c, i - 1);%1$c%2$csprintf(filename, %3$c%6$cs.c%3$c, name);%1$c%2$csprintf(cmd, %3$cclang -Wall -Wextra -Werror %6$c1$s -o %6$c2$s && %6$c2$s%3$c, filename, name);%1$c%2$cFILE *file = fopen(filename, %3$cw%3$c);%1$c%2$cfprintf(file, buffer, 10, 9, 34, i - 1, buffer, 37);%1$c%2$cfclose(file);%1$c%2$csystem(cmd);%1$c%2$creturn (0);%1$c}";
	char name[100] = {0};
	char filename[100] = {0};
	char cmd[100] = {0};
	sprintf(name, "./Sully_%d", i - 1);
	sprintf(filename, "%s.c", name);
	sprintf(cmd, "clang -Wall -Wextra -Werror %1$s -o %2$s && %2$s", filename, name);
	FILE *file = fopen(filename, "w");
	fprintf(file, buffer, 10, 9, 34, i - 1, buffer, 37);
	fclose(file);
	system(cmd);
	return (0);
}