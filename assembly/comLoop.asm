# progama acha o maximo divisor comum entre dois nummeros 
# passados como paramentro ao procedimento

# Main:
# 	- realiza a leitura dos dois numeros e passa como argumento ao procedimento
#	- imprime o valor maximo do divisor (retornado do procedimento)
# Procedimento:
#	- utilizar $s e preservalos

.data
msg1: .asciiz "Entre o primeiro numero: "
msg2: .asciiz "Entre o segundo numero: "
msg3: .asciiz "O Maior divisor comum é "

.text

main: 
	li $v0, 4
	la $a0, msg1
	syscall             	# print msg1
	li $v0, 5
    	syscall             	# read an int
    	add $t0, $v0, $zero 	# move to $t0
    	
    	li $v0, 4		
	la $a0, msg2
	syscall             	# print msg2
	li $v0, 5
    	syscall             	# read an int
    	add $t1, $v0, $zero 	# move to $t1
    	
    	
    	add $a0, $t0, $zero	# set x as argument a0
    	add $a1, $t1, $zero	# set y as argument a1
    	jal mdc			# call mdc
    	
   
    	add $a1, $v0, $zero
    	
    	li $v0, 4		
	la $a0, msg3
	syscall             	# print msg2
	
	add $a0, $a1, $zero
    	li $v0, 1
    	syscall 
    	
    	li $v0, 10
    	syscall 
    	
    	
mdc:
	# int proc_mdc(int x, int y) {
	#   while (x != y) {
	#     if (x < y) 
	#       y = y - x;
	#     else 
	#       x = x - y; 
	#   }
	#   return x; 
	# }
	
	add $s0, $a0, $zero	# s0 = x
    	add $s1, $a1, $zero	# s1 = y
	
	Loop:
	add $v0, $s0, $zero
	
	beq $s0, $s1, exit	# if (x == y) exit
	blt $s0,$s1, x_lt_y	# if x < y goto x_tl_y
	
	sub $s0, $s0, $s1	# x = x - y
	j Loop
	
	x_lt_y:
	sub $s1, $s1, $s0	# y = y - x
	j Loop
	
	exit:
	jr $ra
	
	