# # ---------- Stage 1: Builder ----------
#     FROM python:3.12-slim AS builder

#     WORKDIR /install
#     COPY app.py . 
#     RUN pip install --upgrade pip \
#      && pip install --no-cache-dir --prefix=/install flask
    
#     # ---------- Stage 2: Final Run Image ----------
#     FROM python:3.12-slim
    
#     WORKDIR /app
#     COPY --from=builder /install /usr/local
#     COPY app.py .
    
#     EXPOSE 8002
#     CMD ["python", "app.py"]


#-------------------------------------------(Single stage build)
FROM python:3.12-slim

WORKDIR /app
COPY app.py .

RUN pip install --no-cache-dir flask

EXPOSE 8002
# CMD ["python", "app.py"]
ENTRYPOINT [ "python", "app.py"]