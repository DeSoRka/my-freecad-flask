FROM amrit3701/freecad-cli:latest

# Установка зависимостей для сборки Python из исходников
RUN apt-get update && apt-get install -y \
    wget build-essential zlib1g-dev libssl-dev libncurses-dev \
    libffi-dev libsqlite3-dev libreadline-dev libbz2-dev && \
    apt-get clean

# Скачивание и сборка Python 3.9
RUN wget https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tgz && \
    tar xvf Python-3.9.13.tgz && \
    cd Python-3.9.13 && \
    ./configure --enable-optimizations && \
    make && make install && \
    cd .. && rm -rf Python-3.9.13 Python-3.9.13.tgz

# Устанавливаем pip для Python 3.9
RUN python3.9 -m ensurepip && python3.9 -m pip install --upgrade pip

# Копируем файл зависимостей
COPY requirements.txt /app/requirements.txt

# Устанавливаем зависимости
RUN python3.9 -m pip install -r /app/requirements.txt

# Настраиваем рабочую директорию
WORKDIR /app
COPY . /app

# Запускаем приложение
CMD ["python3.9", "app.py"]
