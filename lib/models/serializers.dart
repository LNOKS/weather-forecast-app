import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:weather_test_task/models/weather_forecast.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is String) {
      return DateTime.parse(serialized);
    } else {
      throw ArgumentError('DateTimeSerializer can only deserialize strings');
    }
  }

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType = FullType.unspecified}) {
    return dateTime.toIso8601String();
  }

  @override
  Iterable<Type> get types => [DateTime];

  @override
  String get wireName => 'DateTime';
}

@SerializersFor([
  WeatherForecast,
  WeatherDay,
])
final Serializers serializers = (_$serializers.toBuilder()
  ..addPlugin(StandardJsonPlugin())
  ..add(DateTimeSerializer()))
    .build();