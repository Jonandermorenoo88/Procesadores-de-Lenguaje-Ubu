# Primera practica de flex

## Pasos para ejecutar uma práctica de Flex:
1. Compila el archivo C generado.<br>
   Usa un compilador de C, como gcc, para compilar lex.yy.c:<br>
      **gcc lex.yy.c -o practica -lfl**<br>
      Nota: -lfl enlaza las biblioteca libfl (flex library) necesaria.
2. Ejecuta el programa
   Una vez compilado, puedes ejecutarlo:<br>
   **./practica**<br>
   puedes pasarle el archivo de entrada con redirección:<br>
   **./practica < prueba1.txt**
   
## Lo que tiene que devoolver

Debería dar:

Número total de secciones: 2
Número total de propiedades: 13
La sección «Database» es la sección con más propiedades, con 8 propiedades.
Número de rutas:
  - Windows: 1
  - Unix: 1
Número total de propiedades de fecha: 2
Número total de propiedades booleanas: 2
Número total de resto de propiedades: 7

Debería dar:

Número total de secciones: 3
Número total de propiedades: 12
La sección «Settings» es la sección con más propiedades, con 5 propiedades.
Número de rutas:
  - Windows: 0
  - Unix: 0
Número total de propiedades de fecha: 0
Número total de propiedades booleanas: 1
Número total de resto de propiedades: 11
