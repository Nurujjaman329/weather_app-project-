import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/foundation.dart';

@immutable
class Weather {
  final Coord coord;
  final List<WeatherData> weather;
  final String base;
  final Main main;
  final int? visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const Weather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    this.visibility,
    required this.wind,
    this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>)
            .map((e) => WeatherData.fromJson(e as Map<String, dynamic>))
            .toList(),
        base: json['base'] as String,
        main: Main.fromJson(json['main'] as Map<String, dynamic>),
        visibility: json['visibility'],
        wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
        rain: json['rain'] != null
            ? Rain.fromJson(json['rain'] as Map<String, dynamic>)
            : null,
        clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
        dt: json['dt'] as int,
        sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
        timezone: json['timezone'] as int,
        id: json['id'] as int,
        name: json['name'] as String,
        cod: json['cod'] as int,
      );

  Map<String, dynamic> toJson() => {
        'coord': coord.toJson(),
        'weather': weather.map((e) => e.toJson()).toList(),
        'base': base,
        'main': main.toJson(),
        'visibility': visibility,
        'wind': wind.toJson(),
        'rain': rain?.toJson(),
        'clouds': clouds.toJson(),
        'dt': dt,
        'sys': sys.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };
}

@immutable
class Coord {
  final double lon;
  final double lat;

  const Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon'] as double,
        lat: json['lat'] as double,
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}

@immutable
class WeatherData {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherData({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}

@immutable
class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;
  final int? visibility;

  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
    this.visibility,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] != null) ? json['temp'].toDouble() : null,
      feelsLike:
          (json['feels_like'] != null) ? json['feels_like'].toDouble() : null,
      tempMin: (json['temp_min'] != null) ? json['temp_min'].toDouble() : null,
      tempMax: (json['temp_max'] != null) ? json['temp_max'].toDouble() : null,
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      visibility:
          (json['visibility'] != null) ? json['visibility'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'pressure': pressure,
        'humidity': humidity,
      };
}

@immutable
class Wind {
  final double speed;
  final int deg;
  final double? gust;

  const Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'] ?? 0.0,
        deg: json['deg'] ?? 0,
        gust: json['gust'],
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };
}

@immutable
class Rain {
  final double? oneHour;

  const Rain({this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(oneHour: json['oneHour'] ?? 0.0);
  }

  Map<String, dynamic> toJson() => {
        '1h': oneHour,
      };
}

@immutable
class Clouds {
  final int all;

  const Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all'] ?? 0);
  }

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}

@immutable
class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  const Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json['type'] ?? 0,
        id: json['id'] ?? 0,
        country: json['country'] ?? '',
        sunrise: json['sunrise'] ?? 0,
        sunset: json['sunset'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}
