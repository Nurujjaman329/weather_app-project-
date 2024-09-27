import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:shared_preferences/shared_preferences.dart';

import '/models/hourly_weather.dart';
import '/models/weather.dart';
import '/models/weekly_weather.dart';
import '../constants/constants.dart';
import '../services/get_locator.dart';
import '../utils/logging.dart';

@immutable
class ApiHelper {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const weeklyWeatherUrl =
      'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';

  static double lat = 0.0;
  static double lon = 0.0;
  static final dio = Dio();

  //! Get lat and lon
  static Future<void> fetchLocation() async {
    try {
      final location = await getLocation();
      lat = location.latitude;
      lon = location.longitude;

      printInfo("Fetched location: latitude=$lat, longitude=$lon");

      if (lat == 0.0 || lon == 0.0) {
        throw Exception('Invalid latitude or longitude received.');
      }
    } catch (e) {
      printWarning("Location services are disabled or failed. Using cached data if available.");
      throw Exception('Failed to fetch location.');
    }
  }

  //* Current Weather
  static Future<Weather> getCurrentWeather() async {
    try {
      await fetchLocation();
      final url = _constructWeatherUrl();

      printInfo("Current Weather URL: $url");

      final response = await _fetchData(url);

      printInfo("Current Weather Response: $response");

      final weather = Weather.fromJson(response);
      await _saveDataToCache('currentWeather', weather.toJson());
      return weather;
    } catch (e) {
      printError('Fetching weather failed: $e');
      printWarning('Loading weather from cache');
      return await _loadDataFromCache(
          'currentWeather', (data) => Weather.fromJson(data));
    }
  }

  //* Hourly Weather
  static Future<HourlyWeather> getHourlyForecast() async {
    try {
      await fetchLocation();
      final url = _constructForecastUrl();
      printInfo("Hourly Forecast URL: $url");

      final response = await _fetchData(url);

      printInfo("Hourly Forecast Response: $response");

      final hourlyWeather = HourlyWeather.fromJson(response);
      await _saveDataToCache('hourlyWeather', hourlyWeather.toJson());
      return hourlyWeather;
    } catch (e) {
      printError('Fetching hourly forecast failed: $e');
      printWarning('Loading hourly forecast from cache');
      return await _loadDataFromCache(
          'hourlyWeather', (data) => HourlyWeather.fromJson(data));
    }
  }

  //* Weekly Weather
  static Future<WeeklyWeather> getWeeklyForecast() async {
    try {
      await fetchLocation();
      final url = _constructWeeklyForecastUrl();

      printInfo("Weekly Forecast URL: $url");

      final response = await _fetchData(url);

      printInfo("Weekly Forecast Response: $response");

      final weeklyWeather = WeeklyWeather.fromJson(response);
      await _saveDataToCache('weeklyWeather', weeklyWeather.toJson());
      return weeklyWeather;
    } catch (e) {
      printError('Fetching weekly forecast failed: $e');
      printWarning('Loading weekly forecast from cache');
      return await _loadDataFromCache(
          'weeklyWeather', (data) => WeeklyWeather.fromJson(data));
    }
  }

  //* Weather by City Name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);

    printInfo("Weather by City URL: $url");

    try {
      final response = await _fetchData(url);

      printInfo("Weather by City Response: $response");

      return Weather.fromJson(response);
    } catch (e) {
      printError('Failed to load weather for city $cityName: $e');
      throw Exception('Failed to load weather for city $cityName');
    }
  }

  //! Build URLs
  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructWeeklyForecastUrl() =>
      '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';

  //* Fetch Data for a URL
  static Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
      final response = await dio.get(url);

      printInfo('Request to $url returned status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        printWarning('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } on DioError catch (dioError) {
      printError('DioError fetching data from $url: ${dioError.message}');
      if (dioError.type == DioErrorType.connectionTimeout ||
          dioError.type == DioErrorType.receiveTimeout) {
        throw Exception('Connection timed out.');
      } else if (dioError.type == DioErrorType.unknown) {
        throw Exception('No internet connection or failed DNS lookup.');
      } else {
        throw Exception('Error fetching data: ${dioError.message}');
      }
    } catch (e) {
      printError('General error fetching data from $url: $e');
      throw Exception('Error fetching data');
    }
  }

  //! Cache Mechanism
  static Future<void> _saveDataToCache(
      String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  static Future<T> _loadDataFromCache<T>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      final data = jsonDecode(cachedData) as Map<String, dynamic>;

      printInfo('Loaded cached data for key $key: $data');

      return fromJson(data);
    } else {
      printError('No cached data available for key $key');
      throw Exception('No cached data available for $key');
    }
  }
}
