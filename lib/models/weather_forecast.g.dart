// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WeatherForecast> _$weatherForecastSerializer =
    new _$WeatherForecastSerializer();
Serializer<WeatherDay> _$weatherDaySerializer = new _$WeatherDaySerializer();

class _$WeatherForecastSerializer
    implements StructuredSerializer<WeatherForecast> {
  @override
  final Iterable<Type> types = const [WeatherForecast, _$WeatherForecast];
  @override
  final String wireName = 'WeatherForecast';

  @override
  Iterable<Object?> serialize(Serializers serializers, WeatherForecast object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'days',
      serializers.serialize(object.days,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WeatherDay)])),
    ];

    return result;
  }

  @override
  WeatherForecast deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WeatherForecastBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'days':
          result.days.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WeatherDay)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$WeatherDaySerializer implements StructuredSerializer<WeatherDay> {
  @override
  final Iterable<Type> types = const [WeatherDay, _$WeatherDay];
  @override
  final String wireName = 'WeatherDay';

  @override
  Iterable<Object?> serialize(Serializers serializers, WeatherDay object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
      'temperature',
      serializers.serialize(object.temperature,
          specifiedType: const FullType(double)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WeatherDay deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WeatherDayBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'temperature':
          result.temperature = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WeatherForecast extends WeatherForecast {
  @override
  final BuiltList<WeatherDay> days;

  factory _$WeatherForecast([void Function(WeatherForecastBuilder)? updates]) =>
      (new WeatherForecastBuilder()..update(updates))._build();

  _$WeatherForecast._({required this.days}) : super._() {
    BuiltValueNullFieldError.checkNotNull(days, r'WeatherForecast', 'days');
  }

  @override
  WeatherForecast rebuild(void Function(WeatherForecastBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastBuilder toBuilder() =>
      new WeatherForecastBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecast && days == other.days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecast')..add('days', days))
        .toString();
  }
}

class WeatherForecastBuilder
    implements Builder<WeatherForecast, WeatherForecastBuilder> {
  _$WeatherForecast? _$v;

  ListBuilder<WeatherDay>? _days;
  ListBuilder<WeatherDay> get days =>
      _$this._days ??= new ListBuilder<WeatherDay>();
  set days(ListBuilder<WeatherDay>? days) => _$this._days = days;

  WeatherForecastBuilder();

  WeatherForecastBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _days = $v.days.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecast other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WeatherForecast;
  }

  @override
  void update(void Function(WeatherForecastBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecast build() => _build();

  _$WeatherForecast _build() {
    _$WeatherForecast _$result;
    try {
      _$result = _$v ?? new _$WeatherForecast._(days: days.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'days';
        days.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WeatherForecast', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WeatherDay extends WeatherDay {
  @override
  final DateTime date;
  @override
  final double temperature;
  @override
  final String description;

  factory _$WeatherDay([void Function(WeatherDayBuilder)? updates]) =>
      (new WeatherDayBuilder()..update(updates))._build();

  _$WeatherDay._(
      {required this.date,
      required this.temperature,
      required this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(date, r'WeatherDay', 'date');
    BuiltValueNullFieldError.checkNotNull(
        temperature, r'WeatherDay', 'temperature');
    BuiltValueNullFieldError.checkNotNull(
        description, r'WeatherDay', 'description');
  }

  @override
  WeatherDay rebuild(void Function(WeatherDayBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherDayBuilder toBuilder() => new WeatherDayBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherDay &&
        date == other.date &&
        temperature == other.temperature &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, temperature.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherDay')
          ..add('date', date)
          ..add('temperature', temperature)
          ..add('description', description))
        .toString();
  }
}

class WeatherDayBuilder implements Builder<WeatherDay, WeatherDayBuilder> {
  _$WeatherDay? _$v;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  double? _temperature;
  double? get temperature => _$this._temperature;
  set temperature(double? temperature) => _$this._temperature = temperature;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WeatherDayBuilder();

  WeatherDayBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _temperature = $v.temperature;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherDay other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WeatherDay;
  }

  @override
  void update(void Function(WeatherDayBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherDay build() => _build();

  _$WeatherDay _build() {
    final _$result = _$v ??
        new _$WeatherDay._(
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'WeatherDay', 'date'),
            temperature: BuiltValueNullFieldError.checkNotNull(
                temperature, r'WeatherDay', 'temperature'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'WeatherDay', 'description'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
