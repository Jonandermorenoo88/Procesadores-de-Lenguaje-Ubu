# Práctica de JavaCC
1. Genera el parser con JavaCC
   Abre una terminal linux en el directorio del archivo .jj y ejecuta<br>
   **javacc parser.jj**
2. Compila los archivos .java generados<br>
   **javac * .java**<br>
   Nota: Esto compilará el parser y todos sus componentes.
3. Ejecuta el parser<br>
   Depende del nombre de tu clase principal. si tu clase parser se llama Parser y tiene un main, ejecuta,:<br>
   **java parser**<br>
4. Proporciona entrada al parser
   Puedes escribir directamente la entrada por consola o redirigir desde un archivo:<br>
   **java Parser < entrada.txt**
