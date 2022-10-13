import 'dart:convert';

import 'package:http/http.dart' as http;

class FCMServices {
  void sendMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAKu1v2qI:APA91bHapGnCo5g_G3_eoYwYi9pMX72MDSlgk78vUCqazMpJMnqrXZWAVRgbyTrxyEQ5VCnFTHkL6YvAw6QzXLa3o21GaZG5Fmiwb-XU1_HEDwNx5yqaAmAbvzN6WFQrBMPe7UiMRN3u',
          },
          body: jsonEncode({
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'notification': {
              'title': title,
              'body': body,
              'android_channel_id': 'tokopaedi_channel',
            },
            'to': token,
          }));
    } catch (e) {
      rethrow;
    }
  }
}
