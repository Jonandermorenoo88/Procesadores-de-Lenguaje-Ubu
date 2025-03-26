/*Jon Ander Incera Moreno*/
%{

    // Variables para conteo de secciones, propiedades, etc.
    int secciones = 0; // Contador de secciones
    int propiedades = 0; // Contador de propiedades totales
    int propiedades_seccion = 0; // Contador de propiedades dentro de una sección
    int max_propiedades = 0; // Número máximo de propiedades encontradas en una sección
    char seccion_max[100] = ""; // Nombre de la sección con más propiedades
    char nombre_seccion[100] = ""; // Nombre de la sección actual
    int rutas_windows = 0; // Contador de rutas en formato Windows
    int rutas_unix = 0; // Contador de rutas en formato Unix
    int fechas = 0; // Contador de propiedades con valores de tipo fecha
    int booleanos = 0; // Contador de propiedades booleanas
    int resto_propiedades = 0; // Contador de propiedades que no son rutas, fechas ni booleanos
%}

/* Cualquier secuencia sin espacios, tabulaciones o saltos de línea */
TEXTO_SIN_ESPACIOS    [^ \t\n]*
/* Cero o más espacios o tabulaciones */
ESPACIOS_BLANCOS      [ \t]* 
/* Una sección entre corchetes, puede contener caracteres alfanuméricos, _, ., -, y espacios */
SECCION               \[[a-zA-Z0-9_.# -]+\]
/* Clave de propiedad con un signo igual, permitiendo espacios */ 
CLAVE                 [a-zA-Z0-9_.]+[ \t]*=
/* Ruta en formato Windows (unidad seguida de dos puntos y backslash) */
RUTA_WINDOWS          [A-Z]:\\
/* Ruta en formato Unix (empieza con '/') */
RUTA_UNIX             \/
/* Fecha en formato ISO (YYYY-MM-DD) */
FECHA_ISO             [0-9]{4}-[0-9]{2}-[0-9]{2}
/* Fecha en formato USA (DD/MM/YYYY) */
FECHA_USA             [0-9]{2}\/[0-9]{2}\/[0-9]{4}
/* Booleanos válidos */
BOOLEANO              (True|False|Yes|No|1|0)
/* Propiedades que no son rutas, fechas o booleanos */
RESTO_PROPIEDADES     [ \t]*([^#;\r\n]*)
/* Comentarios que empiezan con `;` */
COMENTARIO_PUNTO_COMA [ \t]*;[^\r\n]*
/* Comentarios que empiezan con `#` */
COMENTARIO_HASH       [ \t]*#[^\r\n]*
 /* Línea vacía */
LINEA_VACIA           \n

/* Definir un estado llamado SECCIONES (para identificar cuándo estamos dentro de una sección) */
%x SECCIONES

%%

<INITIAL>{ /* Estado inicial del programa */
    {SECCION} { /* Si encontramos una nueva sección */
        strncpy(nombre_seccion, yytext + 1, strlen(yytext) - 2); /* Copiar el nombre de la sección, excluyendo los corchetes */
        nombre_seccion[strlen(yytext) - 2] = '\0'; /* Asegurar la terminación nula del nombre de la sección */
        secciones++; /* Incrementar el contador de secciones */
        propiedades_seccion = 0; /* Reiniciar el contador de propiedades para la nueva sección */
        BEGIN(SECCIONES); /* Cambiar al estado SECCIONES */
    }

    {COMENTARIO_PUNTO_COMA} /* Ignorar comentarios que empiezan con `;` */
    {COMENTARIO_HASH} /* Ignorar comentarios que empiezan con `#` */
    {LINEA_VACIA} /* Ignorar líneas vacías */
}

<SECCIONES>{ /* Estado SECCIONES, estamos dentro de una sección */

    {CLAVE}{RUTA_WINDOWS}{TEXTO_SIN_ESPACIOS} { /*una ruta en formato Windows */
        propiedades++; /* Incrementar el contador de propiedades totales */
        propiedades_seccion++; /* Incrementar el contador de propiedades de la sección actual */
        rutas_windows++; /* Incrementar el contador de rutas en formato Windows */
    }

    {CLAVE}{RUTA_UNIX}{TEXTO_SIN_ESPACIOS} { /* una ruta en formato Unix */
        propiedades++; /* Incrementar el contador de propiedades totales */
        propiedades_seccion++; /* Incrementar el contador de propiedades de la sección actual */
        rutas_unix++; /* Incrementar el contador de rutas en formato Unix */
    }

    {CLAVE}{FECHA_ISO}{TEXTO_SIN_ESPACIOS} { /*una fecha en formato ISO (YYYY-MM-DD) */
        propiedades++; /* Incrementar el contador de propiedades totales */
        propiedades_seccion++; /* Incrementar el contador de propiedades de la sección actual */
        fechas++; /* Incrementar el contador de propiedades de fecha */
    }

    {CLAVE}{FECHA_USA}{ESPACIOS_BLANCOS} { /*una fecha en formato USA (DD/MM/YYYY) */
        propiedades++; /* Incrementar el contador de propiedades totales */
        propiedades_seccion++; /* Incrementar el contador de propiedades de la sección actual */
        fechas++; /* Incrementar el contador de propiedades de fecha */
    }

    {CLAVE}{ESPACIOS_BLANCOS}{BOOLEANO}{ESPACIOS_BLANCOS} { /* Si encontramos una propiedad booleana */
        propiedades++; /* Incrementar el contador de propiedades totales */
        propiedades_seccion++; /* Incrementar el contador de propiedades de la sección actual */
        booleanos++; /* Incrementar el contador de propiedades booleanas */
    }

    {CLAVE}{ESPACIOS_BLANCOS}{RESTO_PROPIEDADES}{ESPACIOS_BLANCOS} { /* Si encontramos otra propiedad */
        propiedades++; /* Incrementar el contador de propiedades totales */
        propiedades_seccion++; /* Incrementar el contador de propiedades de la sección actual */
        resto_propiedades++; /* Incrementar el contador de "otras" propiedades (no rutas, no booleanas, no fechas) */
        if (propiedades_seccion > max_propiedades) { /* Si esta sección tiene más propiedades que la sección con más hasta ahora */
            max_propiedades = propiedades_seccion; /* Actualizar el máximo de propiedades */
            strncpy(seccion_max, nombre_seccion, sizeof(seccion_max)); /* Guardar el nombre de la sección con más propiedades */
        }
    }

    {COMENTARIO_PUNTO_COMA} /* Ignorar comentarios que empiezan con `;` */
    {COMENTARIO_HASH} /* Ignorar comentarios que empiezan con `#` */
    {LINEA_VACIA} /* Ignorar líneas vacías */

    {SECCION} { /* Si encontramos una nueva sección */
        strncpy(nombre_seccion, yytext + 1, strlen(yytext) - 2); /* Copiar el nombre de la nueva sección, excluyendo los corchetes */
        nombre_seccion[strlen(yytext) - 2] = '\0'; /* Asegurar la terminación nula del nombre de la sección */
        secciones++; /* Incrementar el contador de secciones */
        propiedades_seccion = 0; /* Reiniciar el contador de propiedades para la nueva sección */
        BEGIN(SECCIONES); /* Continuar en el estado SECCIONES */
    }
}

%%

int main(int argc, char **argv) {
    if(argc < 2) {  /* Verificar si el archivo fue pasado como argumento */
        printf("ERROR: necesita un archivo a leer\n"); /* Mostrar mensaje de error si no hay archivo */
        return 1;
    }

    if(!(yyin = fopen(argv[1], "r"))) {  /* Intentar abrir el archivo en modo lectura */
        perror(argv[1]); /* Mostrar error si el archivo no se puede abrir */
        return 1;
    }

    yylex();  /* Ejecutar el analizador léxico de Flex */

    /* Imprimir las estadísticas al finalizar */
    printf("Numero total de secciones: %d\n", secciones);
    printf("Numero total de propiedades: %d\n", propiedades);
    printf("La seccion <<%s>> es la seccion con mas propiedades, con %d propiedades.\n", seccion_max, max_propiedades);
    printf("Numero de rutas:\n");
    printf("  - Windows: %d\n", rutas_windows);
    printf("  - Unix: %d\n", rutas_unix);
    printf("Numero total de propiedades de fecha: %d\n", fechas);
    printf("Numero total de propiedades booleanas: %d\n", booleanos);
    printf("Numero total de resto de propiedades: %d\n", resto_propiedades);

    fclose(yyin);  /* Cerrar el archivo después de procesarlo */

    return 0;
}