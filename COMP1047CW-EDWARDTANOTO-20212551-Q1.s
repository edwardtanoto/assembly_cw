.data
words : .space 80
orig : .space 1
new : .space 1
firstprompt : .asciiz "Input string in register A: "
secondprompt : .asciiz "Input character in register B: "
thirdprompt : .asciiz "\nInput character in register C: "
result : .asciiz "\nOutput string in register A: "

.text
.globl main
main:

addiu $sp,$sp,20
sw $ra,16($sp)

#Take input string from the firstprompt
la $a0,firstprompt
li $v0,4
syscall

#Store it in words

la $a0,words
li $a1,80
li $v0,8
syscall

#Take input string from the secondprompt

la $a0,secondprompt
li $v0,4
syscall

#Store it in orig

li $v0,12
syscall
sb $v0,orig

#Take input string from the thirdprompt

la $a0,thirdprompt
li $v0,4
syscall

#Store it in orig

li $v0,12
syscall
sb $v0,new

la $a0,words #Get address of words
lb $a1,orig #Get orig address
lb $a2,new #Get new address
li $a3,0 #Get replace with zero first
li $t0,0 #Get index
loop:
lb $t0,0($a0)
beq $t0,$zero, end #End if loop done

bne $t0,$a1,skip #Comparing it with orig character, then replace the selected character.
sb $a2,0($a0)#replace character
add $a3,$a3,1 #increase replace count by one
skip:
add $a0,$a0,1 #increase count by one
j loop

#Print the nOutput

end:
li $v0,4
la $a0,result
syscall

li $v0,4
la $a0,words
syscall

lw $ra,16($sp)
addiu $sp,$sp,20

li $v0,10
syscall
