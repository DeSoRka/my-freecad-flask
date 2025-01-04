FROM amrit3701/freecad-cli:latest

# 1. Обновляем все пакеты внутри контейнера
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get clean

# 2. Удаляем старую версию Python (если она есть) и устанавливаем Python 3.8+
RUN apt-get remove -y python3 python3-pip && \
    apt-get install -y \
    software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.8 python3.8-distutils && \
    apt-get clean

# 3. Устанавливаем pip для Python 3.8
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.8

# 4. Обновляем pip, setuptools, wheel
RUN python3.8 -m pip install --upgrade pip setuptools wheel

# 5. Копируем requirements.txt и устанавливаем зависимости Python
COPY requirements.txt /app/requirements.txt
RUN python3.8 -m pip install --no-cache-dir -r /app/requirements.txt

# 6. Настраиваем рабочую директорию и копируем приложение
WORKDIR /app
COPY . /app

# 7. Запуск приложения
CMD ["python3.8", "app.py"]
