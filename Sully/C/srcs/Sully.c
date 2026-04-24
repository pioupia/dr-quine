#include <stdio.h>
#include <stdlib.h>

/**
 * File template: [string]_X
 * If we don't find X or X is not equal to input_value, then the return will be input_value
 * Otherwise, it'll return input_value - 1.
 */
int	verify_file_name(int input_value) {
	char			filename[] = __FILE__;
	int				i = 0;
	unsigned int	result = 0;

	while (filename[i] && filename[i] != '_')
		i++;
	if (filename[i] == 0)
		return (input_value);
	i++;
	while (filename[i] >= '0' && filename[i] <= '9' && result < __INT32_MAX__) {
		result = (result * 10) + (filename[i] - '0');
		i++;
	}
	if (result >= __INT32_MAX__)
		return (input_value);
	if ((int) result != input_value)
		return (input_value);
	return (input_value - 1);
}

int main(void) {
	char name[100] = {0};
	char filename[100] = {0};
	char cmd[100] = {0};
	int i = 5;

	if (i <= 0)
		return (1);
	
	i = verify_file_name(i);

	char buffer[] = "#include <stdio.h>%1$c#include <stdlib.h>%1$c%1$c/**%1$c * File template: [string]_X%1$c * If we don't find X or X is not equal to input_value, then the return will be input_value%1$c * Otherwise, it'll return input_value - 1.%1$c */%1$cint%2$cverify_file_name(int input_value) {%1$c%2$cchar%2$c%2$c%2$cfilename[] = __FILE__;%1$c%2$cint%2$c%2$c%2$c%2$ci = 0;%1$c%2$cunsigned int%2$cresult = 0;%1$c%1$c%2$cwhile (filename[i] && filename[i] != '_')%1$c%2$c%2$ci++;%1$c%2$cif (filename[i] == 0)%1$c%2$c%2$creturn (input_value);%1$c%2$ci++;%1$c%2$cwhile (filename[i] >= '0' && filename[i] <= '9' && result < __INT32_MAX__) {%1$c%2$c%2$cresult = (result * 10) + (filename[i] - '0');%1$c%2$c%2$ci++;%1$c%2$c}%1$c%2$cif (result >= __INT32_MAX__)%1$c%2$c%2$creturn (input_value);%1$c%2$cif ((int) result != input_value)%1$c%2$c%2$creturn (input_value);%1$c%2$creturn (input_value - 1);%1$c}%1$c%1$cint main(void) {%1$c%2$cchar name[100] = {0};%1$c%2$cchar filename[100] = {0};%1$c%2$cchar cmd[100] = {0};%1$c%2$cint i = %4$d;%1$c%1$c%2$cif (i <= 0)%1$c%2$c%2$creturn (1);%1$c%2$c%1$c%2$ci = verify_file_name(i);%1$c%1$c%2$cchar buffer[] = %3$c%5$s%3$c;%1$c%1$c%2$csprintf(name, %3$c./Sully_%6$cd%3$c, i);%1$c%2$csprintf(filename, %3$c%6$cs.c%3$c, name);%1$c%2$csprintf(cmd, %3$cclang -Wall -Wextra -Werror %6$c1$s -o %6$c2$s && %6$c2$s%3$c, filename, name);%1$c%1$c%2$cFILE *file = fopen(filename, %3$cw%3$c);%1$c%2$cfprintf(file, buffer, 10, 9, 34, i, buffer, 37);%1$c%2$cfclose(file);%1$c%1$c%2$csystem(cmd);%1$c%1$c%2$creturn (0);%1$c}";

	sprintf(name, "./Sully_%d", i);
	sprintf(filename, "%s.c", name);
	sprintf(cmd, "clang -Wall -Wextra -Werror %1$s -o %2$s && %2$s", filename, name);

	FILE *file = fopen(filename, "w");
	fprintf(file, buffer, 10, 9, 34, i, buffer, 37);
	fclose(file);

	system(cmd);

	return (0);
}