.global app_main

app_main:
  # GPIO_ENABLE_W1TS_REG
  # Enable the gpio8 write one to set register 
  li t0, 0x60004024
  li t1, 1
  slli t1, t1, 8
  sw t1, 0(t0)

  # GPIO_OUT_W1TS_REG
  # Sets the gpio8 output to high = led off
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
  
  # clear bits 12, 13 e 14
  # li t4, 0x7000
  # xori t4, t4, -1
  # and t2, t2, t4

  # MCU_SEL = 1
  # li t4, 1
  # slli t4, t4, 12
  # or t2, t2, t4

  # merges WPD, WPU and IE in t2. 
  or t3, t3, t1
  or t3, t3, t2
  sw t3, 0(t0)

  loop:    
      #load GPIO_IN_REG
      li t0, 0x6000403C
      lw t1, 0(t0)
  
     # verify if the 4º bit (GPIO4) is zero
     li t2, 1
     slli t2, t2, 4
     and t1, t1, t2
  #   bnez t1, led_off
  #   beqz t1, led_on
  
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





