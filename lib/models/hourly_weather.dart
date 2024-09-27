import 'package:flutter/foundation.dart' show immutable;

import 'weather.dart';

@immutable
class HourlyWeather {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherEntry> list;
  final City? city;

  const HourlyWeather({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      cod: json['cod'] ?? '',
      message: json['message'] ?? 0,
      cnt: json['cnt'] ?? 0,
      list: (json['list'] as List<dynamic>)
          .map((entry) => WeatherEntry.fromJson(entry))
          .toList(),
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': list.map((entry) => entry.toJson()).toList(),
        'city': city?.toJson(),
      };
}

@immutable
class WeatherEntry {
  final int dt;
  final Main main;
  final List<WeatherData> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final dynamic pop;
  final Sys? sys;
  final Rain? rain;
  final String dtTxt;

  const WeatherEntry({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.rain,
    required this.dtTxt,
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
      dt: json['dt'] ?? 0,
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List<dynamic>)
          .map((weatherData) => WeatherData.fromJson(weatherData))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'] ?? 0,
      pop: json['pop'] ?? 0.0,
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'main': main.toJson(),
        'weather': weather.map((data) => data.toJson()).toList(),
        'clouds': clouds.toJson(),
        'wind': wind.toJson(),
        'visibility': visibility,
        'pop': pop,
        'sys': sys?.toJson(),
        'rain': rain?.toJson(),
        'dt_txt': dtTxt,
      };
}

@immutable
class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf,
      };
}

@immutable
class Clouds {
  final int all;

  const Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}

@immutable
class Wind {
  final double speed;
  final int deg;
  final double gust;

  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coord': coord.toJson(),
        'country': country,
        'population': population,
        'timezone': timezone,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}

@immutable
class Coord {
  final double lat;
  final double lon;

  const Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}

@immutable
class Rain {
  final double threeHours;

  const Rain({
    required this.threeHours,
  });

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(threeHours: json['3h'] ?? 0.0);
  }

  Map<String, dynamic> toJson() => {
        '3h': threeHours,
      };
}

@immutable
class Sys {
  final String pod;

  const Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'pod': pod,
      };
}
