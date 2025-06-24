# # ---------- Stage 1: Build ---------- (Multi-Stage)
#     FROM golang:1.24.4 AS builder

#     WORKDIR /app
#     COPY . .
    
#     # Disable CGO so no glibc dependency
#     ENV CGO_ENABLED=0
    
#     RUN go build -o service1
    
#     # ---------- Stage 2: Run ----------
#     FROM scratch
    
#     COPY --from=builder /app/service1 /service1
    
#     EXPOSE 8001
#     ENTRYPOINT ["/service1"]
    

#-----------------------------------------------(Normal Single Stage)
FROM golang:1.24.4

WORKDIR /app
COPY . .
RUN go build -o service1

EXPOSE 8001
CMD ["./service1"]
