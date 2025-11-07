# bash-battle-git
Entrega de práctica Bash Battle Arena ll (6 al 10)

Nivel 6: Manejo de argumentos en scripts
Objetivo: Contar líneas de un archivo o manejar ausencia de argumentos.
Script (count_lines.sh):
#!/bin/bash
if [ -z "$1" ]; then
echo "No archivo provided" else
wc -l < "$1"
fi

Conceptos importantes:
•	$1 → primer argumento pasado al script.
•	[ -z "$1" ] → verifica si no se proporcionó argumento.
•	wc -l → cuenta las líneas de un archivo.
Significado:
Aprendes a recibir y validar argumentos en scripts.


Nivel 7: Ordenar archivos por tamaño
Objetivo: Listar archivos .txt por tamaño y guardar en un archivo.
Script (sort_txt_by_size.sh):
#!/bin/bash
for f in *.txt; do
if [ "$f" != "sort_output.txt" ]; then echo "$f - $(stat -c%s "$f") bytes"
fi
done | sort -k3 -n > sort_output.txt

Conceptos importantes:
•	stat -c%s → obtiene tamaño del archivo en bytes (Linux).
•	sort -k3 -n → ordena por la tercera columna numéricamente.
•	> → redirige la salida a un archivo.
Significado:
Aprendes a combinar comandos para análisis de archivos y generar reportes.


Nivel 8: Buscar en múltiples archivos
Objetivo: Buscar una palabra en archivos .log y mostrar solo los nombres de archivos coincidentes.
Script (search_logs.sh):
 
#!/bin/bash
grep -l "$1" *.log | sort

Conceptos importantes:
•	grep -l → lista solo los nombres de archivos que contienen la palabra.
•	*.log → busca en todos los archivos .log del directorio.
•	sort → opcional, ordena los nombres de archivos.
Significado:
Aprendes a buscar información dentro de varios archivos y filtrar resultados.


Nivel 9: Monitor de cambios en directorio
Objetivo: Capturar estado de un directorio y registrar cambios.
Script (monitor_changes.sh):
#!/bin/bash
ls "$1" > snapshot.txt
read -p "Make changes and press ENTER" ls "$1" > snapshot_new.txt
echo "==== $(date) ====" > changes.log
diff snapshot.txt snapshot_new.txt >> changes.log

Conceptos importantes:
•	read -p → espera entrada del usuario.
•	diff → compara archivos y muestra diferencias.
•	date → marca de tiempo.
Significado:
Aprendes a monitorear directorios y registrar cambios con scripts.


Nivel 10: Batalla Final 2 - Scripting intermedio
Objetivo: Crear varios archivos, generar líneas aleatorias, ordenar por tamaño y mover archivos según contenido.
Script (boss_battle2.sh):
#!/bin/bash
mkdir -p Arena_Boss Victory_Archive for i in {1..5}; do
lines=$((RANDOM%11+10))
for j in $(seq 1 $lines); do
echo "Line $j" >> Arena_Boss/archivo$i.txt
done done
ls -S Arena_Boss
grep -l "Victory" Arena_Boss/* | xargs -I{} mv {} Victory_Archive/
 

