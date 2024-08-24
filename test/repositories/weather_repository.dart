import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:weather_test_task/repositories/weather_repository.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late WeatherRepository weatherRepository;

  setUp(() {
    mockDio = MockDio();
    weatherRepository = WeatherRepository(dio: mockDio);
  });

  group('getWeatherForecast', () {
    const lat = 12.34;
    const lon = 56.78;
    final testResponseData = {
      'list': [
        {
          'dt': 1641013200,
          'main': {'temp': 20.5},
          'weather': [
            {'description': 'Clear sky'}
          ]
        },
        {
          'dt': 1641099600,
          'main': {'temp': 22.3},
          'weather': [
            {'description': 'Partly cloudy'}
          ]
        },
      ]
    };

    test('returns WeatherForecast when the API call is successful', () async {
      // Arrange
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: testResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final forecast = await weatherRepository.getWeatherForecast(lat, lon);

      // Assert
      expect(forecast.days.length, 2);
      expect(forecast.days.first.temperature, 20.5);
      expect(forecast.days.first.description, 'Clear sky');
      expect(forecast.days[1].temperature, 22.3);
      expect(forecast.days[1].description, 'Partly cloudy');
    });

    test('throws an exception when the API call fails', () async {
      // Arrange
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioError(
        requestOptions: RequestOptions(path: ''),
        response: Response(statusCode: 404, requestOptions: RequestOptions(path: '')),
        type: DioErrorType.response,
      ));

      // Act & Assert
      expect(
            () => weatherRepository.getWeatherForecast(lat, lon),
        throwsA(isA<Exception>()),
      );
    });

    test('throws an exception when the API returns invalid data', () async {
      // Arrange
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {'list': 'invalid_data'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act & Assert
      expect(
            () => weatherRepository.getWeatherForecast(lat, lon),
        throwsA(isA<TypeError>()), // or any other expected error type
      );
    });
  });
}
