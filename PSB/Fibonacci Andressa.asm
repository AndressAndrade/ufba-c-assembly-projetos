
%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;

prompt1 db    "Enter a number: ", 0       
outmsg1 db    "You entered ", 0
outmsg2 db    "The fibonacci is ", 0


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
  var1    resd 1

;
; code is put in the .text segment
;
segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine

;Guardando o nosso n

        mov     eax, prompt1      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     ecx, eax          ; guarda a entrada em ecx

;Calculando a sequencia Fibonacci

	cmp	ecx, 0            ; comparo minha entrada com 0          
	je      fibozero
	cmp	ecx, 1		  ; comparo minha entrada com 1   
	je      fiboum
	jmp     fibonacci         ; encaminho meu valor para o 
 
	fibozero:
		mov	ebx, 0
		jmp	imprime
	fiboum:
		mov	ebx, 1
		jmp	imprime
	fibonacci:
   		mov	eax, 0 ;movo o valor de fibozero para eax
		mov	ebx, 1 ;movo o valor de fiboum pra ebx
		mov	edx, 1 ;meu contador inicia em 1
		antes:
		cmp	edx,ecx
		jb	depois	
		mov	ebx,[var1] ;movo o resultado para ebx
		jmp imprime
		depois:
		add	eax,ebx;adiciono os dois
		mov  [var1],eax
		mov	eax,ebx
		mov	ebx,[var1]
		inc	edx
		jmp	antes
		

;
; next print out result message as series of steps
;
	imprime:
        	mov     eax, outmsg1
        	call    print_string      ; Voce entrou:
        	mov     eax, ecx    
		call    print_int         ; Imprime entrada
		call    print_nl          ; print new-line
        	mov     eax, outmsg2
        	call    print_string      ; O fibonacci é
        	mov     eax, ebx
        	call    print_int         ; resultado du fibonacci
        	call    print_nl          ; print new-line


        mov     eax, 0            ; return back to C
        leave                     
        ret


