.text
.globl main

main:
   	# ���� integer
   	li     $v0, 4                  # ��ʾ��Ϣ msg1
   	la     $a0, msg1               
   	syscall

   	li     $v0, 5                  # ���ռ�������������������浽$v0
   	syscall                        # 
   	move   $a1, $v0                # �����յ�������ת�棬$a1<-$v0                     

   	li     $v0, 4                  # ��ʾ msg2
   	la     $a0, msg2
   	syscall

   	li     $v0, 1                  # ��ʾ ���������
   	move   $a0, $a1                # ��ʾ�������뱣�浽$a0
   	syscall

	jal fact
	
	move   $a1, $v0
	li     $v0, 4                  # ��ʾ��Ϣ msg3
   	la     $a0, msg3             
   	syscall

   	li     $v0, 1                  # ��ʾ ���������
   	move   $a0, $a1                # ��ʾ�������뱣�浽$a0
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
