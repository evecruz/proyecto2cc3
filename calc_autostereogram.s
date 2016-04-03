.text

# Generates an autostereogram inside of buffer
#
# Arguments:
#     autostereogram (unsigned char*)
#     depth_map (unsigned char*)
#     width
#     height
#     strip_size
calc_autostereogram:

        # Allocate 5 spaces for $s0-$s5
        # (add more if necessary)
        addiu $sp $sp -28
        sw $s0 0($sp)
        sw $s1 4($sp)
        sw $s2 8($sp)
        sw $s3 12($sp)
        sw $s4 16($sp)
	sw $s5 20($sp)
	sw $s6 24($sp)
	sw $ra 28($sp)
        # autostereogram
        lw $s0 32($sp)
        # depth_map
        lw $s1 36($sp)
        # width
        lw $s2 40($sp)
        # height
        lw $s3 44($sp)
        # strip_size
        lw $s4 48($sp)

        #Declaramos contadores auxiliares i,j
	addiu $s5,$zero,0 #esto es i
	addiu $s6,$zero,0 #esto es j
	
	for1:
		addiu $s5,$zero,0 #reinicio contador de ancho		
	for2:
		beq $s5,$s2,for1
		beq $s5,$s4,false
		#aqui tiene que ir lo del random
	false:
		 
		mulu $t1, $s6,$s2
		addu $t1,$t1,$s5
		addu $t1,$t1,$s1 #index del depthMap
		lb $t3, 0($t1) #valor del puntero en depth(i,j)
		sub $t3,$t3,$s4 #resto i con S
		addu $t3,$t3,$s5 # i + depth(i,j)-S
	salida:  
        lw $s0 0($sp)
        lw $s1 4($sp)
        lw $s2 8($sp)
        lw $s3 12($sp)
        lw $s4 16($sp)
        addiu $sp $sp 20
        jr $ra
