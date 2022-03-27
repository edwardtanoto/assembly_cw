.data 
string1 : .space 80
string2 : .space 80
p1: .asciiz "P1: "
p2: .asciiz "P2: "
n: .asciiz "N: "
error_msg: .asciiz "An error has occurred."

.text
main: 
  la $a0, p1 # print string to prompt user enter the first char array
  li $v0, 4
  syscall

  la $a0,string1
  li $a1,80
  li $v0,8
  syscall



  la $a0, p2 # print string to prompt user enter the first char array
  li $v0, 4
  syscall

  la $a0,string2
  li $a1,80
  li $v0,8
  syscall

  la $a0, n # prompt how many char to compare
  li $v0, 4
  syscall 

  li $v0, 5
  syscall 

  add $t0, $zero, $v0 # store the n value input

  la $s0, string1

  la $s1, string2

  addi $t2, $zero, 0 # sum
  addi $t1, $zero, 0 # store iterator (i)
start_loop_1: 
            add $s0, $s0, $t1
            beq $t1, $t0, end_loop1
            lb $t3, 0($s0) # load the 1 bit char 
            add $t2, $t2, $t3 # add sum with the ascii 
            addi $t1, $t1, 1 # add iterator 
            j start_loop_1



end_loop1: 


    li $t6, 10
    beq $t2, $t6, error



   addi $t4, $zero, 0
   addi $t1, $zero, 0 # store iterator (i)


start_loop_2: 
            add $s1, $s1, $t1
            beq $t1, $t0, end_loop2
            lb $t3, 0($s1) # load the 1 bit char 
            add $t4, $t4, $t3 # add sum with the ascii 
            addi $t1, $t1, 1 # add iterator 
            j start_loop_2


end_loop2: 

    li $t6, 10
    beq $t2, $t6, error

    sub $s3, $t2, $t4
    add $a0, $zero, $s3
    li $v0, 1
    syscall

          li $v0, 10 
          syscall



error: 
    la $a0, error_msg
    li $v0, 4
    syscall