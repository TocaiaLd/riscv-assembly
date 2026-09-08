.global app_main

app_main: 
  loop:
    # GPIO_ENABLE_W1TS_REG
    li t0, 0x60004024
    li t1, 1
    slli t1, t1, 8
    sw t1, 0(t0)

    # GPIO_OUT_W1TC_REG
    li t0, 0x6000400C
    li t1, 1
    slli t1, t1, 8
    sw t1, 0(t0)

    # Delay
    jal ra, function

    # GPIO_OUT_W1TS_REG
    li t0, 0x60004008
    li t1, 1
    slli t1, t1, 8
    sw t1, 0(t0)
        
    jal ra, function
    
    j loop

    ret

function:
    li t2, 10000000
    
    delay:
      addi t2, t2, -1
      bnez t2, delay
    
    ret

