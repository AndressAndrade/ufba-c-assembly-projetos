;Andressa Silva Valente de Andrade

%include "asm_io.inc"

segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter a binary with 8bits: ", 0       
outmsg1 db    "Decimal: ", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine


        mov     eax, prompt1      ; print out prompt
        call    print_string

	mov	ebx,0
	mov	ecx,8
	lp:
		call read_char
		shl ebx,1
		cmp al,"1"
		je proximo
		jmp end
	
	proximo:
		inc ebx
	
	end:
	loop lp
	



        mov     eax, outmsg1
        call    print_string
	
        mov     eax, ebx
        call    print_int
 

	call    print_nl          ; print new-line
        mov     eax, 0            ; return back to C
        leave                     
        ret


