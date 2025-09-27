# Flutter Widgets

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/github/v/tag/IQ-Tec/flutter-widgets?style=for-the-badge&label=version" alt="Version">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License">
</p>

Una colección completa de widgets Flutter reutilizables y personalizables diseñados para acelerar el desarrollo de aplicaciones móviles. Cada widget sigue las mejores prácticas de Flutter, es completamente personalizable y mantiene consistencia visual con Material Design 3.

## ✨ Características

- 🎨 **Diseño Adaptativo**: Todos los widgets se adaptan automáticamente al tema de tu aplicación
- 📱 **Responsive**: Diseñados para funcionar perfectamente en diferentes tamaños de pantalla
- ⚡ **Optimizado**: Rendimiento optimizado y carga eficiente
- 🔧 **Personalizable**: Amplia gama de opciones de personalización
- 📖 **Bien Documentado**: Documentación completa con ejemplos de uso
- 🧪 **Probado**: Widgets probados y listos para producción

## 🚀 Instalación

Agrega `flutter_widgets` a tu `pubspec.yaml`:

```yaml
dependencies:
  flutter_widgets:
    git:
      url: https://github.com/IQ-Tec/flutter-widgets.git
      ref: v0.0.1
```

Luego ejecuta:

```bash
flutter pub get
```

## 📦 Widgets Disponibles

### 💬 Feedback Widgets

Widgets para mostrar estados de la aplicación y retroalimentación al usuario:

- **`ErrorCompact`**: Mensaje de error compacto ideal para listas y formularios
- **`ErrorFullScreen`**: Modal de error que cubre toda la pantalla para errores críticos
- **`ErrorInline`**: Widget de error para secciones específicas con diseño centrado
- **`LoadingSpinner`**: Indicador de carga simple y elegante

```dart
import 'package:flutter_widgets/flutter_widgets.dart';

// Error compacto
ErrorCompact(
  error: 'No se pudo cargar la información',
  onRetry: () => _retry(),
)

// Indicador de carga
LoadingSpinner(
  message: 'Cargando datos...',
  color: Theme.of(context).primaryColor,
)
```

### 🎛️ Control Widgets *(Próximamente)*

Elementos de interfaz interactivos para mejorar la experiencia del usuario:

- `CustomButton`: Botones personalizables con múltiples estilos
- `CustomDropdown`: Dropdown con búsqueda integrada
- `SwitchTile`: Switch con título y descripción
- `RatingBar`: Barra de calificación interactiva

### 📝 Form Widgets *(Próximamente)*

Componentes avanzados para formularios con validación integrada:

- `CustomTextField`: Campo de texto con validación
- `PasswordField`: Campo especializado para contraseñas
- `DatePickerField`: Selector de fecha integrado
- `FormBuilder`: Constructor de formularios dinámicos

### 📐 Layout Widgets *(Próximamente)*

Soluciones avanzadas para estructurar interfaces responsive:

- `ResponsiveLayout`: Layout adaptativo para diferentes pantallas
- `FlexibleGrid`: Grid responsive y flexible
- `CustomSpacer`: Espaciador inteligente
- `StaggeredList`: Lista escalonada tipo Pinterest

## 🎯 Uso Rápido

### Ejemplo Básico

```dart
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Widgets Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              LoadingSpinner(
                message: 'Cargando datos...',
                color: Theme.of(context).primaryColor,
              )
            else if (_hasError)
              ErrorInline(
                title: 'Error de Conexión',
                error: _errorMessage,
                onRetry: _loadData,
              )
            else
              Text('¡Datos cargados correctamente!'),
              
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadData,
              child: Text('Cargar Datos'),
            ),
          ],
        ),
      ),
    );
  }

  void _loadData() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Simular carga de datos
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        // Simular error ocasional
        if (DateTime.now().millisecond % 2 == 0) {
          _hasError = true;
          _errorMessage = 'Error al cargar los datos del servidor';
        }
      });
    });
  }
}
```

### Ejemplo Avanzado con Estados

```dart
class DataListScreen extends StatefulWidget {
  @override
  _DataListScreenState createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  List<String> _data = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Datos')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: LoadingSpinner(
          message: 'Cargando elementos...',
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if (_error != null) {
      return ErrorInline(
        title: 'Error al Cargar',
        error: _error!,
        onRetry: _loadData,
        showRetryButton: true,
      );
    }

    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_data[index]),
          trailing: Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }

  void _loadData() {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Simular carga desde API
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        // Simular datos o error
        if (DateTime.now().second % 3 == 0) {
          _error = 'No se pudo conectar al servidor. Verifica tu conexión a internet.';
        } else {
          _data = List.generate(20, (i) => 'Elemento ${i + 1}');
        }
      });
    });
  }
}
```

## 📚 Documentación Detallada

Cada categoría de widgets tiene su propia documentación detallada:

- [📢 Feedback Widgets](lib/feedback/README.md) - Estados de error y carga
- [🎛️ Control Widgets](lib/controls/README.md) - Controles interactivos *(Próximamente)*
- [📝 Form Widgets](lib/forms/README.md) - Componentes de formulario *(Próximamente)*
- [📐 Layout Widgets](lib/layouts/README.md) - Layouts responsive *(Próximamente)*

## 🛣️ Hoja de Ruta

### v0.1.0 (Próximamente)
- [ ] Control Widgets básicos (CustomButton, CustomDropdown)
- [ ] Mejoras en widgets de feedback
- [ ] Tests unitarios completos

### v0.2.0 (Futuro)
- [ ] Form Widgets con validación avanzada
- [ ] Layout Widgets responsive
- [ ] Temas personalizables
- [ ] Documentación interactiva

### v0.3.0 (Futuro)
- [ ] Widgets de navegación
- [ ] Componentes de animación
- [ ] Widgets especializados para diferentes industrias
- [ ] Herramientas de desarrollo

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Si tienes ideas para nuevos widgets o mejoras, no dudes en:

1. Hacer fork del proyecto
2. Crear una rama para tu feature (`git checkout -b feature/nuevo-widget`)
3. Commit tus cambios (`git commit -am 'Añadir nuevo widget'`)
4. Push a la rama (`git push origin feature/nuevo-widget`)
5. Crear un Pull Request

### Pautas de Contribución

- Sigue las convenciones de código de Dart/Flutter
- Incluye documentación completa para nuevos widgets
- Añade tests unitarios para nuevas funcionalidades
- Mantén la consistencia con el diseño existente
- Actualiza el CHANGELOG.md con tus cambios

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 🙏 Agradecimientos

- Equipo de Flutter por el increíble framework
- Comunidad de desarrolladores Flutter por la inspiración
- Material Design team por las guías de diseño

---

<p align="center">
  Hecho con ❤️ por <a href="https://github.com/IQ-Tec/">IQ-Tec</a>
</p>
