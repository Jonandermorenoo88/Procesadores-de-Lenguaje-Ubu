# Práctica de bison
1. Generar el analizador léxico a partir del código flex (extensión «.l»), ejecutando:<br>
**flex analizador_lexico.l**<br>
2. Generar el analizador sintáctico a partir del código bison (extensión «.y»), ejecutando<br>
**bison -yd analizador_sintactico.y**<br>
3. Compilar el fuente en C generado por flex y bison, ejecutando:<br>
**gcc lex.yy.c y.tab.c -o nombre_ejecutable -lfl**<br>
4. Ejecutar el programa<br>
**./nombre_ejecutable**<br>
