import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:nexthour/common/global.dart';
import 'package:nexthour/models/AudioModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/apipath.dart';
import 'dart:io';

class AudioProvider with ChangeNotifier {
  AudioModel audioModel = AudioModel();

  Future<void> loadData() async {
    var token;
    if (kIsWeb) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      token = sharedPreferences.getString('token');
    } else {
      token = await storage.read(key: "authToken");
    }
    final response = await http.get(
      Uri.parse(APIData.audios),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    print("Audio API Status Code :-> ${response.statusCode}");
    log("Audios API Response :-> ${response.body}");
    if (response.statusCode == 200) {
      audioModel = AudioModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      print("Audio API Status Code :-> ${response.statusCode}");
    }
  }
}
