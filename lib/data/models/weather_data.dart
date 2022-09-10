// ignore_for_file: prefer_typing_uninitialized_variables

class WeatherData {
  final location;
  final current;

  const WeatherData({this.current, required this.location});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: json['location'],
      current: json['current'],
    );
  }
}