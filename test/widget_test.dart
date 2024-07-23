import 'dart:io';

void main() {
  checkServerConnection();
}

void checkServerConnection() async {
  try {
    final result = await InternetAddress.lookup('192.168.18.3');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Servidor está acessível: ${result[0]}');
    }
  } on SocketException catch (_) {
    print('Servidor não está acessível.');
  }
}
