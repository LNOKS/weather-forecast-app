import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final WeatherDay day;
  final int index;

  const WeatherCard({Key? key, required this.day, required this.index}) : super(key: key);

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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMM d').format(day.date),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  day.description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  _getWeatherIcon(day.description),
                  size: 32,
                  color: Colors.blue[700],
                ),
                SizedBox(width: 8),
                Text(
                  '${day.temperature.round()}°C',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
        // .animate()
        // .fade(duration: 500.ms, delay: (10 * index).ms)
        // .slide(begin: Offset(1, 0), end: Offset.zero, duration: 500.ms, delay: (10 * index).ms, curve: Curves.easeOutQuad);
  }
}