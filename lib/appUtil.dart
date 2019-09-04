import 'dart:io';

class AppUtil {
  static Future<bool> checkConnection() async {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        connected = true;
      }
    } on SocketException catch (e) {
      print("$e");
      print('not connected');
      connected = false;
    }

    return connected;
  }
}
