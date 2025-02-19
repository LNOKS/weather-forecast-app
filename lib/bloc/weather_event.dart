part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final double lat;
  final double lon;

  FetchWeather(this.lat, this.lon);
}