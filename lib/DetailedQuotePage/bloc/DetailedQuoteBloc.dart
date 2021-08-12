import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/DetailedQuotePage/models/Weather.dart';
import 'package:test_task/DetailedQuotePage/services/WeatherService.dart';
import 'DetailedQuoteEvent.dart';
import 'DetailedQuoteState.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final String city;

  WeatherBloc(this.city) : super(WeatherInitial()) {
    add(WeatherRequested(city: city));
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();
      try {
        final Weather weather =
            await WeatherService.fetchCurrentWeather(city: event.city);
        yield WeatherLoadSuccess(weather: weather);
      } catch (e) {
        yield WeatherLoadFailure();
      }
    }
  }
}
