%include "asm_io.inc"

segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter a number: ", 0       ; don't forget nul 
prompt2 db    "Enter another number: ", 0
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    " The sum of these is ", 0
outmsg4 db    " The sub of these is ", 0
outmsg5 db    " The mul of these is ", 0
outmsg6 db    " The div of these is ", 0
outmsg7 db    " The rest of these is ", 0


segment .text
        global  _asm_main
_asm_main:
        enter   0,0               


        mov     eax, prompt1      
        call    print_string

        call    read_int          
        mov     ecx, eax          

        mov     eax, prompt2      
        call    print_string

        call    read_int          
        mov     edx, eax          

;imprimindo o basico  ecx ta com a entrada 1 edx com entrada 2

        mov     eax, outmsg1
        call    print_string      
        mov     eax, ecx     
        call    print_int         
        mov     eax, outmsg2
        call    print_string      
        mov     eax, edx
        call    print_int         
	   call    print_nl          

;fazendo a operacao soma

        mov     eax, ecx     
        add     eax, edx     

        mov     ebx, eax     
        mov     eax, outmsg3
        call    print_string      
        mov     eax, ebx
        call    print_int         

;
;fazendo a operacao subtracao
;

	mov     eax, ecx     
     sub     eax, edx     
     mov     ebx, eax     
	
     call    print_nl          
	mov     eax, outmsg4
     call    print_string      
     mov     eax, ebx
     call    print_int         

;
;fazendo a operacao multiplicacao
;

	mov     eax, ecx     
     imul    eax, edx     
     mov     ebx, eax     
	
     call    print_nl          
	mov     eax, outmsg5
     call    print_string      
     mov     eax, ebx
     call    print_int         

;
;fazendo a operacao divisao
;
	mov     ebx, edx     
	mov     eax, ecx     
	cdq
     idiv     ebx          
	mov     ebx, eax	

     call    print_nl          
	mov     eax, outmsg6
     call    print_string      
     mov     eax, ebx
     call    print_int         
     call    print_nl          
	mov     eax, outmsg7
     call    print_string      
	mov     eax, edx
     call    print_int         

;complemento

	call    print_nl          ; print new-line
      mov     eax, 0            ; return back to C
      leave                     
      ret


