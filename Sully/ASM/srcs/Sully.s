section .text
align 16

global main

extern sprintf
extern fopen
extern fprintf
extern fclose
extern system
extern exit

; 	char			filename[] = __FILE__;
; 	int				i = 0;
; 	unsigned int	result = 0;

; 	while (filename[i] && filename[i] != '_')
; 		i++;
; 	if (filename[i] == 0)
; 		return (input_value);
; 	i++;
; 	while (filename[i] >= '0' && filename[i] <= '9' && result < __INT32_MAX__) {
; 		result = (result * 10) + (filename[i] - '0');
; 		i++;
; 	}
; 	if (result >= __INT32_MAX__)
; 		return (input_value);
; 	if ((int) result != input_value)
; 		return (input_value);
; 	return (input_value - 1);

; int	verify_file_name(int input_value);
verify_file_name:
	push rbp
	mov rbp, rsp
	sub rsp, 8

	; char *filename = __FILE__
	mov r10, source_name

	; save input_value
	mov qword [rsp], rdi

	; result = 0
	xor rax, rax

.loop_underscore:
	cmp byte [r10], 0
	jz .return_input

	cmp byte [r10], '_'
	jz .to_loop_number

	; filename++
	inc r10

	jmp .loop_underscore

.to_loop_number:
	; filename++
	inc r10
.loop_number:
	cmp byte [r10], '0'
	jl .check_overflow

	cmp byte [r10], '9'
	jg .check_overflow

	cmp rax, 2147483647
	jae .check_overflow

	; rax *= 10 <=> result *= 10
	mov ecx, 10
	mul ecx

	; *filename - '0'
	mov cl, byte [r10]
	sub cl, '0'
	movzx rcx, cl

	; result += *filename - '0'
	add rax, rcx

	; filename++
	inc r10

	jmp .loop_number

.check_overflow:
	cmp rax, 2147483647
	jae .return_input

.check_result:
	; if ((int) result != input_value)
	cmp rax, qword [rsp]
	jne .return_input

.return_minus_one:
	mov rax, qword [rsp]
	dec rax
	leave
	ret

.return_input:
	; return input_value
	mov rax, qword [rsp]
	leave
	ret


main:
	mov rbp, rsp

	; i = 5
	mov rcx, 5
	cmp rcx, 0
	jle .exit

	; i = call_verify_name(i)
	mov rdi, rcx
	call verify_file_name
	mov rcx, rax

	push rcx

	mov rdi, name
	mov rsi, name_tlp
	mov rdx, rcx
	call sprintf

	mov rdi, filename
	mov rsi, filename_tlp
	mov rdx, name
	call sprintf

	mov rdi, cmd
	mov rsi, cmd_tlp
	mov rdx, filename
	mov rcx, name
	call sprintf

	mov rdi, filename
	mov rsi, permission
	call fopen

	pop r9 ; i - 1

	push rax

	mov rdi, rax
	mov rsi, buffer
	mov rdx, 10
	mov rcx, 9
	mov r8, 34

	mov r10, 37
	push r10
	push rsi
	xor rax, rax
	call fprintf

	add rsp, 16
	pop rdi
	call fclose

	add rsp, 8
	mov rdi, cmd
	call system

.exit:
	xor rdi, rdi
	call exit
	pop rbp
	ret

