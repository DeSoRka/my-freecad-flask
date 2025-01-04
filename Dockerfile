FROM amrit3701/freecad-cli:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Если pip отсутствует, добавьте
    python3-pip \
    # Опциональные пакеты
    libfreetype6 \
    libnss3 \
    libpq-dev \
    libexpat1 \
    && apt-get clean

# Убедитесь, что pip действительно доступен
RUN pip3 --version

# Обновляем pip, setuptools, wheel
RUN python3 -m pip install --upgrade pip setuptools wheel

# Копируем файл зависимостей
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

WORKDIR /app
COPY . /app

CMD ["python3", "app.py"]
