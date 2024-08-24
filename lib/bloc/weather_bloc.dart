import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:weather_test_task/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final forecast = await repository.getWeatherForecast(event.lat, event.lon);
      emit(WeatherLoaded(forecast));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    try {
      final forecast = WeatherForecast.fromJson(json['forecast'] as Map<String, dynamic>);
      return forecast != null ? WeatherLoaded(forecast) : WeatherInitial();
    } catch (_) {
      return WeatherInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    if (state is WeatherLoaded) {
      return {'forecast': state.forecast.toJson()};
    }
    return null;
  }
}