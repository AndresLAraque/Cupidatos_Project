# Imagen base oficial (ya incluye Python, Jupyter, Pandas, NumPy, Scipy, etc.)
FROM jupyter/scipy-notebook:latest

# Cambiar a usuario root para instalar paquetes del sistema
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    # Limpiar
    && rm -rf /var/lib/apt/lists/*

# Volver al usuario de Jupyter
USER $NB_UID

# Copiar y ejecutar la instalación de librerías
COPY requirements.txt /tmp/requirements.txt
#RUN pip install --no-cache-dir -r /tmp/requirements.txt
RUN /bin/bash -c 'for i in 1 2 3; do pip install --force-reinstall --upgrade --timeout 1000 --no-cache-dir -r /tmp/requirements.txt && break || sleep 15; done'

# Carpeta de trabajo por defecto
WORKDIR /home/andres/work