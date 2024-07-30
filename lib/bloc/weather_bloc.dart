import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:now_wheather_app/data/my_data.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FeathWeather>((event, emit) async {
      //ローディング
      emit(WeatherLoading());
      try {
        //成功
        WeatherFactory weatherFactory =
            WeatherFactory(API_KEY, language: Language.JAPANESE);

        Weather weather = await weatherFactory.currentWeatherByLocation(
          event.position.latitude, //緯度
          event.position.longitude, //経度
        );
        emit(WeatherSuccess(weather));
      } catch (e) {
        //失敗
        emit(WeatherFailure());
      }
    });
  }
}
