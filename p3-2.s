	.data	
txt_1:	.asciiz "Introduce una cadena de caracteres: \n"
txt_2:	.asciiz "\n Introduce otra cadena de caracteres: \n"
	
	
	.text	
	.globl __start 
__start:
	la	$a0,txt_1		# Mostramos txt_1 por pantalla
	li	$v0,4			# Preparamos salida por pantalla de cadena
	syscall				# llamada al sistema
	li	$a0,0x10010100		# cargamos 0x10010100 en a0 para que el codigo se guarde a partir de esa direccion
	li	$a1,11			# cargamos 11 en a1, ya que si ponemos 10 solo dejaria al usuario introducir 9 caracteres
	jal get_cad			# JAL, saltamos a get_cad para obtener una cadena de texto
	la	$a0,txt_2		# Mostramos txt_2 por pantalla
	li	$v0,4			# Preparamos salida por pantalla de cadena
	syscall				# llamada al sistema
	li	$a0,0x10010200		# cargamos 0x10010200 en a0 para que el codigo se guarde a partir de esa direccion
	li	$a1,21			# cargamos 21 en a1, ya que si ponemos 20 solo dejaria al usuario introducir 19 caracteres
	jal	get_cad			# JAL, saltamos a get_cad para obtener una cadena de texto
	li	$v0,10			# Cierra consola y finaliza programa.
	syscall				# llamada al sistema

get_cad:				# obtener cadena
	li	$v0,8			# cargamos 8 en v0 para obtener una cadena de caracteres
	syscall				# llamada al sistema
	jr $31				# vuelta a rutina principal
