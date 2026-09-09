.global app_main

app_main:
  # Carrega o endereço de IO_MUX_GPIO4
  li t0, 0x60009020
  lw t1, 0(t0)

  # Desativa o WPD 
  li t2, 1
  slli t2, t2, 7
  xori t2, t2, -1
  and t2, t2, t1

  # IO_MUX_GPIO4_FUN_WPU
  # BIT numero 8
  li t1, 1
  slli t1, t1, 8

  # IO_MUX_GPIO4_FUN_IE
  # BIT numero 9
  li t3, 1
  slli t3, t3, 9
  
  or t3, t3, t1

  # Salva no registrador
  or t2, t2, t3
  sw t2, 0(t0)












  ret





