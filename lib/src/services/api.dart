import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:diacritic/diacritic.dart';

class ApiService {
  static const String apiUrl = 'http://191.101.18.67:3000';
  static final storage = new FlutterSecureStorage();

  static Future<Map<String, dynamic>> getTask(String taskId) async {
    final apiResponse = await http.get(
      Uri.parse('$apiUrl/tasks/$taskId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': await storage.read(key: 'authentication_token'),
      },
    );

    if (apiResponse.statusCode == 200) {
      return json.decode(apiResponse.body)['data'];
    } else {
      return null;
    }
  }

  static String getTaskImage(String taskName) {
    String taskNameWithoutDiacritic = removeDiacritics(taskName);
    return '$apiUrl/public/tasks_images/$taskNameWithoutDiacritic.png';
  }

  static String getTaskAudio(String taskName) {
    String taskNameWithoutDiacritic = removeDiacritics(taskName);
    return '$apiUrl/public/tasks_complete_audios/$taskNameWithoutDiacritic.mp3';
  }

  static String getSyllableAudio(String taskName, String syllable) {
    String taskNameWithoutDiacritic = removeDiacritics(taskName);
    String syllableWithoutDiacritic = removeDiacritics(syllable);
    return '$apiUrl/public/tasks_audios/$taskNameWithoutDiacritic/$syllableWithoutDiacritic.mp3';
  }

  static Future<List<dynamic>> getAllTasks() async {
    var apiResponse = await http.get(
      Uri.parse('$apiUrl/tasks'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': await storage.read(key: 'authentication_token'),
      },
    );

    if (apiResponse.statusCode == 200) {
      return json.decode(apiResponse.body)['data'];
    } else {
      return [];
    }
  }
}
