# Feedback Widgets

Los widgets de feedback proporcionan una forma consistente de mostrar estados de error y carga en tu aplicación Flutter.

## Widgets Disponibles

### ErrorCompact

Un widget compacto para mostrar errores de forma discreta, ideal para mostrar errores en listas o formularios sin ocupar mucho espacio.

**Características:**
- Diseño compacto horizontal
- Icono de error
- Mensaje truncado (máximo 2 líneas)
- Botón de reintentar opcional
- Colores adaptativos al tema

**Uso:**

```dart
ErrorCompact(
  error: 'No se pudo cargar la información',
  onRetry: () {
    // Lógica de reintento
    print('Reintentando...');
  },
  buttonText: 'Reintentar',
)
```

**Parámetros:**
- `error` (String, requerido): Mensaje de error a mostrar
- `onRetry` (VoidCallback?, opcional): Función a ejecutar cuando se presione el botón de reintentar
- `buttonText` (String?, opcional): Texto personalizado para el botón (por defecto: 'Reintentar')

---

### ErrorFullScreen

Un widget de error que muestra un diálogo modal sobre toda la pantalla, ideal para errores críticos que requieren atención inmediata.

**Características:**
- Diálogo modal nativo con showDialog()
- Control de barrera (dismissible o no dismissible)
- Color de barrera personalizable
- Diseño de AlertDialog con scroll automático
- Botón de acción personalizable
- Integración con sistema de navegación

**Uso:**

```dart
// Mostrar diálogo de error
ErrorFullScreen.show(
  context: context,
  title: 'Error de Conexión',
  error: 'No se pudo conectar al servidor. Verifica tu conexión a internet e intenta nuevamente.',
  buttonText: 'Entendido',
  barrierDismissible: false,
  onPressed: () {
    Navigator.of(context).pop();
    // Lógica adicional
  },
);

// También puede usarse como widget (no recomendado)
ErrorFullScreen(
  title: 'Error Crítico',
  error: 'Ha ocurrido un error inesperado.',
  onPressed: () => Navigator.of(context).pop(),
)
```

**Parámetros del método show():**
- `context` (BuildContext, requerido): Contexto para mostrar el diálogo
- `error` (String, requerido): Mensaje de error a mostrar
- `title` (String?, opcional): Título del modal (por defecto: 'Error')
- `buttonText` (String?, opcional): Texto del botón (por defecto: 'Continuar')
- `onPressed` (VoidCallback?, opcional): Función del botón
- `barrierDismissible` (bool, opcional): Si se puede cerrar tocando fuera (por defecto: true)
- `barrierColor` (Color?, opcional): Color de la barrera de fondo

---

### ErrorInline

Un widget de error para mostrar en secciones específicas de la interfaz, con diseño centrado y opciones de personalización.

**Características:**
- Diseño centrado vertical
- Icono personalizable
- Título opcional
- Mensaje completo desplazable
- Botón de reintentar configurable
- Padding personalizable

**Uso:**

```dart
ErrorInline(
  title: 'Error de Carga',
  error: 'No se pudieron cargar los datos. Esto puede deberse a un problema de conexión o un error temporal del servidor.',
  icon: Icons.cloud_off,
  onRetry: () async {
    await loadData();
  },
  buttonText: 'Volver a intentar',
  showRetryButton: true,
)
```

**Parámetros:**
- `error` (String, requerido): Mensaje de error a mostrar
- `title` (String?, opcional): Título del error
- `buttonText` (String?, opcional): Texto del botón (por defecto: 'Reintentar')
- `onRetry` (VoidCallback?, opcional): Función de reintento
- `icon` (IconData?, opcional): Icono personalizado (por defecto: Icons.error_outline)
- `showRetryButton` (bool, opcional): Mostrar botón de reintentar (por defecto: true)
- `padding` (EdgeInsetsGeometry?, opcional): Padding personalizado

---

### LoadingSpinner

Un widget altamente configurable para mostrar estados de carga con múltiples tipos de indicadores y layouts.

**Características:**
- Múltiples tipos: circular, linear, adaptive
- Layouts vertical y horizontal
- Tamaños personalizables
- Mensajes con porcentaje de progreso
- Colores y estilos personalizables
- Fondo y bordes configurables
- Método overlay para pantalla completa

**Tipos disponibles:**
- **LoadingType.circular**: Indicador circular clásico
- **LoadingType.linear**: Barra de progreso horizontal
- **LoadingType.adaptive**: Se adapta al platform (iOS/Android)

**Layouts disponibles:**
- **LoadingLayout.vertical**: Indicador arriba, mensaje abajo
- **LoadingLayout.horizontal**: Indicador a la izquierda, mensaje a la derecha

**Uso básico:**

```dart
// Indicador simple
LoadingSpinner(
  message: 'Cargando datos...',
  color: Colors.blue,
)

// Indicador con progreso
LoadingSpinner(
  message: 'Descargando archivo...',
  type: LoadingType.linear,
  showProgress: true,
  progress: 0.75, // 75%
  size: 200,
)

// Layout horizontal
LoadingSpinner(
  message: 'Procesando...',
  layout: LoadingLayout.horizontal,
  backgroundColor: Colors.white.withOpacity(0.9),
  padding: EdgeInsets.all(16),
  borderRadius: BorderRadius.circular(12),
)
```

