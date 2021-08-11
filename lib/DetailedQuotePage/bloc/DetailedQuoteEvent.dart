import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent([List props = const []]);
}

class WeatherRequested extends WeatherEvent {
  final String city;

  const WeatherRequested({this.city = ""})
      : super();

  @override
  List<Object> get props => [city];
}