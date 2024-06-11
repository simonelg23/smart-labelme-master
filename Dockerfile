# Usa una versione specifica di Python come base
FROM python:3.9-slim

# Installa le dipendenze di sistema
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3-pyqt5 \
    && rm -rf /var/lib/apt/lists/*

# Imposta la directory di lavoro nell'immagine
WORKDIR /app

# Copia i file locali nell'immagine
COPY smart_labelme.egg-info/requires.txt .

# Installa le dipendenze Python specificate nel file requires.txt
RUN pip install --no-cache-dir -r requires.txt

# Copia i file dell'applicazione nell'immagine
COPY labelme/app.py .
