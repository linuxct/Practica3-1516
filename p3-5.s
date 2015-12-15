	.data
comas: .asciiz ", "
	.text
	.globl __start

__start:
	li $a1,0				#Empezamos por el 0

bucle:
	add $a1,$a1,1			#Suma de una ud. a a1
	add $a0,$a1,0			#Movemos de a1 a a0 con un add
	jal	put_int				#JAL, saltamos a put_int (escribir_integer)
	beq $a1,15,fin			#Si a1 vale 15 finalizamos el programa - Repeat Until
	la 	$a0,comas			#Cargamos las comas en a0 para mostrarlo por pantalla
	jal put_str				#JAL, saltamos a put_str (escribir_string)
	j	bucle				#Volvemos a empezar el bucle

put_str:
	li	$v0,4				#Cargamos 4 para mostrar una cadena
	syscall					#llamada al sistema
	jr $31					#volvemos a rutina principal

put_int:
	li	$v0,1				#Cargamos 1 para mostrar un entero
	syscall					#llamada al sistema
	jr $31					#volvemos a rutina principal

fin:
	li	$v0,10				#Cargamos 10 para finalizar el programa
	syscall 				#llamada al sistema