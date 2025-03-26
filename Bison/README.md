# Práctica de bison
## Como ejecutar la practica de bison
1. Generar el analizador léxico a partir del código flex (extensión «.l»), ejecutando:<br>
**flex analizador_lexico.l**<br>
2. Generar el analizador sintáctico a partir del código bison (extensión «.y»), ejecutando<br>
**bison -yd analizador_sintactico.y**<br>
3. Compilar el fuente en C generado por flex y bison, ejecutando:<br>
**gcc lex.yy.c y.tab.c -o nombre_ejecutable -lfl**<br>
4. Ejecutar el programa<br>
**./nombre_ejecutable**<br>
5. Pasar un archivo por parametro.<br>
   **./nombre_ejecutable ejemeplo.txt**<br>

## Ejemplos
  ### Ejemplo 1
      mete 5
      mete 25
      mul
      valori VAR
      swap
      asigna
        ee V
    LBL0:
        valord VAR
        mete 0
        esmayor
        sifalsovea LBL1
        mete 2
        valord V
        mul
        valord VAR
        swap
        sub
        valori VAR
        swap
        asigna
        vea LBL0
    LBL1:
        mete 5
        valord VAR
        sub
        mete 0
        esmayor
        sifalsovea LBL2
        mete 1
        valord V
        swap
        sub
        valori V
        swap
        asigna
        mete 3
        valord V
        mul
        valori Z
        swap
        asigna
        metecad "3*(V-1) es: "
        valord Z
        print 2
        vea LBL3
    LBL2:
        valord VAR
        mete 10
        add
        valori Z
        swap
        asigna
        metecad 'VAR + 10 es: '
        valord Z
        print 2
    LBL3:
    
  ### Ejemplo 2
        mete 10
        valori A
        swap
        asigna
        mete 0
        valori B
        swap
        asigna
    LBL0:
        valord A
        valord B
        esigual
        not
        sifalsovea LBL1
        valord B
        valord A
        esmenor
        sifalsovea LBL2
        valord B
        print 1
    LBL2:
        mete 1
        valord B
        add
        valori B
        swap
        asigna
        vea LBL0
    LBL1:
        mete 5
        valori A
        swap
        asigna
        mete 0
        valori C
        swap
        asigna
    LBL3:
        valord A
        mete 0
        esmayor
        sifalsovea LBL4
        mete 1
        valord A
        swap
        sub
        valori A
        swap
        asigna
    LBL5:
        valord C
        mete 10
        esmenor
        sifalsovea LBL6
        mete 2
        valord C
        add
        valori C
        swap
        asigna
        valord A
        valord B
        valord C
        print 3
        vea LBL5
    LBL6:
        vea LBL3
    LBL4:

  ### Ejemplo 3
        valori VAR
        valord V
        asigna
    LBL0:
        valord VAR
        mete 3
        mul
        valori RES
        swap
        asigna
        valord RES
        print 1
        valori VAR
        valord VAR
        mete 3
        add
        asigna
        valord VAR
        mete 50
        esmenor
        siciertovea LBL0
        lee V
        valori VAR
        valord V
        asigna
    LBL2:
        valord VAR
        mete 20
        esmayor
        sifalsovea LBL4
        valord VAR
        print 1
    LBL4:
        valori VAR
        valord VAR
        mete 1
        add
        asigna
        valord VAR
        mete 100
        esmenor
        siciertovea LBL2
        valori VAR
        mete 1
        asigna
    LBL5:
        valord VAR
        mete 3
        mul
        valori RES
        swap
        asigna
        valord RES
        print 1
        valori VAR
        valord VAR
        mete 3
        add
        asigna
        valord VAR
        mete 50
        esmenor
        siciertovea LBL5
        valori VAR
        valord V
        asigna
    LBL7:
        valord VAR
        print 1
        valori VAR
        valord VAR
        mete 1
        add
        asigna
        valord VAR
        mete 50
        esmenor
        siciertovea LBL7
    
