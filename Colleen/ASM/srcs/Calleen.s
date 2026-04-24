section .text
align 16

SYS_EXIT	equ 60

; This is one comment
global main

extern printf
extern exit

get_ptr:
	mov rax, text
	ret

main:
	call get_ptr
	mov rdi, rax
	mov rsi, 10
	mov rdx, 9
	mov rcx, 34
	mov r8, rax
	sub rsp, 8
	call printf
	; call exit(0)
	xor rdi, rdi
	call exit
	ret


section .rodata
	text: db "section .text%1$calign 16%1$c%1$cSYS_EXIT%2$cequ 60%1$c%1$c; This is one comment%1$cglobal main%1$c%1$cextern printf%1$cextern exit%1$c%1$cget_ptr:%1$c%2$cmov rax, text%1$c%2$cret%1$c%1$cmain:%1$c%2$ccall get_ptr%1$c%2$cmov rdi, rax%1$c%2$cmov rsi, 10%1$c%2$cmov rdx, 9%1$c%2$cmov rcx, 34%1$c%2$cmov r8, rax%1$c%2$csub rsp, 8%1$c%2$ccall printf%1$c%2$c; call exit(0)%1$c%2$cxor rdi, rdi%1$c%2$ccall exit%1$c%2$cret%1$c%1$c%1$csection .rodata%1$c%2$ctext: db %3$c%4$s%3$c, 0%1$c", 0
