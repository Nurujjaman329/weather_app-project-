import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/weekly_weather.dart';
import '../services/api_services.dart';

final weeklyForecastProvider = FutureProvider.autoDispose<WeeklyWeather>(
  (ref) => ApiHelper.getWeeklyForecast(),
);
