section .text
align 16

global main

extern fopen
extern fclose
extern fprintf
extern exit

%macro open_file 0
	mov rdi, filename
	mov rsi, permission
	call fopen
	push rax
%endmacro

%macro print 0
	open_file
	mov rdi, rax
	mov rsi, text
	mov rdx, 10
	mov rcx, 9
	mov r8, 34
	mov r9, 37
	push rsi
	call fprintf
	pop rsi
	pop rdi
	call fclose
%endmacro

%macro main_func 0
main:
	sub rsp, 8
	print
	xor rdi, rdi
	call exit
	ret
%endmacro

; main function
main_func

section .rdata
	filename: db "./Grace_kid.s", 0
	permission: db "w", 0
	text: db "section .text%1$calign 16%1$c%1$cglobal main%1$c%1$cextern fopen%1$cextern fclose%1$cextern fprintf%1$cextern exit%1$c%1$c%4$cmacro open_file 0%1$c%2$cmov rdi, filename%1$c%2$cmov rsi, permission%1$c%2$ccall fopen%1$c%2$cpush rax%1$c%4$cendmacro%1$c%1$c%4$cmacro print 0%1$c%2$copen_file%1$c%2$cmov rdi, rax%1$c%2$cmov rsi, text%1$c%2$cmov rdx, 10%1$c%2$cmov rcx, 9%1$c%2$cmov r8, 34%1$c%2$cmov r9, 37%1$c%2$cpush rsi%1$c%2$ccall fprintf%1$c%2$cpop rsi%1$c%2$cpop rdi%1$c%2$ccall fclose%1$c%4$cendmacro%1$c%1$c%4$cmacro main_func 0%1$cmain:%1$c%2$csub rsp, 8%1$c%2$cprint%1$c%2$cxor rdi, rdi%1$c%2$ccall exit%1$c%2$cret%1$c%4$cendmacro%1$c%1$c; main function%1$cmain_func%1$c%1$csection .rdata%1$c%2$cfilename: db %3$c./Grace_kid.s%3$c, 0%1$c%2$cpermission: db %3$cw%3$c, 0%1$c%2$ctext: db %3$c%5$s%3$c, 0%1$c", 0
