FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app
RUN sed -i 's|deb.debian.org|ftp.debian.org|g' /etc/apt/sources.list.d/debian.sources || true
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list || true \
default-libmysqlclient-dev pkg-config \
gcc \
libc6-dev \
&& rm -rf /var/lib/apt/lists/*
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app/
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
