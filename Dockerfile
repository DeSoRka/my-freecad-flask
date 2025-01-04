FROM amrit3701/freecad-cli:latest

RUN apt-get update && \
    apt-get install -y --only-upgrade libexpat1 && \
    apt-get upgrade -y && \
    apt-get clean

# Устанавливаем ваши приложения и зависимости (например, Python)
RUN apt-get install -y python3 python3-pip && pip3 install flask

WORKDIR /app
COPY . /app

CMD ["python3", "app.py"]
