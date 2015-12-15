	.data
str_1:	.asciiz	"Introduce entero (A) por consola: "
str_2:	.asciiz "Introduce entero (B) por consola: "
str_3:	.asciiz "El valor de D es: "
novale: .asciiz "El valor de D no coincide con C. Reiniciando! \n \n"
newlin: .asciiz "\n \n"

	.globl	__start
	.text
__start:
	la	$a0,str_1			# Mostramos str_1 por pantalla
	li	$v0,4				# Preparamos salida por pantalla de cadena
	syscall					# llamada al sistema
	la	$v0,5				# prepara entrada de un entero
	syscall					# llamada al sistema
	move $a1,$v0			# mueve el contenido de $v0 a $a1
	la	$a0,str_2			# Mostramos str_2 por pantalla
	li	$v0,4				# Preparamos salida por pantalla de cadena
	syscall					# llamada al sistema
	la	$v0,5				# prepara entrada de un entero
	syscall					# llamada al sistema
	move $a2,$v0			# mueve el contenido de $2 a $a2
	
	ble 	$a1,$a2,continu	# si a1 es menor que a2 no coinciden salta a continu
	mul		$a3,$a1,$a2		# multiplica a1 (a) y a2 (b) y guarda en a3 (c)
	j		continu			# salta a compare					
	
continu:					# restamos A menos C, y despues comparamos si D=C
	sub $t7,$a1,$a3			# restamos A menos C y guardamos e t7 (d)
	bne	$a3,$t7,reiniciar	# branch if not equal, salta si a3 (c) es distinto de t7 (d)
	la	$a0,str_3			# Mostramos str_3 por pantalla
	li	$v0,4				# Preparamos salida por pantalla de cadena
	syscall					# llamada al sistema
	move $a0,$t7			# movemos $a3 a $a0 para mostrarlo
	li	$v0,1				# Preparamos salida por pantalla de un entero
	syscall					# llamada al sistema
	la	$a0,newlin			# Mostramos una linea en blanco por pantalla
	li	$v0,4				# Preparamos salida por pantalla de cadena
	syscall					# llamada al sistema
	j __start				# reiniciamos el programa
	
reiniciar:					# mostramos mensaje de error y reiniciamos el programa
	la	$a0,novale			# Mostramos novale por pantalla
	li	$v0,4				# Preparamos salida por pantalla de cadena
	syscall					# llamada al sistema
	j __start				# reiniciamos el programa