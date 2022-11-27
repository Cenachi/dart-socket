import 'dart:io';
import 'dart:typed_data';

void main() async {
  var server = await ServerSocket.bind("localhost", 3000);
  print("Server is running..");
  server.listen((Socket event) {
    handleConnections(event);
  });
}

List<Socket> clients = [];

void handleConnections(Socket client) {

  print("Server: Connection ${client.remoteAddress.address}");
  client.listen(
    (Uint8List data) {
      final message = String.fromCharCodes(data);

      for (final c in clients) {
        c.write("Server: $message joined the party!");
      }
      clients.add(client);
      client.write("Server: You are logged in as $message");
    },
    
    onError: (error) {
      print("Error");
      client.close();
    },
    onDone: () {
      print("Server: Client left");
      client.close();
    }
  );
}
