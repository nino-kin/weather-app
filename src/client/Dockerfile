FROM gcc:latest

WORKDIR /usr/src/app

COPY client.cpp .

RUN g++ -o client client.cpp

CMD ["./client"]
