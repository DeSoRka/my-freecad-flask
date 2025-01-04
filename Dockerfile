FROM amrit3701/freecad-cli:latest

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install flask

WORKDIR /app
COPY . /app

CMD ["python3", "app.py"]
