FROM gcc:latest

WORKDIR /usr/src/app

COPY server.cpp .

RUN g++ -o server server.cpp

CMD ["./server"]
