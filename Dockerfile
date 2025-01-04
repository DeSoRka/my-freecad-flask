FROM amrit3701/freecad-cli:latest

# 1. Обновляем все пакеты внутри контейнера
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get clean

# 2. Устанавливаем pip, если он отсутствует
RUN apt-get install -y python3-pip && \
    pip3 --version

# 3. Обновляем pip, setuptools, wheel
RUN python3 -m pip install --upgrade pip setuptools wheel

# 4. Копируем requirements.txt и устанавливаем зависимости Python
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# 5. Рабочая директория и копирование приложения
WORKDIR /app
COPY . /app

# 6. Запуск приложения
CMD ["python3", "app.py"]
