	.data
comas: .asciiz ", "
	.text
	.globl __start
	
__start:
	li $t0,'@' 				# Cargamos el numero anterior a la A, la @ = 64
	li $t8,1				# Cargamos un 1 para compararlo mas tarde
	li $t7,88				# Cargamos un 88 (X) para compararlo mas tarde

bucle: 
	sgt $t9,$t0,$t7				# Mientras t0 sea menor o igual que X (t7=88=X), ejecutara el resto del codigo de abajo // estructura While {} do.
	beq $t9,$t8,ultletra 			# Salta a UltLetra (Ultima Letra) si hemos llegado a la Y (t8=t9=1), para evitar sacar una coma extra por pantalla
	add $t0,$t0,1 				# a = a+1
	move $a0,$t0				# copia a en a0 para salida por pantalla
	jal print_ascii				# JAL, salta a print_ascii para escribir por pantalla.
	la	$a0,comas			# cargamos la coma en a0 para mostrarla
	jal print_str				# JAL, salta a print_str para escribir por pantalla.
	j bucle 				# salta a bucle

ultletra:					# pintamos el ultimo numero sin coma final
	add $t0,$t0,1				# a = a+1
	move $a0,$t0				# copia a en $a0 para salida por pantalla
	jal print_ascii				# JAL, salta a print_ascii para escribir por pantalla.
	j salir					# J, salta a salir
	
salir: 
	li $v0,10				# Carga 10 en V0 para acabar el programa
	syscall 				# llamada al sistema
	
print_ascii:
	li	$v0,11	 			# Carga 11 en V0 para escribir caracteres ASCII por pantalla
	syscall					# llamada al sistema
	jr	$31				# vuelta a la ejecucion del programa
	
print_str:
	li	$v0,4	 			# Carga 4 en V0 para escribir una cadena por pantalla
	syscall					# llamada al sistema
	jr	$31				# vuelta a la ejecucion del programa
