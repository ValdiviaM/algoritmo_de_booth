MULTIPLICACIÓN POR ALGORITMO DE BOOTH

Video de la demostración: https://youtu.be/R0FzU-s2TFQ

Funcionamiento del sistema completo
La funcionalidad general de este sistema es recibir dos operandos, y realiza la operación de multiplicación hasta que se suelte el botón que acciona el sistema, luego guarda el resultado en un registro de salida para mantener el resultado estable donde se puede visualizar cuando se termine la operación. 
Funcionamiento del subsistema de lectura
El sistema se encarga de recibir los datos del usuario e ingresarlos al sistema, está compuesto por un sincronizador para cada operando y un convertidor de nivel a pulso para el botón de entrada. 
El sincronizador es de 3 flip-flops para cada bit del operando y sirve para reducir el riesgo de metaestabilidad al proporcionar un mayor margen de tiempo para que el sistema se estabilice antes de comenzar con la multiplicación. 
Por otra parte, el convertidor de nivel a pulso envía una señal de valid al subsistema de multiplicación cuando el botón se suelta después de ser presionado para que el sistema empiece con la operación. Este convertidor se implementó con una maquina de estados que se detalla más adelante.

![ss_entrada](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/7f2dac9b-102f-4e9b-95fe-828eba3735b9)

Funcionamiento del subsistema de multiplicación
El subsistema de multiplicación se encarga de recibir los datos del sistema de lectura y hacer la multiplicación entre los operandos para luego pasarle el resultado al subsistema de despliegue de resultados y decirle cuando se terminó la operación.
Este subsistema cuenta con una maquina de estados que se detalla más adelante, un datapath que contiene los elementos necesarios para realizar el algoritmo de booth como registros y sumadores. También un contador que cuenta hacia abajo y que indica cuando se acaban las iteraciones y por ende cuando ya se tiene el resultado.

![ss_mult (1)](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/4237d3bc-7eb4-4334-b983-4aac939669b2)

Funcionamiento del subsistema de despliegue de resultado
Este subsistema es un registro que toma el resultado de la multiplicación y lo guarda cuando se acabó la operación, así el usuario solo ve un cambio cuando ya se terminó y no ve valores intermedios del proceso.

![ss_salida (1)](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/e1552038-f06e-4af4-b4a3-628a76725462)

Diagramas de estado de las FSM del sistema.
En el sistema implementado se utilizaron dos máquinas de estado, una para la conversión de nivel a pulso y otra para el multiplicador. 
La primera máquina de estados es bastante sencilla, solo tiene dos estados, para esta primera se tiene el siguiente diagrama de estados en donde la entrada y salida son la señal de botón y la de valid respectivamente.

![image](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/f9fd9f61-dacd-49fd-a23e-43e7dc3fdba1)

La máquina de estados del sistema de multiplicación es mucho más compleja que la anterior, esta tiene como entradas las señales count_done, valid, Q0 y Q-1 donde count_done viene del contador e indica si la cuenta llegó a cero, la entrada valid viene del subsistema de lectura y Q0 y Q-1 vienen del datapath del algoritmo de booth. Como salidas tiene load_A, load_add, load_B, ar_shift, add_sub, count, start y done donde la señal de done va al subsistema de despliegue de resultados, las señales de count y start van al contador y el resto al datapath del algoritmo de booth.
Para el diagrama de estados de esta máquina cuando no se menciona una entrada se asume que es un valor no importa y cuando no se menciona la salida se asume que es cero, además, cuando se necesita que una entrada sea cero se utiliza el símbolo “~” para denotar negación lógica.

![image](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/cb3c47b0-3574-4db4-bd24-ae9e67a65d46)

Simulación del sistema completo

![image](https://github.com/dl-2-23/tarea3-griii5/assets/143150841/92950cea-b6ae-4088-9b43-cf3744b0a33d)

En la simulación se observa como el registro de la salida no cambia hasta que el sistema termine la operación y para realizar la multiplicación de 4 por 1 dura 12 ciclos de reloj, esto puede variar según los números que se multipliquen, además, se observa la configuración del módulo de pruebas que espera tres ciclos de reloj hasta presionar el botón para que se sincronicen los operandos de entrada en el sistema de lectura.
Problemas Hallados
El principal problema fue la maquina de estados del sistema de multiplicación para terminar de ajustarla se fueron haciendo pruebas con distintas versiones y se encontró que estaba cargando la suma al registro antes de configurar la suma entonces se solucionó al cambiar la lógica de salida para que cargara la suma al mismo tiempo que se le configura una suma al sumador/restador.
Otro problema que surgió es que para hacer varias multiplicaciones seguidas, se necesita reiniciar el registro que almacena la suma, tiene que estar en cero, pero entonces se tenia que reiniciar todo el sistema antes de cada operación, lo cual es poco práctico, así que se decidió que el registro que almacena la suma se reinicie cada vez que entra la señal valid al subsistema de multiplicación para evitar este problema.
Por último, al diseñar el contador se hizo para que contara desde 4 hasta 1 no hasta 0, esto por un error al interpretar el algoritmo de booth y provocó que el resultado diera el doble si eran ambos positivos, es decir, le faltaba un corrimiento aritmético antes de terminar, pero no lo estaba haciendo, se solucionó simplemente configurando el contador para que cuente de 4 hasta 0.

