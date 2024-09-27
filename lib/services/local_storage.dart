import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '/models/weather.dart';

class LocalStorageHelper {
  static Future<void> saveWeather(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    final String weatherJson = json.encode(weather.toJson());
    await prefs.setString('savedWeather', weatherJson);
  }

  static Future<Weather?> getSavedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final String? weatherJson = prefs.getString('savedWeather');

    if (weatherJson != null) {
      return Weather.fromJson(json.decode(weatherJson));
    }
    return null;
  }
}
