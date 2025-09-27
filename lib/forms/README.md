# Form Widgets

Los widgets de formulario proporcionan componentes avanzados para crear formularios intuitivos y funcionales con validación integrada.

## Widgets Disponibles

> **Nota**: Esta sección está preparada para widgets de formulario. Los widgets se agregarán en futuras versiones.

## Widgets Planeados

### CustomTextField
- Campo de texto con validación integrada
- Múltiples estilos y configuraciones
- Soporte para prefijos, sufijos e iconos
- Formatters personalizables

### PasswordField
- Campo especializado para contraseñas
- Toggle para mostrar/ocultar contraseña
- Indicador de fortaleza de contraseña
- Validación automática

### CustomFormField
- Campo de formulario genérico y extensible
- Validación en tiempo real
- Soporte para diferentes tipos de entrada
- Estados de error y éxito

### SearchField
- Campo de búsqueda con sugerencias
- Debounce configurable
- Filtrado y resaltado de resultados
- Historial de búsquedas opcional

### DatePickerField
- Selector de fecha integrado en el formulario
- Múltiples formatos de fecha
- Validación de rangos
- Localización automática

### FormBuilder
- Constructor de formularios dinámicos
- Validación automática del formulario completo
- Serialización/deserialización de datos
- Soporte para formularios complejos

## Características Planeadas

- **Validación Avanzada**: Reglas de validación personalizables y reutilizables
- **Estados Visuales**: Indicadores claros de error, éxito y carga
- **Accesibilidad**: Soporte completo para lectores de pantalla
- **Responsive**: Adaptación automática a diferentes tamaños de pantalla
- **Localización**: Soporte multi-idioma para mensajes de error

## Contribuir

Si tienes ideas para widgets de formulario útiles, no dudes en contribuir o sugerir nuevas funcionalidades.

## Ejemplos

Los ejemplos de uso se agregarán cuando los widgets estén disponibles.

```dart
// Ejemplo futuro de TextField personalizado
CustomTextField(
  label: 'Email',
  hint: 'Ingresa tu email',
  validator: EmailValidator(),
  keyboardType: TextInputType.emailAddress,
  prefixIcon: Icons.email,
)

// Ejemplo futuro de FormBuilder
FormBuilder(
  fields: [
    FormFieldConfig(
      key: 'name',
      type: FieldType.text,
      label: 'Nombre completo',
      required: true,
    ),
    FormFieldConfig(
      key: 'email',
      type: FieldType.email,
      label: 'Correo electrónico',
      validator: EmailValidator(),
    ),
  ],
  onSubmit: (data) {
    // Procesar datos del formulario
    print('Datos: $data');
  },
)
```

## Validadores Planeados

- `EmailValidator`: Validación de formato de email
- `PasswordValidator`: Validación de contraseñas seguras  
- `PhoneValidator`: Validación de números telefónicos
- `URLValidator`: Validación de URLs
- `LengthValidator`: Validación de longitud mínima/máxima
- `PatternValidator`: Validación con expresiones regulares personalizadas