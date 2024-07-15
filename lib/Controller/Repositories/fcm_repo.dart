import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FcmRepo {
  sendNotification(token) async {
    try {
      var headers = {
        "Authorization":
            "key=AAAA78dPFHo:APA91bGjaiO881h9rPQngJoCpX37D2s2xX9p1XMbx79whklJeITpZCvEO2kyalKQicxJe_DkBRysE6tC68EcWuyz27DpFB7A0fg6unRdj2xMoHOftzaHxusFrl0ABsq6MInpEF68vNa0",
        "Content-Type": "application/json"
      };
      var request = http.Request(
          "POST", Uri.parse('https://fcm.googleapis.com/fcm/send'));
      request.body = jsonEncode({
        "to": token,
        "data": {
          "title": "Your Route",
          "body": "owner has assigned a route to you let's look at that"
        }
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {}
      return response.statusCode;
    } on SocketException {
      return 503;
    } catch (e) {
      return 400;
    }
  }
}
