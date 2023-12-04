# Trabajo-FPGA
En este proyecto de VHDL, vamos a programar el funcionamiento y la coordinación de dos semáforos: uno para peatones y otro para coches. Para ello utilizaremos la plana Nexys 4 DDR.
El semáforo para peatones estará controlado por un botón de "espere verde". Cuando un peatón presione este botón, el semáforo para peatones cambiará a verde, permitiendo a los peatones cruzar de manera segura.
Por otro lado, el semáforo para coches estará equipado con un sensor que detecta la presencia de coches. Cuando un coche se detecta, el semáforo para coches cambiará a verde, permitiendo al coche pasar. Si no se detecta ningún coche, el semáforo para coches permanecerá en rojo.
Además, para evitar el problema común de los rebotes en los botones, hemos decidido incluir una entidad de “Debounce”. Esta entidad se encargará de filtrar las señales de los botones, asegurando que cada pulsación del botón se registre correctamente sin rebotes.
