MULTIPLICACIÓN POR ALGORITMO DE BOOTH

Video de la demostración: https://youtu.be/R0FzU-s2TFQ

Funcionamiento del sistema completo
La funcionalidad general de este sistema es recibir dos operandos, y realiza la operación de multiplicación hasta que se suelte el botón que acciona el sistema, luego guarda el resultado en un registro de salida para mantener el resultado estable donde se puede visualizar cuando se termine la operación. 
Funcionamiento del subsistema de lectura
El sistema se encarga de recibir los datos del usuario e ingresarlos al sistema, está compuesto por un sincronizador para cada operando y un convertidor de nivel a pulso para el botón de entrada. 
El sincronizador es de 3 flip-flops para cada bit del operando y sirve para reducir el riesgo de metaestabilidad al proporcionar un mayor margen de tiempo para que el sistema se estabilice antes de comenzar con la multiplicación. 
Por otra parte, el convertidor de nivel a pulso envía una señal de valid al subsistema de multiplicación cuando el botón se suelta después de ser presionado para que el sistema empiece con la operación. Este convertidor se implementó con una maquina de estados que se detalla más adelante.

![ss_entrada](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/7f2dac9b-102f-4e9b-95fe-828eba3735b9)
