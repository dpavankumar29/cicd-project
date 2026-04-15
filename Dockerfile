FROM python:3.9-slim

WORKDIR /app

COPY app.py .

EXPOSE 5500

CMD ["python", "app.py"]