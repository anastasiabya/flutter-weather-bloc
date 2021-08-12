class Weather {
  final String city;
  final int temperature;
  final String iconCode;
  final String description;
  final int humidity;
  final int wind;

  Weather(
      {this.city,
      this.temperature,
      this.iconCode,
      this.description,
      this.humidity,
      this.wind
      });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        city: json['name'],
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        iconCode: json['weather'][0]['icon'],
        description: json['weather'][0]['main'],
        humidity: double.parse(json['main']['humidity'].toString()).toInt(),
        wind: double.parse(json['wind']['speed'].toString()).toInt(),
    );
  }
}
