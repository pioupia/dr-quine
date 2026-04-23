section .text
align 16

global main

extern sprintf
extern fopen
extern fprintf
extern fclose
extern system
extern exit

main:
	mov rbp, rsp

	mov rcx, 5
	cmp rcx, 0
	jle .exit

	dec rcx

	push rcx

	lea rdi, qword [name]
	lea rsi, qword [name_tlp]
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
	buffer: db "section .text%1$calign 16%1$c%1$cglobal main%1$c%1$cextern sprintf%1$cextern fopen%1$cextern fprintf%1$cextern fclose%1$cextern system%1$cextern exit%1$c%1$cmain:%1$c%2$cmov rbp, rsp%1$c%1$c%2$cmov rcx, %4$d%1$c%2$ccmp rcx, 0%1$c%2$cjle .exit%1$c%1$c%2$cdec rcx%1$c%1$c%2$cpush rcx%1$c%1$c%2$clea rdi, qword [name]%1$c%2$clea rsi, qword [name_tlp]%1$c%2$cmov rdx, rcx%1$c%2$ccall sprintf%1$c%1$c%2$cmov rdi, filename%1$c%2$cmov rsi, filename_tlp%1$c%2$cmov rdx, name%1$c%2$ccall sprintf%1$c%1$c%2$cmov rdi, cmd%1$c%2$cmov rsi, cmd_tlp%1$c%2$cmov rdx, filename%1$c%2$cmov rcx, name%1$c%2$ccall sprintf%1$c%1$c%2$cmov rdi, filename%1$c%2$cmov rsi, permission%1$c%2$ccall fopen%1$c%1$c%2$cpop r9 ; i - 1%1$c%1$c%2$cpush rax%1$c%1$c%2$cmov rdi, rax%1$c%2$cmov rsi, buffer%1$c%2$cmov rdx, 10%1$c%2$cmov rcx, 9%1$c%2$cmov r8, 34%1$c%1$c%2$cmov r10, 37%1$c%2$cpush r10%1$c%2$cpush rsi%1$c%2$cxor rax, rax%1$c%2$ccall fprintf%1$c%1$c%2$cadd rsp, 16%1$c%2$cpop rdi%1$c%2$ccall fclose%1$c%1$c%2$cadd rsp, 8%1$c%2$cmov rdi, cmd%1$c%2$ccall system%1$c%1$c.exit:%1$c%2$cxor rdi, rdi%1$c%2$ccall exit%1$c%2$cpop rbp%1$c%2$cret%1$c%1$csection .data%1$c%2$calign 16%1$c%2$cbuffer: db %3$c%5$s%3$c, 0%1$c%2$cname: times 100 db 0%1$c%2$cfilename: times 100 db 0%1$c%2$ccmd: times 200 db 0%1$c%2$cname_tlp: db %3$c./Sully_%6$cd%3$c, 0%1$c%2$cfilename_tlp: db %3$c%6$cs.s%3$c, 0%1$c%2$ccmd_tlp: db %3$cnasm -g -f elf64 %6$c1$s && cc -Wall -Werror -Wextra -o %6$c2$s $(echo %6$c1$s | sed -r s/s/o/g) && %6$c2$s%3$c, 0%1$c%2$cpermission: db %3$cw%3$c, 0%1$c%1$c", 0
	name: times 100 db 0
	filename: times 100 db 0
	cmd: times 200 db 0
	name_tlp: db "./Sully_%d", 0
	filename_tlp: db "%s.s", 0
	cmd_tlp: db "nasm -g -f elf64 %1$s && cc -Wall -Werror -Wextra -o %2$s $(echo %1$s | sed -r s/s/o/g) && %2$s", 0
	permission: db "w", 0

