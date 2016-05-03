				.data
vector:			.space 400
cadena1:		.asciiz "Quants elements (n>=2) tindra el vector? \n"
cadena2:		.asciiz "Introdueix un enter positiu o negatiu? \n"
cadena3:		.asciiz "El minim del vector es "
cadena4:		.asciiz " i es troba la posicio "			
				.text
				.globl main
main:				li    $v0, 4					#Codi de crida al sistema per mostrar un string
					la    $a0, cadena1				#Carrega de la cadena1 al registre $a0 per mostrarla.
					syscall							#Mostra la frase de l'adreça cadena1
					li	  $v0, 5					#Codi de crida al sistema per llegir un enter
					syscall							#Espera un enter entrat per teclat
					add   $s0, $v0, $0				#Copia del valor entrat al registre $s0 (Emmagatzema la N!)
llegir:				li    $v0, 4					#Codi de crida al sistema per mostrar un string
					la    $a0, cadena2				#Carrega de la cadena1 al registre $a0 per mostrarla.
					syscall							#Mostra la frase de l'adreça cadena2
					li	  $v0, 5					#Codi de crida al sistema per llegir un enter
					syscall							#Espera un enter entrat per teclat
					sw $v0, vector($t1);			#Escriure el valor a l'adreça 'vector' (Espai reservat)
					addi   $t4, $t4, 1				#Incrementar el contador de lectura d'enters, determina quan s'atura la lectura
					addi  $t1, $t1, 4				#Increment de la direccio d'escriptura a memoria
					bne	  $t4, $s0, llegir			#Mentres que el contador($t4) no arribi al tope($s0), seguim llegint enters

reiniciarvariables:	li    $t4, 0					#Reinicialitzacio de el registres a utilitzar....
					li    $t1, 0			
					li	  $t2, 0			
					li	  $t3, 1					#Apuntador al minim		
								
					lw 	  $t5, vector($t1)			#Llegir el primer valor. En aquest registre sempre hi haura el valor minim
					addi  $t4, $t4, 1				#Increment del contador
carrega:			addi  $t1, $t1, 4				#Canvi de direccio per la cerca del seguent valor
					lw	  $t6, vector($t1)			#Llegir el segon valor
					addi  $t4, $t4, 1				#Increment del contador
					slt	  $t7, $t5, $t6				#Comparacio de valors. Si $t5 < $t6 --> $t7=1
					beq   $t7, $t2, inter			#Si el valor es 0..
					beq   $t4, $s0, mostraresultat	#Si hem recorregut tots el  elements del vector, saltem a l'adreça 'mostraresultat'
					bne	  $t7, $t2, carrega			#Si el resultat de la comparacio no es 0, saltem a l'adreça 'carrega'
				
inter:				move	  $t3, $t4					#Si no, intercambiem la posicio del menor per la del valor actual
					move  $t5, $t6					#Desem al registre $t5 el valor minim.
					beq   $t4, $s0, mostraresultat	#Si s'ha recorregut tot el vector, saltem a l'adreça 'mostraresultat' 
					j carrega						#Saltem a l'adreça 'carrega'

mostraresultat:		li    $v0, 4					#Codi de crida al sistema per mostrar un string
					la    $a0, cadena3				#Carrega de la cadena3 al registre $a0 per mostrarla.
					syscall							#Mostra la frase de l'adreça cadena3
					li  $v0, 1						#Codi de crida al sistema per mostrar un enter
					move $a0, $t5					#Movem el valor del registre $t5 (minim) a $a0 per ser mostrat
					syscall							#Mostra l'enter que hi ha a $a0
					li    $v0, 4					#Codi de crida al sistema per mostrar un string
					la    $a0, cadena4				#Carrega de la cadena4 al registre $a0 per mostrarla.
					syscall							#Mostra la frase de l'adreça cadena3
					li  $v0, 1						#Codi de crida al sistema per mostrar un enter
					move $a0, $t3				    #Movem del registre $t3 (posicio minim) a $a0 per ser mostrat
					syscall							#Mostra l'enter que hi ha a $a0
				.end main
