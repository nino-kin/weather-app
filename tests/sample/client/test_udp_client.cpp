#include <gtest/gtest.h>
#include <thread>
#include <iostream>
#include <netinet/in.h>
#include <sys/socket.h>

#include "udp_common.hpp"

// Include the client source code here

TEST(UDPClientTest, SendMessage) {
    // Create a socket and bind it to a port (simulating server)
    int sockfd;
    struct sockaddr_in servaddr;

    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket creation failed");
        exit(EXIT_FAILURE);
    }

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(PORT);
    servaddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(sockfd, (const struct sockaddr*)&servaddr, sizeof(servaddr)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    // Start the client in a separate thread
    std::thread client_thread([](){
        const char* hello = "Hello from client";
        struct sockaddr_in servaddr;
        int sockfd;

        if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
            perror("socket creation failed");
            exit(EXIT_FAILURE);
        }

        memset(&servaddr, 0, sizeof(servaddr));
        servaddr.sin_family = AF_INET;
        servaddr.sin_port = htons(PORT);
        servaddr.sin_addr.s_addr = INADDR_ANY;

        int n;
        socklen_t len;

        sendto(sockfd, hello, strlen(hello), MSG_CONFIRM, (const struct sockaddr*) &servaddr, sizeof(servaddr));
        close(sockfd);
    });

    // Wait for the client thread to finish
    client_thread.join();

    // Receive message on the server side
    char buffer[MAXLINE];
    int n;
    socklen_t len;
    n = recvfrom(sockfd, buffer, MAXLINE, MSG_WAITALL, nullptr, nullptr);
    buffer[n] = '\0';

    // Check if received message is correct
    std::string received_message(buffer);
    EXPECT_EQ(received_message, "Hello from client");

    // Clean up
    close(sockfd);
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
