.text
.globl main

main:
   	# 输入 integer
   	li     $v0, 4                  # 显示信息 msg1
   	la     $a0, msg1               
   	syscall

   	li     $v0, 5                  # 接收键盘输入的整数，并保存到$v0
   	syscall                        # 
   	move   $a1, $v0                # 将接收到的整数转存，$a1<-$v0                     

   	li     $v0, 4                  # 显示 msg2
   	la     $a0, msg2
   	syscall

   	li     $v0, 1                  # 显示 输入的整数
   	move   $a0, $a1                # 显示的数必须保存到$a0
   	syscall

	jal fact
	
	move   $a1, $v0
	li     $v0, 4                  # 显示信息 msg3
   	la     $a0, msg3             
   	syscall

   	li     $v0, 1                  # 显示 输入的整数
   	move   $a0, $a1                # 显示的数必须保存到$a0
   	syscall

	li $v0, 10
	syscall
		
fact:
	addi $sp, $sp,-8
	sw   $ra, 4($sp)
	sw   $a0, 0($sp)

	slti $t0, $a0, 1
	beq  $t0, $zero, L1

	addi $v0, $zero, 1
	addi $sp, $sp, 8
	jr   $ra

	L1: 
		addi $a0, $a0, -1
		jal fact 
	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	mul $v0, $a0, $v0
	jr $ra                       
	
.data
   msg1:    .asciiz  "\nInput a integer: "  # 
   msg2:    .asciiz  "You input: "        # 
   msg3:    .asciiz  "\nThe result is: "    # 
