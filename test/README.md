# Test Organization

Este directorio contiene todas las pruebas unitarias para los widgets de la librería, organizadas de manera lógica y escalable.

## Estructura de Directorios

```
test/
├── flutter_widgets_test.dart          # Punto de entrada principal
├── feedback_test.dart                 # Runner para widgets de feedback
├── feedback/                          # Tests individuales de feedback 
│   ├── error_compact_test.dart
│   ├── error_fullscreen_test.dart
│   ├── error_inline_test.dart
│   ├── loading_spinner_test.dart
│   └── feedback_integration_test.dart
└── README.md                         # Este archivo
```

## Comandos de Testing

### Ejecutar Todos los Tests
```bash
flutter test
```

### Ejecutar Tests por Categoría
```bash
# Solo widgets de feedback
flutter test test/feedback_test.dart

# Widget específico
flutter test test/feedback/error_compact_test.dart
```

### Tests con Coverage
```bash
flutter test --coverage
```

### Tests en Modo Verbose
```bash
flutter test --reporter=verbose
```

## Filosofía de Testing

### Por Widget Individual
- **Un archivo por widget**: Cada widget tiene su propio archivo de test
- **Tests exhaustivos**: Cubrimos render, interacciones, estados, y edge cases
- **Nomenclatura clara**: `{widget_name}_test.dart`

### Por Categoría
- **Agrupación lógica**: Tests organizados por tipo de widget (feedback, controls, etc.)
- **Integration tests**: Tests que prueban múltiples widgets trabajando juntos
- **Test runners**: Archivos que ejecutan todos los tests de una categoría

### Cobertura Completa
- ✅ **Render Tests**: Verifican que el widget se renderice correctamente
- ✅ **Interaction Tests**: Prueban callbacks y interacciones del usuario
- ✅ **State Tests**: Verifican diferentes estados del widget
- ✅ **Configuration Tests**: Prueban opciones personalizables
- ✅ **Accessibility Tests**: Verifican compatibilidad con lectores de pantalla
- ✅ **Integration Tests**: Prueban widgets trabajando en conjunto
- ✅ **Edge Cases**: Casos límite y manejo de errores

## Agregando Nuevos Tests

### Para un Nuevo Widget
1. Crear archivo `test/{category}/{widget_name}_test.dart`
2. Seguir la estructura de tests existentes
3. Agregar al runner correspondiente (`test/{category}_test.dart`)
4. Actualizar el test principal si es necesario

### Para una Nueva Categoría
1. Crear directorio `test/{category}/`
2. Crear runner `test/{category}_test.dart`
3. Agregar al test principal `test/flutter_widgets_test.dart`

## Mejores Prácticas

### Estructura de Test Individual
```dart
void main() {
  group('WidgetName Tests', () {
    testWidgets('basic functionality', (tester) async {
      // Test implementation
    });
    
    group('Configuration', () {
      // Tests for different configurations
    });
    
    group('Interactions', () {
      // Tests for user interactions
    });
    
    group('Accessibility', () {
      // Accessibility tests
    });
  });
}
```

### Convenciones de Naming
- **Test files**: `{widget_name}_test.dart`
- **Test groups**: Use descriptive names
- **Test cases**: Start with action verb ("renders", "shows", "calls", etc.)

### Widget Testing Patterns
- Always wrap widgets in MaterialApp for proper context
- Use `tester.pumpWidget()` to render widgets
- Use `tester.pump()` or `tester.pumpAndSettle()` after interactions
- Verify state changes with appropriate `expect()` statements

## Métricas de Cobertura

Los tests actuales proporcionan cobertura completa para:
- ✅ **ErrorCompact**: 8 tests (render, interactions, accessibility)
- ✅ **ErrorFullScreen**: 5 tests (dialog behavior, navigation)
- ✅ **ErrorInline**: 8 tests (layout, configuration, structure)
- ✅ **LoadingSpinner**: 7 tests (colors, structure, accessibility)
- ✅ **Integration**: 5 tests (múltiples widgets, performance, themes)

**Total**: 33+ tests individuales con cobertura completa de funcionalidad, accesibilidad e integración.