import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/get_city_forecast_controller.dart';
import '../models/famous_city.dart';
import '../utils/app_colors.dart';
import '../utils/get_weather_icons.dart';
import '../utils/text_styles.dart';

class CityWeatherTile extends ConsumerWidget {
  const CityWeatherTile({
    super.key,
    required this.city,
    required this.index,
  });

  final FamousCity city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(cityForecastProvider(city.name));

    return currentWeather.when(
      data: (weather) {
        return Padding(
          padding: const EdgeInsets.all(
            0.0,
          ),
          child: Material(
            color: index == 0 ? AppColors.lightBlue : AppColors.accentBlue,
            elevation: index == 0 ? 12 : 0,
            borderRadius: BorderRadius.circular(25.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row 1
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.main.temp!.round()}°',
                              style: TextStyles.h2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              weather.weather[0].description,
                              style: TextStyles.subtitleText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      // Row 2
                      Image.asset(
                        getWeatherIcon(weatherCode: weather.weather[0].id),
                        width: 50,
                      ),
                    ],
                  ),
                  Text(
                    weather.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
