part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FeathWeather extends WeatherEvent {
  final Position position;

  const FeathWeather(this.position);

  @override
  List<Object> get props => [position];
}
