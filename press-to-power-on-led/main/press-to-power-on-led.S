.global app_main

app_main:
  # configure GPIO_ENABLE_W1TS_REG
  li t0, 0x60004024
  li t1, 1
  slli t1, t1, 8
  sw t1, 0(t0)

  li t0, 0x60004008
  li t1, 1
  slli t1, t1, 8
  sw t1, 0(t0)

  # load IO_MUX_GPIO4 address
  li t0, 0x60009020
  lw t1, 0(t0)

  # disable WPD (bit 7)
  li t2, 1
  slli t2, t2, 7
  xori t2, t2, -1
  and t2, t2, t1

  # enable WPU (bit 8)
  li t1, 1
  slli t1, t1, 8

  # enable IE (bit 9)
  li t3, 1
  slli t3, t3, 9
  
  # limpa bits 12, 13 e 14
  li t4, 0x7000
  xori t4, t4, -1
  and t2, t2, t4

  # MCU_SEL = 1
  li t4, 1
  slli t4, t4, 12
  or t2, t2, t4

  # merges WPD, WPU and IE in t2. 
  or t3, t3, t1
  or t2, t2, t3
  sw t2, 0(t0)

  loop:
    li t5, 10000000

    delay:
      addi t5, t5, -1
      bnez t5, delay
    
    # load GPIO_IN_REG
    li t0, 0x6000403C
    lw t1, 0(t0)
  
    # verify if the 4º bit (GPIO4) is zero
    li t2, 1
    slli t2, t2, 4
    and t1, t1, t2
    bnez t1, led_off
    j led_on

  led_on:
    # turns on the GPIO8's led
    li t0, 0x6000400C
    li t1, 1
    slli t1, t1, 8
    sw t1, 0(t0)

    j loop

  led_off:
    # turns off the GPIO8's led
    li t0, 0x60004008
    li t1, 1
    slli t1, t1, 8
    sw t1, 0(t0)

    j loop

  ret





