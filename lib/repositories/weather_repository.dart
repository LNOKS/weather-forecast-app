import 'package:dio/dio.dart';
import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:built_collection/built_collection.dart';

class WeatherRepository {
  final Dio _dio;

  WeatherRepository() : _dio = Dio() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['appid'] = '37ea9939152496e5de6ca532f93817fd';
        return handler.next(options);
      },
    ));
  }

  Future<WeatherForecast> getWeatherForecast(double lat, double lon) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/forecast',
      queryParameters: {'lat': lat, 'lon': lon, 'units': 'metric'},
    );

    final List<dynamic> list = response.data['list'];
    final weatherDays = list.map((item) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      final temp = item['main']['temp'].toDouble();
      final description = item['weather'][0]['description'];

      return WeatherDay((b) => b
        ..date = dateTime
        ..temperature = temp
        ..description = description);
    }).toList();

    return WeatherForecast((b) => b
      ..days = ListBuilder(weatherDays));
  }
}