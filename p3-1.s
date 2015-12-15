               .data 
str_1:	.asciiz   "Introduce un entero: "
str_2:	.asciiz   "Introduce un flotante: "
str_3:     .asciiz   "Introduce una cadena de caracteres: "
str_4:	.asciiz   "el entero escrito es: "
str_5:	.asciiz   "el flotante escrito es: "
str_6:     .asciiz   "la cadena escrita es: "
enter:	.asciiz	  " \n" 
              .align 2
dat_w:	.word     30,10,3002,-16340
dat_b:    .byte     5,2,10,-40
dat_f:    .float     0.032, 0.101e3, -2.3e-4

#  ------------------------------------------------------------------------
	.text
	.globl __start
__start:
	la	$a0,str_4	#Escribe en consola el entero "10" (tipo word).
	jal	put_str
	lw	$a0,dat_w+8
	jal	put_int
	la	$a0,enter
	jal	put_str

	la	$a0,str_4	#Escribe en consola el entero "-40" (tipo byte).
	jal	put_str
	li	$t0,1
	lb	$a0,dat_b($t0)
	jal	put_int
	la	$a0,enter
	jal	put_str

	la	$a0,str_5	#Escribe en consola el flotante "0.101e-3" (tipo float).
	jal	put_str	
	li	$t0,6
	l.s	$f12,dat_f+2($t0)
	jal	put_sfloat

	jal	fin

#  ------------------------------------------------------------------------

############# SUBRUTINAS DE CONSOLA ##################
put_int:
	li	$v0,1		#Escribe un entero en la consola.
	syscall
	jr	$31
#_______________________________________________________
put_sfloat:
	li	$v0,2		#Escribe un flotante simple en la consola.
	syscall
	jr	$31
#_______________________________________________________
put_str:
	li	$v0,4		#Escribe una cadena de texto en la consola.
	syscall
	jr	$31
#_______________________________________________________
get_int:			              #Lee un entero de la consola.
	li	$v0,5
	syscall
	jr	$31
#_______________________________________________________
get_sfloat:			#Lee un flotante simple de la consola.
	li	$v0,6
	syscall
	jr	$31

#_______________________________________________________
fin:	
	li	$v0,10		#Cierra consola y finaliza programa.
	syscall
