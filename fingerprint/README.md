# Lector de huellas — Synaptics `06cb:009a`

Configuración del lector de huellas de la ThinkPad L480 en CachyOS con Niri + Noctalia.

| Dato | Valor |
| --- | --- |
| Lector | `06cb:009a Synaptics, Inc. Metallica MIS Touch Fingerprint Reader` |
| Driver | `python-validity` (AUR) + `open-fprintd` |
| Enrolado | `right-index-finger` |
| Uso | SDDM (login) y lockscreen de Noctalia |
| Respaldo | Contraseña siempre disponible |

---

## Por qué `python-validity` y no `fprintd`

El `libfprint`/`fprintd` oficial **no soporta** `06cb:009a` (verificado con `libfprint 1.94.100`). El soporte viene de un driver reversado:

- `python-validity` — implementa el protocolo del sensor.
- `open-fprintd` — reemplaza el daemon `fprintd` y expone la API D-Bus que esperan los escritorios.
- `fprintd-clients` — aporta `fprintd-enroll`, `fprintd-verify`, `fprintd-list` y `pam_fprintd.so`.

> ⚠️ Es un driver **no auditado** que extrae un blob del driver de Windows. Funciona, pero no es código oficial de freedesktop. La huella **no sustituye** la contraseña.

---

## 1. Instalación

```bash
paru -S python-validity
```

El `.install` del paquete ya activa `open-fprintd` y `python3-validity`. Añade el manejo de suspensión (necesario para que el lector siga funcionando al despertar):

```bash
sudo systemctl enable open-fprintd-resume open-fprintd-suspend
```

Comprobar que el sensor se detecta:

```bash
systemctl status python3-validity open-fprintd --no-pager
fprintd-list "$USER"
```

Salida esperada:

```
found 1 devices
Device at /net/reactivated/Fprint/Device/0
```

---

## 2. Enrolar la huella

```bash
fprintd-enroll
```

Se apoya y se levanta el dedo varias veces (unas 5–10 lecturas) hasta `enroll-completed`. Si falla por permisos:

```bash
sudo fprintd-enroll "$(whoami)"
```

> Pasar siempre el nombre del usuario. Si se corre `sudo fprintd-enroll` sin argumento, la huella queda asociada a `root`.

Verificar:

```bash
fprintd-verify
fprintd-list "$USER"
```

Debe terminar en `verify-match (done)` y listar el dedo:

```
 - #0: right-index-finger
```

---

## 3. Activar en SDDM (login)

```bash
sudo cp /etc/pam.d/sddm /etc/pam.d/sddm.bak.$(date +%Y%m%d-%H%M%S)
sudo sed -i '1i auth sufficient pam_fprintd.so max_tries=1 timeout=10' /etc/pam.d/sddm
```

Resultado:

```
auth sufficient pam_fprintd.so max_tries=1 timeout=10
#%PAM-1.0

auth        include     system-login
```

En la pantalla de SDDM: **pulsar `Enter` con el campo de contraseña vacío**. Ahí arranca la lectura de huella; si falla o pasan 10 s, el campo de contraseña sigue funcionando.

También se puede automatizar con [`setup.sh`](setup.sh):

```bash
sudo ./setup.sh
```

---

## 4. Lockscreen de Noctalia

No requiere configuración: Noctalia detecta `fprintd` por D-Bus y ofrece la huella sola (`Mod+Alt+L` o al volver de suspender). Basta con que `fprintd-verify` funcione.

---

## 5. `sudo` con huella (opcional)

```bash
sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.bak.$(date +%Y%m%d-%H%M%S)
sudo sed -i '1i auth sufficient pam_fprintd.so max_tries=1 timeout=10' /etc/pam.d/sudo
```

o:

```bash
sudo ./setup.sh --with-sudo
```

> ⚠️ **Riesgo (CVE-2024-37408):** con la huella como `sufficient` al inicio del PAM, un proceso malicioso dentro de la sesión podría aprovechar una lectura para elevar permisos. Por eso se dejó **desactivado** para `sudo`; la huella se usa solo en SDDM y el lockscreen.

---

## Verificación rápida

```bash
fprintd-verify && fprintd-list "$USER"
systemctl is-active python3-validity open-fprintd
grep pam_fprintd /etc/pam.d/sddm
```

---

## Problemas y soluciones

| Síntoma | Solución |
| --- | --- |
| `Device is already in use` | Otro `fprintd-verify`/`fprintd-enroll` sigue abierto. Ciérralo (`Ctrl+C`) y reintenta. |
| `No devices available` | `sudo systemctl restart python3-validity open-fprintd` |
| No funciona tras suspender | `sudo systemctl enable open-fprintd-resume open-fprintd-suspend` |
| Error al enrolar | Probar a deslizar el dedo más lento o más rápido; el sensor es táctil y necesita movimiento. |
| SDDM ignora la huella | Revisar que `pam_fprintd.so` esté en la **primera línea** de `/etc/pam.d/sddm`. |
| `list_devices failed` | Revisar `journalctl -u python3-validity -b` |

---

## Revertir

Quitar la huella de SDDM:

```bash
sudo cp /etc/pam.d/sddm.bak.* /etc/pam.d/sddm
```

Quitar la huella de `sudo` (si se activó):

```bash
sudo cp /etc/pam.d/sudo.bak.* /etc/pam.d/sudo
```

Borrar el enrolado:

```bash
fprintd-delete "$USER"
```

Desinstalar el driver:

```bash
paru -Rns python-validity open-fprintd fprintd-clients
```

---

## Mantenimiento

- Tras una actualización que rompa el driver: `paru -S python-validity` y repetir la verificación.
- Re-enrolar si cambia el dedo o se quiere otro:
  ```bash
  fprintd-delete "$USER"
  fprintd-enroll
  ```
- Los respaldos de PAM quedan como `/etc/pam.d/<servicio>.bak.AAAAmmdd-HHMMSS`.
