;Andressa Silva Valente de Andrade

%include "asm_io.inc"

segment .data

prompt1		db	"Enter a number: ", 0       ; don't forget nul terminator
prompt2 	db	"Enter a sequence: ", 0
outmsg1 	dd	"The code: ", 0		

segment .bss

seq		resb	10
code		resb	10
 
segment .text
        global  _asm_main
_asm_main:
        enter   0,0              


	;formando o vetor sequencia-------------------------------------------
	mov	eax, prompt2	  ; entre um vetor de 10 caracteres      
	call	print_string
	
	;mov	esi,seq
	mov	esi,0
	mov	ecx,10
	

	seq1:
		call	read_char
		mov	[seq+esi],al
		inc	esi	
	loop seq1

	;pegando o numero n----------------------------------------------------
        mov     eax, prompt1      ; entre um numero n
        call    print_string
	
        call    read_int          ; lê inteiro
        mov     dl, al     	  ; guarda numero n


	;codificador-----------------------------------------------------------
	mov	ebx,0
	mov	edi,0
	mov	ecx,10

	seq2:
		mov	al,[seq+ebx]
		add	al,dl
		cmp	al,90
		ja	tratar
		mov	[code+edi],al
		inc	ebx
		inc	edi	
	loop seq2
	
	jmp end			   ;QUANDO ACABAR DE CODIFICAR
	
	tratar:
		sub	al,90
		add	al,64      ;volta para o inicio do alfabeto
		mov	[code+edi],al
		inc	ebx
		inc	edi
	loop seq2

	;imprimindo saida------------------------------------------------------
	end:
	mov	eax, outmsg1     
	call	print_string
	
	mov	eax, code
	call 	print_string


	;       fim
        mov     eax, 0            ; return back to C
        leave                     
        ret