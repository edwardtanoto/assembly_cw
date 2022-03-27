.data	
numx : .asciiz "Enter x:"
numy : .asciiz "Enter y:"
err : .asciiz "Error value is detected due to an overflow."
final : .asciiz "(x^(3)+3x^(2)y+3xy^(2)+9y^(3)) = "
#(x+3y)(x^(2)+3y^(2))
.text
.globl main

main:
#input
	la $a0, numx #Display number x prompt
	li $v0, 4
	syscall
	
	li $v0, 5 #Read Input 
	syscall
	or $s0,$v0,0 #Store num x in s0
	
	la $a0, numy #Display number y prompt
	li $v0, 4
	syscall
	
	li $v0, 5 #Read Input 
	syscall
	
	or $s1,$v0,0 #Store num y in s1
	la $a0, final #Show the final results
	li $v0,4
	syscall
	j multiply

multiply:

    #(x+3y)
	addi $t2,$zero,3 #Assign t2 as 3
	mult $t2,$s1 #3y
	mflo $s7   #saves value of 3y in t5
	mfhi $s2
	bgt  $s2,$zero, overflow #Show Overflow Error message if error.
	add $s7,$s7,$s0 #	=(x+3y)
    
#(x^(2)+3y^(2))
	mult $s0,$s0 # Square num x
	mflo $s3 #Store x square to t0
	mfhi $s2
	bgt  $s2,$zero, overflow #Show Overflow Error message if error.
	
	mult $s1,$s1  # Square num y
	mflo $s4
	mfhi $s2
	bgt  $s2,$zero, overflow #Show Overflow Error message if error.
	
	addi $t2,$zero,3 #Assign t2 as 3
	mult $s4,$t2 #3y^2
	mflo $s5
	bgt  $s2,$zero, overflow #Show Overflow Error message if error.
	
	add $s6,$t0,$s5 #t4=(x^(2)+3y^(2))

	
    #(x+3y)(x^(2)+3y^(2))
	mult $s6,$s7
	mflo $a0 #a0 = (x+3y)(x^(2)+3y^(2))
	mfhi $s2
	bgt  $s2,$zero, overflow #Show Overflow Error message if error.
	
	li $v0,1 #output final 
	syscall
	j endloop	

	
overflow:
	la $a0, err #Display overflow error
	li $v0, 4
	syscall
	j endloop
	
	
endloop:
	li $v0,10
	syscall