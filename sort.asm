.data
	array: .space 1024
	msg1: .asciiz "Input array length:"
	msg2: .asciiz "\nInput number:"
	msg3: .asciiz "\nYou input:"
	separate: .asciiz " "
	line: .asciiz "\n"
.text
.globl main
main:
    la $t6,array     #base address
    move $t7,$zero   #offset

    li $v0,4
    la $a0,msg1 
    syscall

    li $v0,5
    syscall
    move $t8,$v0 #length

    li $v0,4
    la $a0,msg3
    syscall

    li $v0,1
    move $a0,$t8 
    syscall

    j input


input:
    li $v0,4
    la $a0,msg2
    syscall

    li $v0,5
    syscall
    move $a1, $v0 

    li $v0,1
    move $a0,$a1
    syscall

    move $t0,$t7    
    sll $t0,$t0,2
    addu $t0,$t0,$t6
    sw $a1,0($t0)

    addi $t7,$t7,1
    blt $t7,$t8,input

    move $t7,$zero
    li $v0,4
    la $a0,line
    syscall

sort:  
	move $t2,$t6 #t2=base address
	move $s0,$zero #s0=i=0
	for1st:
		slt $t0,$s0,$t8 # i>=n, t0=0
		beq $t0,$zero,exit1

		addi $s2,$s0,-1 #j=i-1
		for2nd:
			slt $t1,$s2,$zero #j<0, t1=1
			bne $t1,$zero,exit2 #j>=0 ,jump this
			sll $t3,$s2,2  #offset t3=j*4
			add $t3,$t3,$t2 #base + offset
			lw $s3,0($t3) #t5=v[j]
			lw $s4,4($t3) #t6=v[j+1]
 			slt $t4,$s4,$s3 #v[j+1]<v[j],t4=1
 			beq $t4,$zero,exit2

 			sw $s4,0($t3)
 			sw $s3,4($t3)

			addi $s2,$s2,-1 #j++
			j for2nd
		exit2:
		addi $s0,$s0,1 # i++
		j for1st
	exit1:
	move $t0,$zero

print:
	move $t0,$t7
	sll $t0,$t0,2
	addu $t0,$t0,$t6
	lw $a1,0($t0)

    li $v0,1            
    move $a0,$a1 
    syscall

    li $v0,4
    la $a0,separate
    syscall

    addi $t7,$t7,1
    blt $t7,$t8,print

    j exit      

exit:
	li $v0,10
	syscall

