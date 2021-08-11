class Weather {
  final String city;
  final int temperature;
  final String iconCode;
  final String description;
  final String humidity;
  final double wind;

  Weather(
      {this.city,
      this.temperature,
      this.iconCode,
      this.description,
      this.humidity,
      this.wind});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        city: json['name'],
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        iconCode: json['weather'][0]['icon'],
        description: json['weather'][0]['main'],
        humidity: json['humidity'],
        wind: json['wind'][0]['speed']);
  }
}
