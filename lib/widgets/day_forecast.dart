import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DayForecastCard extends StatelessWidget {
  final DateTime date;
  final List<WeatherDay> forecasts;
  final int index;

  const DayForecastCard({Key? key, required this.date, required this.forecasts, required this.index}) : super(key: key);

  IconData _getWeatherIcon(String description) {
    description = description.toLowerCase();
    if (description.contains('clear')) return WeatherIcons.day_sunny;
    if (description.contains('cloud')) return WeatherIcons.cloudy;
    if (description.contains('rain')) return WeatherIcons.rain;
    if (description.contains('snow')) return WeatherIcons.snow;
    if (description.contains('thunder')) return WeatherIcons.thunderstorm;
    return WeatherIcons.day_sunny;
  }

  @override
  Widget build(BuildContext context) {
    final day = forecasts.first;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.8),
      child: ExpansionTile(
        title: Text(
          DateFormat('EEEE, MMM d').format(day.date),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${forecasts.length} forecasts',
          style: TextStyle(fontSize: 14),
        ),
        leading: Icon(
          _getWeatherIcon(day.description),
          size: 32,
          color: Colors.blue[700],
        ),
        trailing: Text(
          '${day.temperature.round()}°C',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        children: forecasts.map((forecast) => _buildHourlyForecast(forecast)).toList(),
      ),
    );
        // .animate()
        // .fade(duration: 500.ms, delay: (100 * index).ms)
        // .slide(begin: Offset(1, 0), end: Offset.zero, duration: 500.ms, delay: (100 * index).ms, curve: Curves.easeOutQuad);
  }

  Widget _buildHourlyForecast(WeatherDay forecast) {
    return ListTile(
      title: Text(DateFormat('HH:mm').format(forecast.date)),
      subtitle: Text(forecast.description),
      trailing: Text('${forecast.temperature.round()}°C'),
      leading: Icon(_getWeatherIcon(forecast.description), size: 24, color: Colors.blue[700]),
    );
  }
}