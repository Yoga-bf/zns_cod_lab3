.data
newline:
	.string "\n"
array:
	.word	0x0001 0x0001

.text
load: # load the arguments
	la 		a0, array	# 数组初始地址放到a0
	addi	a1, x0, 100		# 循环次数，x0里值为0，放到a1里，之后每次循环a1--
	lw		a2, 0(a0)  	# 数组初始两个值放到a2和a3
	lw	 	a3, 4(a0)
	addi	a0, a0, 8		# a0现在值是array[2]的地址
	addi	a1, a1, -2		# 已经有两个数了，所以循环次数-2
	
	# print first two elements
	addi 	a4, a2, 0
	jal		x1, print
	addi 	a4, a3, 0
	jal		x1, print

loop: # generate, store and print the array
	bge     x0, a1, exit 	# 跳出循环条件，结束斐波那契数列生成
	add		a4, a2, a3	# f n = f n-1 +f n-2
	sw		a4, 0(a0)	# 生成的斐波那契数列下一位存在a0寄存器里对应的地址，也就是array[2]的位置
	jal		x1, print	# 打印
	addi	a0, a0, 4		# a0每次+4，每次到达array数组下一位的地址
	addi	a2, a3, 0		# a3 a4赋值给 a2 a3，为下一轮计算准备
	addi	a3, a4, 0
	addi	a1, a1, -1		# a1--，到0退出
	jal		x0, loop	# 返回循环开始

print:# 打印斐波那契数列
	addi	t0, a0, 0
	addi	a0, a4, 0
	addi	a7, x0, 1
	ecall
	la		a0, newline
	addi	a7, x0, 4
	ecall
	addi	a0, t0, 0
	jalr	x1

exit: # quit program
	addi 	a7, x0, 10
	ecall
