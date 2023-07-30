FROM python:3.11-slim

WORKDIR /app

COPY . .

RUN pip3 install poetry==1.5.1 --no-cache-dir \
    && poetry config virtualenvs.create false \
    && poetry install --only main --no-interaction --no-cache
    
EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run" , "frontend.py", "--server.port=8501", "--server.address=0.0.0.0"]