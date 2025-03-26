# Práctica de bison
1. Generar el analizador léxico a partir del código flex (extensión «.l»), ejecutando:
**flex analizador_lexico.l**<br>
2. Generar el analizador sintáctico a partir del código bison (extensión «.y»), ejecutando
**bison -yd analizador_sintactico.y**<br><br>
3. Compilar el fuente en C generado por flex y bison, ejecutando:
**gcc lex.yy.c y.tab.c -o nombre_ejecutable -lfl**<br>
4. Ejecutar el programa
**./nombre_ejecutable**<br>
