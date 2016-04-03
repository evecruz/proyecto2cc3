.data

lfsr:
        .align 4
        .half
        0x1

.text

# Implements a 16-bit lfsr
#
# Arguments: None
lfsr_random:

        la $t0 lfsr
        lhu $v0 0($t0)
        li $t1 0 # i = 0

        for: 
        	bgt $t1 15 finish # if i> 15 salta al final
        	srl $t2 $v0 0 #reg >> 0
        	srl $t3 $v0 2 #reg >> 2
        	srl $t4 $v0 3 #reg >> 3
        	srl $t5 $v0 5 #reg >> 5
        	xor $t2 $t2 $t3 #(reg >> 0) ^ (reg >> 2)
        	xor $t3 $t2 $t4 #(reg >> 0) ^ (reg >> 2) ^ (reg >> 3)
        	xor $t4 $t3 $t5 #highest=(reg >> 0) ^ (reg >> 2) ^ (reg >> 3) ^ (reg >> 5)
        	srl $t6 $v0 1 #reg >> 1
        	sll $t7 $t4 15 #highest << 15
        	or $t8 $t6 $t7 #reg = (reg >> 1) | (highest << 15)
        	andi $t8, $t8, 0xFFFF #mascara para que sean 16 bits
        	addi $t1 $t1 1 # i++
        	addi $v0 $t8 0 #guardando la respuesta en la variable $v0 para desplegar
        	j for #repite el for hasta que deje de cumplirse la condicion

        finish:
        li $t1 0 # i = 0
        la $t0 lfsr
        sh $v0 0($t0)
        jr $ra
