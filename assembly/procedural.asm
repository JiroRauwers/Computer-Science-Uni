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
    	
    	
    	add $a0, $t0, $zero	
    	add $a1, $t1, $zero
    	jal rec_mdc		# call rec_mdc
    	
    	add $a0, $v0, $zero
    	li $v0, 1
    	syscall 
    	
    	li $v0, 10
    	syscall 
    	
    	
rec_mdc:
	# x = s0, y = s1
	# int rec_mdc(int x, int y) { 
	#   if(x==y)
	#     return x;
	#   else if (x < y) 
	#     return rec_mdc(x, y-x);
	#   else 
	#     return rec_mdc(x–y, y); }
	
	
	#save in stack
    	addi $sp, $sp, -12 
    	sw   $ra, 0($sp)	# return address
    	sw   $s0, 4($sp)	# save s0 because of recursion
    	sw   $s1, 8($sp)	# save s1 because of recursion
    	
    	add $s0, $a0, $zero	# s0 = x
    	add $s1, $a1, $zero	# s1 = y
    	
    	beq $s0, $s1, returnx	# if(x==y) return x
    	
    	blt $s0, $s1, x_lt_y	# if(x<y) ...
    	
    	blt $s1, $s0, y_lt_x
    	
    	x_lt_y:
		add $a0, $s0, $zero	# a0 = x
		sub $a1, $s1, $s0	# a1 = ( y - x )
		
		jal rec_mdc
		
		j exit_rec_mdc
		
	y_lt_x:
		sub $a0, $s0, $s1	# a0 = ( x - y )
		add $a1, $s1, $zero	# a1 = y
		
		jal rec_mdc
		
		j exit_rec_mdc
    	
	exit_rec_mdc:
		lw $ra, 0($sp)		# read register from stack
		lw $s0, 4($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 12
		jr $ra	
	
	returnx:
		add $v0, $s0, $zero
		j exit_rec_mdc
		