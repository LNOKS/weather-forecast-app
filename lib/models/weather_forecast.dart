import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:weather_test_task/models/serializers.dart';

part 'weather_forecast.g.dart';

abstract class WeatherForecast implements Built<WeatherForecast, WeatherForecastBuilder> {
  BuiltList<WeatherDay> get days;

  WeatherForecast._();
  factory WeatherForecast([void Function(WeatherForecastBuilder) updates]) = _$WeatherForecast;

  static Serializer<WeatherForecast> get serializer => _$weatherForecastSerializer;

  static WeatherForecast? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(WeatherForecast.serializer, json);
  }

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WeatherForecast.serializer, this) as Map<String, dynamic>;
  }
}

abstract class WeatherDay implements Built<WeatherDay, WeatherDayBuilder> {
  DateTime get date;
  double get temperature;
  String get description;

  WeatherDay._();
  factory WeatherDay([void Function(WeatherDayBuilder) updates]) = _$WeatherDay;

  static Serializer<WeatherDay> get serializer => _$weatherDaySerializer;

  static WeatherDay? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(WeatherDay.serializer, json);
  }

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WeatherDay.serializer, this) as Map<String, dynamic>;
  }
}