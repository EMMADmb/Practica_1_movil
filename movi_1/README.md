# Fade In Image Demo

Esta aplicación Flutter demuestra cómo mostrar imágenes desde la red usando un efecto de **fade-in** (desvanecimiento) y un placeholder local.

## ¿Qué hace esta app?

- Muestra un título en la parte superior.
- Usa el widget `FadeInImage.assetNetwork` para cargar una imagen de red (búho) con un efecto de aparición suave.
- Mientras la imagen de red se descarga, muestra una imagen local (`loading.png`) como placeholder.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
- Un editor de código (VS Code, Android Studio, etc.)
- Dispositivo físico o emulador para probar la app.
- La imagen `assets/loading.png` incluida en la carpeta del proyecto.

## Instalación y ejecución

1. Clona o descarga este repositorio.
2. Abre la carpeta en tu editor favorito.
3. En la terminal, estando en la raíz del proyecto, ejecuta:
   ```bash
   flutter pub get
   flutter run
   ```
4. ¡Listo! Deberías ver la app mostrando el efecto de fade-in en la imagen.

## Estructura principal

- `lib/main.dart`: Código fuente principal.
- `assets/loading.png`: Imagen local usada como placeholder.
- `pubspec.yaml`: Configuración de dependencias y assets.

