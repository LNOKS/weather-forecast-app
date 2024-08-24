import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:weather_test_task/widgets/weather_card.dart';

void main() {
  testWidgets('WeatherCard displays correct information for various weather conditions', (WidgetTester tester) async {
    final testCases = [
      {
        'description': 'Clear sky',
        'temperature': 25.3,
        'expectedIcon': WeatherIcons.day_sunny,
      },
      {
        'description': 'Cloudy',
        'temperature': 20.0,
        'expectedIcon': WeatherIcons.cloudy,
      },
      {
        'description': 'Light rain',
        'temperature': 18.5,
        'expectedIcon': WeatherIcons.rain,
      },
      {
        'description': 'Snow',
        'temperature': -2.0,
        'expectedIcon': WeatherIcons.snow,
      },
      {
        'description': 'Thunderstorm',
        'temperature': 15.0,
        'expectedIcon': WeatherIcons.thunderstorm,
      },
      {
        'description': 'Foggy',
        'temperature': 10.0,
        'expectedIcon': WeatherIcons.day_sunny,
      },
      {
        'description': 'Clear sky',
        'temperature': -5.5,
        'expectedIcon': WeatherIcons.day_sunny,
      },
    ];

    for (var testCase in testCases) {
      final testDay = WeatherDay(
        (b) => b
          ..date = DateTime.now()
          ..temperature = testCase['temperature'] as double
          ..description = testCase['description'] as String,
      );
      final index = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherCard(day: testDay, index: index),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final formattedDate = DateFormat('EEEE, MMM d').format(testDay.date);
      expect(find.text(formattedDate), findsOneWidget);

      expect(find.text(testDay.description), findsOneWidget);

      final roundedTemp = '${testDay.temperature.round()}°C';
      expect(find.text(roundedTemp), findsOneWidget);

      expect(find.byIcon(testCase['expectedIcon'] as IconData), findsOneWidget);
    }
  });
}
