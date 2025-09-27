# Control Widgets

Los widgets de control proporcionan elementos de interfaz interactivos y reutilizables para mejorar la experiencia del usuario.

## Widgets Disponibles

> **Nota**: Esta sección está preparada para widgets de control. Los widgets se agregarán en futuras versiones.

## Widgets Planeados

### CustomButton
- Botón personalizable con múltiples estilos
- Soporte para iconos y estados de carga
- Variantes: primary, secondary, outline, text

### CustomDropdown
- Dropdown personalizable con búsqueda
- Soporte para elementos complejos
- Validación integrada

### CustomCheckbox
- Checkbox con título y descripción
- Estados: checked, unchecked, indeterminate
- Estilos personalizables

### SwitchTile
- Switch personalizable con título y descripción
- Adaptativo al tema de la aplicación
- Opcional: subtitle y trailing widgets

### CustomSlider
- Slider personalizable con etiquetas
- Rangos personalizables
- Indicadores de valor opcionales

### RatingBar
- Barra de calificación interactiva
- Iconos personalizables (estrellas, corazones, etc.)
- Soporte para medias calificaciones

## Contribuir

Si tienes ideas para widgets de control útiles, no dudes en contribuir o sugerir nuevas funcionalidades.

## Ejemplos

Los ejemplos de uso se agregarán cuando los widgets estén disponibles.

```dart
// Ejemplo futuro
CustomButton(
  text: 'Mi Botón',
  style: ButtonStyle.primary,
  onPressed: () {
    // Acción del botón
  },
)

// Dropdown personalizado
CustomDropdown<String>(
  items: ['Opción 1', 'Opción 2', 'Opción 3'],
  value: selectedValue,
  onChanged: (value) => setState(() => selectedValue = value),
  hint: 'Selecciona una opción',
)
```