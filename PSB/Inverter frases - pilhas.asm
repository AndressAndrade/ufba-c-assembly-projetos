%include "asm_io.inc"

segment .data

prompt1 db	"Entrada: ", 0      
outmsg1 db	"Saida:",   0


segment .bss

vetor	resb	30
 
segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine

	mov	eax,prompt1
	call 	print_string

;ler o texto
	
	mov	edi,vetor
	mov	ebx,0
	mov	ecx,31
	cld
	lp:
		call	read_char
		cmp	al,'.'
		je	fim_leitura
		inc	ebx
		stosb
	loop	lp

fim_leitura:

	inc	ebx
	stosb                     ;armazena ponto
	mov	eax,outmsg1
	call	print_string

;---------------------------------------inverte

	mov	ecx,ebx
	mov	esi,vetor
	cld
verifica:
	mov	edx,0
	lp1:
		lodsb
		cmp	al,' '
		je	fim_palavra
		cmp	al,'.'
		je	fim_texto
		movzx	eax,al
		push	eax
		inc	edx
	loop lp1

fim_palavra:

	mov	al,' '
	call	print_char
	mov	ecx,edx
	lp2:
		pop	eax
		call	print_char
	loop lp2
	
	jmp verifica
	
fim_texto:

	mov	al,' '
	call	print_char
	mov	ecx,edx
	lp3:
		pop	eax
		call	print_char
	loop lp3

fim:

	call	print_nl
        mov     eax, 0            ; return back to C
        leave                     
        ret

