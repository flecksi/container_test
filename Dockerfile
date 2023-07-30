FROM python:3.11-slim

WORKDIR /app

COPY . .

RUN pip3 install poetry==1.5.1 --no-cache-dir \
    && poetry config virtualenvs.create false \
    && poetry install --only main --no-interaction --no-cache \
    && pip3 uninstall -y poetry \
    && pip3 uninstall -y altair \
    && rm -rf /root/.cache/pip \
    && rm -rf /root/.cache/pypoetry \
    && rm -rf /root/.local/share/virtualenvs \
    && dpkg --remove --force-depends ca-certificates \
    && dpkg --remove --force-depends build-essential \
    && dpkg --remove --force-depends gcc \
    && dpkg --remove --force-depends libexpat1-dev \
    && dpkg --remove --force-depends libffi-dev \
    && dpkg --remove --force-depends libgdbm-compat-dev \
    && dpkg --remove --force-depends libgdbm-dev \
    && dpkg --remove --force-depends liblzma-dev \
    && dpkg --remove --force-depends libncursesw5-dev \
    && dpkg --remove --force-depends libreadline-dev \
    && dpkg --remove --force-depends libsqlite3-dev \
    && dpkg --remove --force-depends libssl-dev \
    && dpkg --remove --force-depends make \
    && dpkg --remove --force-depends tk-dev \
    && dpkg --remove --force-depends uuid-dev \
    && dpkg --remove --force-depends zlib1g-dev \
    && dpkg --remove --force-depends libbz2-dev \
    && apt autoremove -y
    
EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run" , "frontend.py", "--server.port=8501", "--server.address=0.0.0.0"]