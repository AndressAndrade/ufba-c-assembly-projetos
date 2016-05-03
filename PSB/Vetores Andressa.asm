%include "asm_io.inc"

segment .data

prompt1 db    "Primeiro vetor: ", 0       
prompt2 db    "Segundo vetor: ", 0
outmsg1 db    "Saida: ", 0
outmsg2 db    " ", 0

segment .bss

vet1	resd 5
vet2	resd 5
var1	resd 1
var2	resd 1

segment .text
        global  _asm_main
_asm_main:
	
	enter   0,0               

;formando o vetor 1
	mov	eax, prompt1      
	call	print_string
	mov	ebx,0
	mov	ecx,5
	vetor1:
		call	read_int
		mov	[vet1+ebx*4],eax
		inc	ebx
	loop vetor1

;formando vetor 2
	mov	eax, prompt2      
	call	print_string
	mov	ebx,0
	mov	ecx,5
	vetor2:
		call	read_int
		mov	[vet2+ebx*4],eax
		inc	ebx
	loop vetor2

;imprimindo saida
	call	print_nl
	mov	eax, outmsg1     
	call	print_string

;comecando comparacao
	mov	ebx,0
	mov	ecx,6
	mov	eax,0
	mov	[var1],eax

	elvet1:       ;pego um elemento de vet1
		mov	eax,[vet1+ebx*4]
		mov	ebx,0
	loop lsvet2


	lsvet2:       ;comparo com os elementos de vet2
		mov	edx,[vet2+ebx*4]
		cmp	eax,edx
		je	imprime
		inc	ebx
	loop lsvet2
	

	mov	eax,[var1]
	inc	eax
	mov	[var1],eax
	mov	ebx,[var1]
	mov	ecx,6
	cmp	ebx,5
	je	end
	jmp	elvet1


	imprime:
		call	print_int;
		mov	[var2],eax
		mov     eax,outmsg2
		call	print_string
		mov	eax,[var2]
		inc	ebx
		inc	ecx
	loop lsvet2
			
    		      
	end:			  ;complemento

	call    print_nl          ; print new-line
	mov     eax, 0            ; return back to C
	leave                     			
	ret


