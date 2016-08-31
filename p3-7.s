		.data
str_0:		.asciiz	"Introduce entero k por consola: \n"
str_1:		.asciiz "Caso 0 seleccionado. Ejecutando... \n"
str_2:		.asciiz "Caso 1 seleccionado. Ejecutando... \n"
str_3:		.asciiz "Caso 2 seleccionado. Ejecutando... \n"
str_4:		.asciiz "Caso 3 seleccionado. Ejecutando... \n"
str_5:		.asciiz "El valor de C es: "
str_6:		.asciiz "ERROR. ELIJA UN CASO DEL 0 al 3. Reiniciando... \n \n"
enter:		.asciiz "\n \n"
		.text
		.globl __start
__start:
	li	$t6,5				#cargamos a(5) en t6
	li	$t7,2				#cargamos b(2) en t7
	li	$t1,3				#Numero de casos - 1
	li	$t2,20				#20 ya que en este caso se da cada 14 en hex. (20 en dec.) cuando hay una nueva etiqueta L0,L1,L2...
	la	$a0,str_0			#Introduce k	
	jal put_str				#JAL, salta a Escribir Cadena
	jal read_int				#JAL, salta a Leer Entero
	move $t4,$2				#Mueve de $2 a t4 para continuar la ejecucion
	
	slt	$s0,$t4,$0			#compara k con limite inferior 0
	bne	$s0,$0,finalt			#Si k < 0 salta a fin
	sgt	$s0,$t4,$t1			#compara k con limite superior+1
	bne $s0,$0,finalt			#si k>4, salta a fin
	
	mul $t5,$t4,$t2				#multiplicamos k por 20, ya que las direcciones de la tabla de salto se dan cada 20 (14 en hex.)
	la $t3,L0				#cargamos la direccion de memoria de L0 para usarla de base
	add $t3,$t3,$t5				#sumamos el valor de la multiplicacion de k por 20 a la dir. base. 
	jr $t3					#saltamos a la direccion deseada
	
L0:	la	$a0,str_1			#L0: muestra por pantalla la eleccion de caso y hace la suma de L6 y L7
	jal put_str				#JAL, salta a Escribir Cadena
	add	$t8,$t6,$t7			#Suma t6 y t7 y guarda el resultado en t8
	j	Fin				#J, salta a Fin
L1:	la	$a0,str_2			#L1: muestra por pantalla la eleccion de caso y hace la resta de L6 y L7
	jal put_str				#JAL, salta a Escribir Cadena
	sub	$t8,$t6,$t7			#Resta t6 y t7 y lo guarda en t8
	j	Fin				#J, salta a Fin
L2:	la	$a0,str_3			#L2: muestra por pantalla la eleccion de caso y hace la multiplicacion de L6 y L7
	jal put_str				#JAL, salta a Escribir Cadena
	mul	$t8,$t6,$t7			#Hace el or logico de t6 y t7 y lo guarda en t8
	j	Fin				#J, salta a Fin
L3:	la	$a0,str_4			#L3: muestra por pantalla la eleccion de caso y hace el AND & de L6 y L7
	jal put_str				#JAL, salta a Escribir Cadena
	and	$t8,$t6,$t7			#Hace el and logico de t6 y t7 y lo guarda en t8
	j	Fin				#J, salta a Fin

Fin:						#Final: Muestra el valor de C y finaliza el programa
	la	$a0,str_5			#carga str_5 para mostrarlo por pantalla
	jal put_str				#JAL, salta a Escribir Cadena
	move $a0,$t8				#Mueve el valor de las operaciones de t8 a a0 para escribirlo en pantalla
	jal put_int				#JAL, salta a Escribir entero
	la	$a0,enter			#Escribimos 2 saltos de linea para evitar que se junten al reiniciar el programa
	jal put_str				#JAL, salta a Escribir Cadena
	li $v0,10				#Carga 10 en V0 para acabar el programa
	syscall					#Fin del programa
	
finalt:						#Final Alternativo: Muestra error por pantalla y reinicia el programa
	la	$a0,str_6			#Carga str_6 para mostrarlo por pantalla
	jal put_str				#JAL, salta a Escribir Cadena
	j	__start				#J, vuelve al __start
	
#______________________________________________________________	
	
put_int:
	la	$v0,1				#escribe entero
	syscall					#llamada al sistema
	jr $31					#vuelve a la rutina principal
	
put_str:
	la	$v0,4				#escribe cadena de texto
	syscall					#llamada al sistema
	jr $31					#vuelve a la rutina principal

read_int:
	la	$v0,5				#lee entero de consola
	syscall					#llamada al sistema
	jr $31					#vuelve a la rutina principal
