#!/bin/bash

# ==============================================
# Script: update_readmes.sh
# Copia imágenes y genera README.md visibles en GitHub
# Para ramas nivel-06 a nivel-10
# ==============================================

IMAGES_DIR="/home/juana/ImagenesBattle"
REPO_DIR="/home/juana/bash-battle-git"
cd "$REPO_DIR" || { echo "❌ No se puede acceder a $REPO_DIR"; exit 1; }

# Detectar ramas que empiecen con "nivel-"
levels=($(git branch -r | grep 'origin/nivel-' | sed 's|origin/||'))

# Imágenes exactas por nivel
declare -A level_images
level_images[nivel-06]="Captura de pantalla6FALLO.png"
level_images[nivel-07]="Captura de pantalla 7.1FALLOS.png
Captura de pantalla7.2FALLOS.png
Captura de pantalla7FALLO.png"
level_images[nivel-08]="Captura de pantalla8.1.png
Captura de pantalla8FALLO.png"
level_images[nivel-09]="Captura de pantalla9.1FALLO.png
Captura de pantalla9FALLO.png"
level_images[nivel-10]="Captura de pantalla10.1FALLO.png
Captura de pantalla10.2FALLO.png"

# Iterar cada rama
for level in "${levels[@]}"; do
    echo "🔄 Procesando $level..."
    git checkout "$level" || { echo "❌ Error al cambiar a la rama $level"; exit 1; }

    folder="$level"
    mkdir -p "$folder"
    readme="$folder/README.md"

    # Manejar nombres con espacios
    IFS=$'\n' read -r -d '' -a images <<< "${level_images[$level]}"$'\n'

    # Copiar imágenes al repo (misma carpeta)
    echo "📸 Copiando imágenes al repositorio..."
    for img in "${images[@]}"; do
        src="$IMAGES_DIR/$img"
        dest="$folder/$(basename "$img")"
        if [ -f "$src" ]; then
            cp "$src" "$dest"
            echo "✅ Copiada: $img"
        else
            echo "⚠️ No se encontró: $src"
        fi
    done

    # Crear o limpiar README
    if [ ! -f "$readme" ]; then
        echo "# $level - Bash Battle" > "$readme"
        echo "" >> "$readme"
    fi
    sed -i '/## Archivos/,$d' "$readme"

    echo "## Archivos" >> "$readme"
    echo "" >> "$readme"

    # Insertar imágenes con rutas relativas
    for img in "${images[@]}"; do
        img_file="$(basename "$img")"
        if [ -f "$folder/$img_file" ]; then
            echo "![${img_file}](${img_file})" >> "$readme"
            echo "" >> "$readme"
        else
            echo "_⚠️ No se encontró la imagen: $img_file_" >> "$readme"
        fi
    done

    echo "## Descripción del proceso" >> "$readme"
    echo "En este nivel fui probando los scripts y corrigiendo errores que aparecieron." >> "$readme"
    echo "" >> "$readme"
    echo "## Reflexión" >> "$readme"
    echo "Aprendí a manejar archivos, argumentos y errores paso a paso." >> "$readme"
    echo "" >> "$readme"
    echo "_Actualizado automáticamente el $(date '+%d-%m-%Y a las %H:%M:%S')._" >> "$readme"

    # Commit y push
    git add "$folder/"
    git commit -m "$level: agregar imágenes y actualizar README para GitHub"
    git push origin "$level"

    echo "✅ $level actualizado correctamente."
    echo "-----------------------------------"
done

echo "🎉 ¡Todas las ramas se actualizaron y las imágenes se ven en GitHub!"
