# Usa una versione specifica di Python come base
# FROM python:3.9-slim
FROM ubuntu:20.04


# Installa le dipendenze di sistema
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3-pyqt5 \
    && rm -rf /var/lib/apt/lists/*

# Imposta la directory di lavoro nell'immagine
WORKDIR /app

# Copia i file locali nell'immagine
COPY smart_labelme.egg-info/requires.txt .
RUN apt-get update
RUN apt-get install -y software-properties-common
# Install pip from standard ubuntu packages
RUN apt-get install -y python3.9

RUN apt-get install -y python3-pip

# Installa le dipendenze Python specificate nel file requires.txt
RUN pip3 install --no-cache-dir -r requires.txt

# Copia i file dell'applicazione nell'immagine
COPY . .

RUN python3 setup.py build
RUN pip install .

RUN apt update -y && apt install -y gedit

# CMD /bin/bash
CMD smart_labelme