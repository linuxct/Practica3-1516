.globl __start
	
__start:
	li $t0,44				#44=Coma
	sb $t0,0x10020001			#Coma->0x10020001, justo al lado de 0x10020000, que es el numero a mostrar
	li $t0,32				#44=Espacio
	sb $t0,0x10020002			#Espacio->0x10020002, justo al lado de 0x10020001 y 0x10020000, que es el numero a mostrar
	li $t0,64				#64=@, el caracter antes de la A
	sb $t0,0x10020000			#64->0x10020000
	la $a0,0x10020000			#Cargamos la direccion 0x10020000 en a0 para mostrarla por pantalla, equivalente a #la $a0,0x10020000+0x10020001

bucle: 
	add $t0,$t0,1 				#a = a+1
	sb $t0,0x10020000			#t0->0x10020000
	beq $t0,90,ultletra 			#Salta a UltLetra (Ultima Letra) si hemos llegado a la Z (90), para evitar sacar una coma extra por pantalla
	jal put_str				#JAL, saltamos a put_str (escribir_string)
	j bucle 				#salta a bucle

ultletra:					#en esta funcion escribimos la ultima letra sin coma final
	li 	$t1,0				#cargamos 0 en t1
	sb 	$t1,0x10020001			#al cargar 0 en 0x10020001, eliminamos la coma que teniamos anteriormente guardada (44)
	sb 	$t1,0x10020002			#al cargar 0 de nuevo en 0x10020002, eliminamos el espacio que teniamos anteriormente guardado (32)
	jal put_str				#JAL, saltamos a put_str (escribir cadena) // aprovechamos que ya teniamos cargada de antes la direccion 0x10020000 en a0, si no, habria que cargarla previamente
	j fin					#Jump a fin

#-------------------

put_str:
	li	$v0,4				#Cargamos 4 para mostrar una cadena
	syscall					#llamada al sistema
	jr $31					#volvemos a rutina principal
fin:
	li	$v0,10				#Cargamos 10 para finalizar el programa
	syscall 				#llamada al sistema
