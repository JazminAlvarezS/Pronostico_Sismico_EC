library(tidyverse)
library(tsibble)
library(here)

# 1. Leer los datos desde la carpeta data
datos <- read_csv(here("data", "query.csv"))

# 2. Transformar a tsibble mensual
sismos_ts <- datos %>%
  mutate(fecha_hora = as_datetime(time)) %>%
  mutate(mes = yearmonth(fecha_hora)) %>%
  group_by(mes) %>%
  summarise(
    total_sismos = n(),
    mag_maxima   = max(mag, na.rm = TRUE),
    mag_promedio = mean(mag, na.rm = TRUE)
  ) %>%
  as_tsibble(index = mes)

# 3. Mostrar el tsibble en consola
print(sismos_ts)

