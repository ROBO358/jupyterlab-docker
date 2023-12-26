FROM python:3.11-slim

ENV TZ=Asia/Tokyo
ENV LANG=ja_JP.UTF-8

WORKDIR /work

COPY requirements ./

RUN apt update
RUN pip install --no-cache-dir --upgrade pip

RUN apt install -y $(cat apt.txt | tr '\n' ' ') && apt clean && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --no-cache-dir jupyterlab
RUN python -m pip install --no-cache-dir -r pip.txt && pip cache purge

ENTRYPOINT [ "jupyterlab", "--ip", "0.0.0.0", "--allow-root", "-b", "localhost", "--NotebookApp.token=''", "--no-browser" ]
