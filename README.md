# Taller Datos Abiertos de Colombia (Flutter) - ecomerk2

[cite_start]Este proyecto es una aplicación móvil desarrollada en **Flutter** para el consumo de la [API de Datos Abiertos de Colombia](https://api-colombia.com/)[cite: 405, 408].

##  Endpoints Implementados
[cite_start]Se seleccionaron 4 recursos principales para la visualización de datos[cite: 427, 526]:
1. [cite_start]**Departamentos:** Listado de divisiones administrativas[cite: 531].
2. [cite_start]**Regiones:** Información geográfica del país[cite: 538].
3. [cite_start]**Presidentes:** Datos históricos de mandatarios[cite: 544].
4. [cite_start]**Aeropuertos:** Información de terminales de transporte aéreo[cite: 553].

##  Arquitectura y Estructura
[cite_start]El proyecto sigue una estructura basada en la separación de responsabilidades por capas:
- [cite_start]**Config:** Parámetros globales y configuración de endpoints[cite: 484, 525].
- [cite_start]**Models:** Modelado de datos con serialización JSON.
- [cite_start]**Services:** Lógica de comunicación con la API (Peticiones HTTP).
- [cite_start]**Routes:** Gestión de navegación mediante `go_router`.
- [cite_start]**Views:** Interfaces de usuario (Dashboard, List, Detail).
- [cite_start]**Widgets:** Componentes reutilizables y manejo de estados visuales[cite: 472, 475].

##  Paquetes Utilizados
- [cite_start]`http`: Consumo de servicios REST.
- [cite_start]`go_router`: Navegación basada en rutas y parámetros.
- [cite_start]`flutter_dotenv`: Gestión de variables de entorno para la URL base[cite: 454, 653, 658].

##  Rutas Implementadas
[cite_start]Se configuraron las siguientes rutas en `app_router.dart`[cite: 620]:
- [cite_start]`/`: Pantalla principal de Dashboard[cite: 623].
- [cite_start]`/list/:endpointKey`: Listado dinámico según el recurso seleccionado[cite: 627].
- [cite_start]`/detail/:endpointKey/:id`: Detalle profundo del registro con visualización de JSON raw[cite: 634, 752].

##  Configuración
[cite_start]Para ejecutar el proyecto, asegúrate de tener un archivo `.env` en la raíz con la siguiente variable[cite: 499, 658, 801]:
`API_COLOMBIA_BASE_URL=https://api-colombia.com/api/v1`