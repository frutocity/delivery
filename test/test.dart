import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  var socket =
      IO.io('https://betting-socket.dqotsolutions.com', <String, dynamic>{
    'transports': ['websocket'],
    'extraHeaders': {'foo': 'bar'}
  });
  socket.connect();
  socket.onConnect((_) {
    print('connected');
  });
}
