import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test_task/bloc/weather_bloc.dart';

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
      appBar: AppBar(title: Text('Weather Forecast')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return ListView.builder(
              itemCount: state.forecast.days.length,
              itemBuilder: (context, index) {
                final day = state.forecast.days[index];
                return ListTile(
                  title: Text(day.date.toString()),
                  subtitle: Text(day.description),
                  trailing: Text('${day.temperature}°C'),
                );
              },
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press the button to load weather'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocationAndFetchWeather,
        child: Icon(Icons.refresh),
      ),
    );
  }
}