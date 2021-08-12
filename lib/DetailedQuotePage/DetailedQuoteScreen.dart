import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthBloc.dart';
import 'package:test_task/AuthorizationPage/bloc/auth/AuthEvent.dart';
import 'package:test_task/DetailedQuotePage/bloc/DetailedQuoteBloc.dart';
import 'package:test_task/DetailedQuotePage/bloc/DetailedQuoteEvent.dart';
import 'package:test_task/DetailedQuotePage/bloc/DetailedQuoteState.dart';
import 'package:test_task/DetailedQuotePage/models/Weather.dart';
import 'package:test_task/resources/Constants.dart';
import 'package:test_task/resources/UserSession.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedQuotePage extends StatelessWidget {
  final String city;
  WeatherBloc weatherBloc;

  DetailedQuotePage({this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  saveLogout();
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(UserLoggedOut());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        'Выйти',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Icon(
                      Icons.exit_to_app,
                      color: Color(0xFF000000),
                    ),
                  ],
                ),
              )),
        ],
      ),
      body: BlocProvider(
        create: (context) => WeatherBloc(city),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              weatherBloc = BlocProvider.of<WeatherBloc>(context);
              weatherBloc.add(WeatherRequested(city: city));
              return buildLoading(context);
            } else if (state is WeatherLoadInProgress) {
              return buildLoading(context);
            } else if (state is WeatherLoadSuccess) {
              return buildWeather(state.weather, context);
            } else {
              return buildLoading(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorMain),
          ),
        ),
        backButton(context),
      ],
    );
  }

  Widget buildWeather(Weather weather, BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 33, top: 57),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: Image.network(
                        "http://openweathermap.org/img/wn/${weather
                            .iconCode}@2x.png",
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                    ),
                    Container(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(
                            indent: 27,
                            endIndent: 27,
                            thickness: 1,
                            color: Color(0xFFE0E0E0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34),
                            child: Text(
                              weather.city,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34),
                            child: Text(
                              weather.description,
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34),
                            child: Text(
                              'Temperature: ' + weather.temperature.toString() +
                                  '° C',
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34),
                            child: Text(
                              'Humidity: ' + weather.humidity.toString() + '%',
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34),
                            child: Text(
                              'Wind: ' + weather.wind.toString() + ' m/s',
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34),
                            child: GestureDetector(
                              child: Text(
                                'Weather',
                                style: TextStyle(
                                    color: Color(0xFF08299B),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.normal),
                              ),
                              onTap: () => launch("https://openweathermap.org"),
                            ),
                          ),
                          Divider(
                            indent: 27,
                            endIndent: 27,
                            thickness: 1,
                            color: Color(0xFFE0E0E0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 83, right: 83),
                      height: 42,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: RaisedButton(
                        color: Color(0xFF242424),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Назад",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 21,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return Positioned(
      bottom: 33,
      left: 83,
      right: 83,
      child: Container(
        height: 42,
        child: RaisedButton(
          color: Color(0xFF242424),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Назад",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 21,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
