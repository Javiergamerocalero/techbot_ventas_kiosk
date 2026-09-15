# Izipay PinPad P400 — qué manda cada operación

Resumen de las **Especificaciones Técnicas PMP-API REST v2.3** (Procesos de Medios de Pago, enero 2023),
que es el documento que manda. Está acá porque el PDF no se puede versionar en el repo y porque ya nos
costó dos entregas equivocarnos con estos campos.

Todo va por `POST /API_PPAD/procesarTransaccion` con `Authorization: Bearer <token>` del `/login`.

## La tabla que importa

| Operación | `ecr_transaccion` | Campos que van, y ninguno más |
|---|---|---|
| Compra (tarjeta) | `01` | `ecr_amount`, `ecr_currency_code` |
| Consulta de BIN | `01` | `ecr_amount`, `ecr_currency_code`, `ecr_data_adicional3` = `"1"` |
| Cancelar tras BIN | `01` | los mismos, con `ecr_data_adicional3` = `"9"` |
| Compra con opción de QR | `01` | `ecr_amount`, `ecr_currency_code`, `ecr_data_adicional` = `"0"` |
| **Compra QR directo** | **`67`** | `ecr_amount`, `ecr_currency_code`, `ecr_data_adicional` = `"0"` |
| Anulación | `06` | `ecr_amount`, `ecr_currency_code`, `ecr_data_adicional` = referencia |
| Reporte detallado | `09` | **ninguno** |
| Reporte de totales | `10` | **ninguno** |
| Reimpresión | `11` | `ecr_data_adicional` = referencia del voucher |
| Cierre | `12` | **ninguno** |
| Reporte detallado / cierre | `19` | **ninguno** |
| Reporte totales / cierre | `20` | **ninguno** |
| Reimpresión de lote | `28` | `ecr_data_adicional2` = número de lote |

`ecr_aplicacion` va siempre en `"POS"`. Moneda: soles `604`, dólares `840`. El monto lleva los dos
últimos dígitos como decimales y sin punto: 10.50 → `"1050"`, 0.10 → `"010"`.

**Las de supervisor no llevan moneda.** Agregársela, o mandarles un `ecr_data_adicional` vacío, hace que
el pinpad responda con código 89. Nos pasó el 2026-09-15 con el reporte detallado.

## Cierre de lote: son tres transacciones, no una

El manual (4.8) dice que la caja debe mandar, en orden y cortando si alguna no aprueba:

1. `19` reporte detallado de cierre → imprimir el voucher,
2. `20` reporte de totales de cierre → imprimir el voucher,
3. `12` cierre → imprimir el voucher y terminar.

## QR: son dos transacciones distintas

- **Con opción de QR** (8.1): transacción `01` con `ecr_data_adicional` en `"0"`. El pinpad ofrece
  tarjeta o QR, y se salta la consulta de BIN.
- **QR directo** (8.2): transacción `67`. Va directo al QR.

Las dos tienen prohibido ir precedidas de una consulta de BIN. Por eso `purchase()` se salta el paso del
BIN cuando el modo es QR, aunque la configuración del kiosco lo tenga activado.

## El voucher (`print_data`)

Cada línea termina en `0x0D` y empieza con un byte que dice cómo imprimirla:

- `0x41` fuente normal (38 caracteres), `0x42` doble (19 caracteres), `0x43` y `0x44` las mismas en
  inverso. El manual dice tratar 43 como 41 y 44 como 42.
- Línea en blanco: `32 1B 20 0D`.
- Línea de imagen: `32 1C ZZ 0D`, hoy solo el check de Visa DCC.

**Ojo con las dos últimas: empiezan con `0x32`, que es el carácter `2`.** Si no se tratan aparte, cada
línea en blanco del voucher se imprime como un `2` suelto.

## Respuesta

`response_code` en `"00"` es aprobada; cualquier otro valor es rechazo, y `message` trae el detalle.
`print_data` solo viene cuando aprueba. En reimpresión y reportes el `message` dice `RESERVADO`, que no
es un error: es lo que el manual documenta para esas operaciones.
