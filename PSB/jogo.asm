%include "asm_io.inc"
		
segment .data

segment .bss

sequencia	resb	10
n		resd	1
vitorias	resd	1
posicao		resd	1		;elemento que estamos tratando na pilha
primeiro	resd	1
galho		resd	1
qtdp		resd	1

segment .text
        global  _asm_main

vira_antes:
					
	enter   0,0 

	add	edx,12			;verifica elemento anterior
	mov	eax,edx
	mov	eax,[ebp+edx]		
	
	cmp	al,'P'
	je	troca_B1
	cmp	al,'B'
	je	troca_P1
	jmp	fim_vira1
	troca_B1:
		mov	eax,'B'
		mov	[ebp+edx],eax
		jmp	fim_vira1
	troca_P1:
		mov	eax,'P'
		mov	[ebp+edx],eax

	
	fim_vira1:
		sub	edx,12	
		leave
ret

vira_depois:
					
	enter   0,0 

	add	edx,4			;verifica elemento próximo
	mov	eax,edx
	mov	eax,[ebp+edx]		
	
	cmp	al,'P'
	je	troca_B2
	cmp	al,'B'
	je	troca_P2
	jmp	fim_vira2
	troca_B2:
		mov	eax,'B'
		mov	[ebp+edx],eax
		jmp	fim_vira2
	troca_P2:
		mov	eax,'P'
		mov	[ebp+edx],eax

	
	fim_vira2:
		sub	edx,4	
		leave
ret

_asm_main:

        enter   0,0  			;padrão             

	call	read_int
	mov	[n],eax
	mov	ebx,[n]			;guardando meu n

	dec	eax
	add	eax,ebx
	mov 	ecx,eax			;manipulação para ler entrada(Letras + Espacos)

	call	read_char		; para capturar o enter

	mov	eax,0
	mov	ebx,eax
	mov	edx,eax
	mov	[galho],eax
	mov	[qtdp],eax
	mov	[vitorias],eax		;iniciando variaveis

	cmp	ecx, 1
	jne	vetor
	
n_um:
	call	read_char
	cmp	al, 'P'
	jne	end
	base_p:
		mov	eax, 1
		mov	[vitorias],eax
jmp	end	

				
vetor:
	call	read_char
	cmp	al,' '
	je	espaco
	cmp	al,'P'
	jne	coloca_vetor
	inc	edx
	coloca_vetor:
	mov	[sequencia + ebx],al
	inc	ebx
	espaco:
loop	vetor				; formo um vetor permanente que conterá minha entrada

mov	[qtdp],edx
	
reempilhar:				;caso precise empilhar com seq original
	mov	ecx,[n]
	mov	ebx,0
empilhar:
	mov	edx,[sequencia + ebx]
	push	edx
	inc ebx
loop empilhar

config_galho:
	mov	ebx,[galho]
	cmp	ebx,0	
	je	pri_el
	mov	edx,0
	mov	ebx,[galho]
	mov	ecx,[n]
	dec	ecx
	sub	ecx,ebx
	achar_elemento:				
	add	edx,2
	loop achar_elemento
	imul	edx,2
	jmp	elemento


pri_el:
	mov	edx,0
	mov	ecx,[n]	
	dec	ecx

primeiro_elemento:				
	add	edx,2
loop primeiro_elemento
	imul	edx,2
	mov	[primeiro],edx
	jmp	elemento

prox_elemento:
	mov	edx,[posicao]
	sub	edx,4
	cmp	edx,0
	jl	verificacao	

elemento:				;pegando um elemento da pilha
	mov	[posicao],edx
	mov	eax,0			;zerando EAX pra evitar problemas
	mov	eax,[esp + edx] 
	cmp	al,'P'			;CMP SÓ FUNCIONA COM AL
	jne	prox_elemento
	mov	eax,'X'
	mov	[esp + edx],eax 	;troco o P por X
	call	vira_depois
	call	vira_antes
	jmp	prox_elemento

verificacao:				;verifico se ainda tenho P na pilha
	mov	edx,[primeiro]
	mov	ecx,[n]
	lp1:
		mov	eax,[esp + edx]
		;call	print_char	;TESTE
		cmp	al,'P'
		jne	fim_lp1
		mov	edx,[primeiro]
		jmp	elemento
		fim_lp1:
		sub	edx,4
	loop lp1

;mov	eax,3		;teste
;call	print_int	;teste	

desempilha:
	mov	ecx,[n]
	lp2:
		pop	ebx
		cmp	bl,'B'
		je	prox_galho
	loop lp2
venci:
	mov	eax,1
	add	[vitorias],eax

prox_galho:
	mov	eax,[qtdp]
	cmp	eax,0
	je	end
	mov	ebx,[galho]
	inc	ebx
	mov	[galho],ebx
	cmp	eax,ebx
	je	end
	jmp	reempilhar

end:
	
	mov	eax, [vitorias]
	call	print_int
	call print_nl

        mov     eax, 0			;padrão          
        leave                     
        ret
