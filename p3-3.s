	.data
numpi:	.float	3.1415926
cuatro:	.float	4.0
tres: 	.float	3.0
str_1:	.asciiz	"Introduce un valor para el radio: "
str_2:	.asciiz	"El volumen de la esfera es: "

	.globl	__start
	.text
__start:
	#--precarga-de-variables--
	l.s		$f10,numpi			# cargamos Pi en f9
	l.s		$f8,cuatro			# cargamos 4 en f8
	l.s		$f6,tres			# cargamos 3 en f4
	#-------------------------
	la	$a0,str_1				# Mostramos str_1 por pantalla
	li	$v0,4					# Preparamos salida por pantalla de cadena
	syscall						# llamada al sistema
	la	$v0,6					# preparamos entrada de numero en flotante a f0
	syscall						# llamada al sistema
	
	mov.s	$f2,$f0 				# movemos f0 a f2 (radio)
	mul.s	$f4,$f2,$f2				# multiplicamos f2 por si mismo, y guardamos el valor en f4 (f6 al cuadrado)
	mul.s	$f4,$f4,$f2				# multiplicamos f4 (5 al cuadrado) por f2 (5), y guardamos el valor en f4 (f6 al cubo)

	mul.s	$f10,$f8,$f10				# multiplicamos 4 por pi y lo guardamos en f10
	mul.s	$f10,$f4,$f10				# multiplicamos 4 por pi por r al cubo (f4) y lo guardamos en f10
	div.s	$f10,$f10,$f6				# dividimos 4piRcubo entre 3
	la	$a0,str_2				# Mostramos str_3 por pantalla
	li	$v0,4					# Preparamos salida por pantalla de cadena
	syscall						# llamada al sistema
	mov.s	$f12,$f10				# movemos el resultado f9 a f12 para mostrarlo por pantalla
	la		$v0,2				# preparamos salida por pantalla de un flotante
	syscall						# llamada al sistema 
	li $v0,10					# Carga 10 en V0 para acabar el programa
	syscall						# Fin del programa