**Uso como overlay (pantalla completa):**

```dart
LoadingSpinner.overlay(
  child: MyApp(),
  isLoading: isLoading,
  message: "Cargando aplicación...",
  overlayColor: Colors.black.withOpacity(0.7),
  type: LoadingType.circular,
)
```

**Parámetros principales:**
- `message` (String?, opcional): Mensaje a mostrar
- `color` (Color?, opcional): Color del indicador y texto
- `type` (LoadingType, opcional): Tipo de indicador (por defecto: circular)
- `layout` (LoadingLayout, opcional): Layout del contenido (por defecto: vertical)
- `size` (double?, opcional): Tamaño del indicador
- `strokeWidth` (double?, opcional): Grosor del indicador
- `showProgress` (bool, opcional): Mostrar porcentaje de progreso
- `progress` (double?, opcional): Valor del progreso (0.0 a 1.0)
- `backgroundColor` (Color?, opcional): Color de fondo del contenedor
- `padding` (EdgeInsetsGeometry?, opcional): Padding interno
- `borderRadius` (BorderRadius?, opcional): Bordes redondeados

**Parámetros del método overlay():**
- `child` (Widget, requerido): Widget hijo sobre el que mostrar el overlay
- `isLoading` (bool, requerido): Si mostrar el overlay de carga
- `message` (String?, opcional): Mensaje de carga
- `color` (Color?, opcional): Color del indicador
- `overlayColor` (Color?, opcional): Color de la barrera de fondo
- `type` (LoadingType, opcional): Tipo de indicador
- `size` (double?, opcional): Tamaño del indicador

---

## FeedbackTheme

Un sistema de temas consistente para todos los widgets de feedback, proporcionando estilos uniformes en toda la aplicación.

**Características:**
- Temas claro y oscuro predefinidos
- Herencia automática de temas
- Colores consistentes entre widgets
- Fácil personalización global

**Uso:**

```dart
// Envolver la app con el tema
FeedbackTheme(
  data: FeedbackTheme.light(), // o FeedbackTheme.dark()
  child: MaterialApp(
    home: MyHomePage(),
  ),
)

// Tema personalizado
FeedbackTheme(
  data: FeedbackThemeData(
    errorColor: Colors.red.shade600,
    backgroundColor: Colors.grey.shade100,
    textColor: Colors.black87,
    primaryColor: Colors.blue,
  ),
  child: MyApp(),
)

// Acceder al tema en widgets
final theme = FeedbackTheme.of(context);
```

**Propiedades de FeedbackThemeData:**
- `errorColor`: Color para estados de error
- `backgroundColor`: Color de fondo de contenedores
- `textColor`: Color de texto principal
- `primaryColor`: Color primario para indicadores de carga

## Mejores Prácticas

1. **ErrorCompact**: Úsalo en listas, formularios o espacios reducidos donde necesites mostrar errores sin interrumpir el flujo visual.

2. **ErrorFullScreen**: Resérvalo para errores críticos que requieren atención inmediata del usuario. Usa `ErrorFullScreen.show()` en lugar del constructor para mejor integración.

3. **ErrorInline**: Perfecto para secciones de contenido donde el error necesita explicación detallada y contexto.

4. **LoadingSpinner**: Muy versátil - usa el constructor directo para secciones específicas y `LoadingSpinner.overlay()` para cargas de pantalla completa.

5. **FeedbackTheme**: Siempre envuelve tu aplicación con FeedbackTheme para mantener consistencia visual entre todos los widgets de feedback.

## Ejemplos de Casos de Uso

### En una Lista
```dart
ListView.builder(
  itemBuilder: (context, index) {
    if (hasError) {
      return ErrorCompact(
        error: 'Error al cargar el elemento $index',
        onRetry: () => retryLoadItem(index),
      );
    }
    return ListTile(/* ... */);
  },
)
```

### En una Pantalla Completa con Overlay
```dart
FutureBuilder(
  future: loadData(),
  builder: (context, snapshot) {
    return LoadingSpinner.overlay(
      isLoading: snapshot.connectionState == ConnectionState.waiting,
      message: 'Cargando datos...',
      child: snapshot.hasError
          ? ErrorInline(
              title: 'No se pudo cargar la información',
              error: snapshot.error.toString(),
              onRetry: () => setState(() {}),
            )
          : MyDataWidget(data: snapshot.data),
    );
  },
)
```

### Error Crítico con Diálogo
```dart
void showCriticalError() {
  ErrorFullScreen.show(
    context: context,
    title: 'Error de Autenticación',
    error: 'Tu sesión ha expirado. Necesitas iniciar sesión nuevamente.',
    buttonText: 'Ir a Login',
    barrierDismissible: false,
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/login');
    },
  );
}
```

### Carga de Sección Específica
```dart
Container(
  height: 300,
  child: isLoadingStats 
    ? LoadingSpinner(
        message: "Calculando estadísticas...",
        type: LoadingType.linear,
        layout: LoadingLayout.vertical,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(12),
        showProgress: true,
        progress: calculationProgress,
      )
    : StatsWidget(data: statsData),
)
```

### Con Sistema de Temas
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FeedbackTheme(
      data: FeedbackTheme.dark(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: LoadingSpinner(
            message: 'Tema aplicado automáticamente',
            type: LoadingType.adaptive,
          ),
        ),
      ),
    );
  }
}
```
