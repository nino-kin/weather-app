# UDP Communication

## UDP Server-Client sample

cf. [UDP Server-Client implementation in C++](https://www.geeksforgeeks.org/udp-server-client-implementation-c/)

### Overview

The entire process can be broken down into the following steps : 

UDP Server :

1. Create a UDP socket.
1. Bind the socket to the server address.
1. Wait until the datagram packet arrives from the client.
1. Process the datagram packet and send a reply to the client.
1. Go back to Step 3.


UDP Client :

1. Create a UDP socket.
1. Send a message to the server.
1. Wait until a response from the server is received.
1. Process the reply and go back to step 2, if necessary.
1. Close socket descriptor and exit.

### Build

```console
$ ./build/src/sample/server/udp_server &
$ ./build/src/sample/client/udp_client
$ wait
```

### Output

```console
Hello message sent.
Client : Hello from client
Hello message sent.
Server :Hello from server
```
