import 'dart:io';
import 'dart:typed_data';

void main() async {
  var socket = await Socket.connect("localhost", 3000);

  print("Client: Connecting to server..");

  socket.listen(    
    (Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print("Client: $serverResponse");
    },

    onError: (error) {
      print("Client: $error");
      socket.destroy();
    },
  
    onDone: () {
      print("Client: Server left");
      socket.destroy();
    }
  );

  String? username;

  do{
    print("Client: Please enter username: ");
    username = stdin.readLineSync();
  }while(username == null || username.isEmpty);

  socket.write(username);
}
