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
        sw $s5 20($sp)#Contador i
        sw $s6 24($sp)#Contador j
        sw $ra 28($sp)#Posicion del memoria para etiquetas
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
        
        
        for2:
                beq $s5,$s2,for1 #i=width
                beq $s6,$s3,imas #i++
                bge $s5,$s4,false #i>=S
                jal lfsr_random  #llamar funcion random
                move $t4, $v0   #guardamos el valor de random en $t6
                                       
        false:
                 
                mulu $t1, $s6,$s2 #j*ancho
                addu $t1,$t1,$s5 #le sumamos posicion i
                addu $t1,$t1,$s1 #index del depthMap
                mulu $t2,$s6,$s2  #j*ancho
                addu $t2,$s5,$t2
                addu $t2,$t2,$s0
                lb $t3, 0($t1) #valor del puntero en depth(i,j)
                sub $t3,$t3,$s4 #resto i con S
                addu $t3,$t3,$s5 # i + depth(t4i,j)-S
                and $t4, $t4, 0xFF #mascara solicitada en las especificaciones
                sb $t6 0($t4)#ingresamos el indice I
                addi $s6,$s6,1 #j++
                j salida
        for1:
                beq $s5,$s2,salida#sale cuando i=ancho
                addi $s5,$s5,1 #i++
                j for2
                
        imas:
                addi $s6, $s6, 1 #i++
        salida:  
        lw $s0 0($sp)
        lw $s1 4($sp)
        lw $s2 8($sp)
        lw $s3 12($sp)
        lw $s4 16($sp)
        lw $s5 20($sp)
        lw $s6 24($sp)
        lw $ra 28($sp)
        #regresamos espacio de memoria
        addiu $sp $sp 28
        jr $ra
