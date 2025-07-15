class WeatherModel{
  final String city;
  final String time;
  final String date;
  final double temp;
  final String weatherType;
  final String max;
  final String min;
  final String wind;
  final String humidity;
  final String iconUrl;

  WeatherModel({
    required this.city,
    required this.time,
    required this.date,
    required this.temp,
    required this.weatherType,
    required this.max,
    required this.min,
    required this.wind,
    required this.humidity,
    required this.iconUrl,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    String localtime = data["location"]["localtime"];
    List<String> parts = localtime.split(' ');
    return WeatherModel(
      city: data["location"]["name"],
      date: parts[0],
      time: parts[1],
      temp: data["current"]["temp_c"],
      weatherType: data["current"]["condition"]["text"],
      iconUrl: "https:${data["current"]["condition"]["icon"]}",
      max: "${data["forecast"]["forecastday"][0]["day"]["maxtemp_c"]}° C",
      min: "${data["forecast"]["forecastday"][0]["day"]["mintemp_c"]}° C",
      wind: "${(20.2 / 3.6).toStringAsFixed(1)} m/s",
      humidity: "${data["current"]["humidity"]}%",
    );
  }
}