section .data
	align 16
	buffer: db "section .text%1$calign 16%1$c%1$cglobal main%1$c%1$cextern sprintf%1$cextern fopen%1$cextern fprintf%1$cextern fclose%1$cextern system%1$cextern exit%1$c%1$c; %2$cchar%2$c%2$c%2$cfilename[] = __FILE__;%1$c; %2$cint%2$c%2$c%2$c%2$ci = 0;%1$c; %2$cunsigned int%2$cresult = 0;%1$c%1$c; %2$cwhile (filename[i] && filename[i] != '_')%1$c; %2$c%2$ci++;%1$c; %2$cif (filename[i] == 0)%1$c; %2$c%2$creturn (input_value);%1$c; %2$ci++;%1$c; %2$cwhile (filename[i] >= '0' && filename[i] <= '9' && result < __INT32_MAX__) {%1$c; %2$c%2$cresult = (result * 10) + (filename[i] - '0');%1$c; %2$c%2$ci++;%1$c; %2$c}%1$c; %2$cif (result >= __INT32_MAX__)%1$c; %2$c%2$creturn (input_value);%1$c; %2$cif ((int) result != input_value)%1$c; %2$c%2$creturn (input_value);%1$c; %2$creturn (input_value - 1);%1$c%1$c; int%2$cverify_file_name(int input_value);%1$cverify_file_name:%1$c%2$cpush rbp%1$c%2$cmov rbp, rsp%1$c%2$csub rsp, 8%1$c%1$c%2$c; char *filename = __FILE__%1$c%2$cmov r10, source_name%1$c%1$c%2$c; save input_value%1$c%2$cmov qword [rsp], rdi%1$c%1$c%2$c; result = 0%1$c%2$cxor rax, rax%1$c%1$c.loop_underscore:%1$c%2$ccmp byte [r10], 0%1$c%2$cjz .return_input%1$c%1$c%2$ccmp byte [r10], '_'%1$c%2$cjz .to_loop_number%1$c%1$c%2$c; filename++%1$c%2$cinc r10%1$c%1$c%2$cjmp .loop_underscore%1$c%1$c.to_loop_number:%1$c%2$c; filename++%1$c%2$cinc r10%1$c.loop_number:%1$c%2$ccmp byte [r10], '0'%1$c%2$cjl .check_overflow%1$c%1$c%2$ccmp byte [r10], '9'%1$c%2$cjg .check_overflow%1$c%1$c%2$ccmp rax, 2147483647%1$c%2$cjae .check_overflow%1$c%1$c%2$c; rax *= 10 <=> result *= 10%1$c%2$cmov ecx, 10%1$c%2$cmul ecx%1$c%1$c%2$c; *filename - '0'%1$c%2$cmov cl, byte [r10]%1$c%2$csub cl, '0'%1$c%2$cmovzx rcx, cl%1$c%1$c%2$c; result += *filename - '0'%1$c%2$cadd rax, rcx%1$c%1$c%2$c; filename++%1$c%2$cinc r10%1$c%1$c%2$cjmp .loop_number%1$c%1$c.check_overflow:%1$c%2$ccmp rax, 2147483647%1$c%2$cjae .return_input%1$c%1$c.check_result:%1$c%2$c; if ((int) result != input_value)%1$c%2$ccmp rax, qword [rsp]%1$c%2$cjne .return_input%1$c%1$c.return_minus_one:%1$c%2$cmov rax, qword [rsp]%1$c%2$cdec rax%1$c%2$cleave%1$c%2$cret%1$c%1$c.return_input:%1$c%2$c; return input_value%1$c%2$cmov rax, qword [rsp]%1$c%2$cleave%1$c%2$cret%1$c%1$c%1$cmain:%1$c%2$cmov rbp, rsp%1$c%1$c%2$c; i = 5%1$c%2$cmov rcx, %4$d%1$c%2$ccmp rcx, 0%1$c%2$cjle .exit%1$c%1$c%2$c; i = call_verify_name(i)%1$c%2$cmov rdi, rcx%1$c%2$ccall verify_file_name%1$c%2$cmov rcx, rax%1$c%1$c%2$cpush rcx%1$c%1$c%2$cmov rdi, name%1$c%2$cmov rsi, name_tlp%1$c%2$cmov rdx, rcx%1$c%2$ccall sprintf%1$c%1$c%2$cmov rdi, filename%1$c%2$cmov rsi, filename_tlp%1$c%2$cmov rdx, name%1$c%2$ccall sprintf%1$c%1$c%2$cmov rdi, cmd%1$c%2$cmov rsi, cmd_tlp%1$c%2$cmov rdx, filename%1$c%2$cmov rcx, name%1$c%2$ccall sprintf%1$c%1$c%2$cmov rdi, filename%1$c%2$cmov rsi, permission%1$c%2$ccall fopen%1$c%1$c%2$cpop r9 ; i - 1%1$c%1$c%2$cpush rax%1$c%1$c%2$cmov rdi, rax%1$c%2$cmov rsi, buffer%1$c%2$cmov rdx, 10%1$c%2$cmov rcx, 9%1$c%2$cmov r8, 34%1$c%1$c%2$cmov r10, 37%1$c%2$cpush r10%1$c%2$cpush rsi%1$c%2$cxor rax, rax%1$c%2$ccall fprintf%1$c%1$c%2$cadd rsp, 16%1$c%2$cpop rdi%1$c%2$ccall fclose%1$c%1$c%2$cadd rsp, 8%1$c%2$cmov rdi, cmd%1$c%2$ccall system%1$c%1$c.exit:%1$c%2$cxor rdi, rdi%1$c%2$ccall exit%1$c%2$cpop rbp%1$c%2$cret%1$c%1$csection .data%1$c%2$calign 16%1$c%2$cbuffer: db %3$c%5$s%3$c, 0%1$c%2$cname: times 100 db 0%1$c%2$cfilename: times 100 db 0%1$c%2$ccmd: times 200 db 0%1$c%2$cname_tlp: db %3$c./Sully_%6$cd%3$c, 0%1$c%2$cfilename_tlp: db %3$c%6$cs.s%3$c, 0%1$c%2$ccmd_tlp: db %3$cnasm -g -f elf64 %6$c1$s && cc -Wall -Werror -Wextra -o %6$c2$s $(echo %6$c1$s | sed -r s/s/o/g) && rm $(echo %6$c1$s | sed -r s/s/o/g) && %6$c2$s%3$c, 0%1$c%2$cpermission: db %3$cw%3$c, 0%1$c%1$csection .rodata%1$c%2$csource_name: db __?FILE?__, 0%1$c", 0
	name: times 100 db 0
	filename: times 100 db 0
	cmd: times 200 db 0
	name_tlp: db "./Sully_%d", 0
	filename_tlp: db "%s.s", 0
	cmd_tlp: db "nasm -g -f elf64 %1$s && cc -Wall -Werror -Wextra -o %2$s $(echo %1$s | sed -r s/s/o/g) && rm $(echo %1$s | sed -r s/s/o/g) && %2$s", 0
	permission: db "w", 0

section .rodata
	source_name: db __?FILE?__, 0
