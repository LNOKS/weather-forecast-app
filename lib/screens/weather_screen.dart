import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_task/bloc/weather_bloc.dart';
import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:weather_test_task/widgets/animated_background.dart';
import 'package:weather_test_task/widgets/weather_card.dart';
import 'package:built_collection/built_collection.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    _getLocationAndFetchWeather();
  }

  Map<DateTime, List<WeatherDay>> _groupForecastByDate(BuiltList<WeatherDay> days) {
    return days.fold<Map<DateTime, List<WeatherDay>>>({}, (map, day) {
      final date = DateTime(day.date.year, day.date.month, day.date.day);
      if (!map.containsKey(date)) {
        map[date] = [];
      }
      map[date]!.add(day);
      return map;
    });
  }


  Future<void> _getLocationAndFetchWeather() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestedPermission = await Geolocator.requestPermission();
      if (requestedPermission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
      );
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      context.read<WeatherBloc>().add(FetchWeather(position.latitude, position.longitude));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator(color: Colors.white));
              } else if (state is WeatherLoaded) {
                final groupedData = _groupForecastByDate(state.forecast.days);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Weather Forecast',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ).animate().fade(duration: 500.ms).slide(begin: Offset(0, -1), end: Offset.zero, duration: 500.ms, curve: Curves.easeOutQuad),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: groupedData.keys.length,
                        itemBuilder: (context, index) {
                          final date = groupedData.keys.elementAt(index);
                          final weatherDays = groupedData[date]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  DateFormat('EEEE, MMM d').format(date),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              Column(
                                children: weatherDays.map((day) => WeatherCard(day: day, index: index)).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is WeatherError) {
                return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
              }
              return Center(child: Text('Press the button to load weather', style: TextStyle(color: Colors.white)));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocationAndFetchWeather,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blueAccent,
      ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
    );
  }
}