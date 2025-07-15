import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = "Khulna";
  String time = "7:13 PM";
  String day = "Monday";
  String date = "30.12.2025";
  double temp = 14;
  String weatherType = "mist";
  String max = "15° C";
  String min = "11° C";
  String wind = "7m/s";
  String humidity = "57%";
  String image = "assets/images/cloudy.png";

  @override
  void initState() {
    fetchWeather();

    super.initState();
  }

  Future<void> fetchWeather() async {
    try {
      var url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=4ab407921a464ceea3954201251107&q=Dhaka&days=1&aqi=no&alerts=no',
      );
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Logger().e("You data sucessful");
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          city = data["location"]["name"];
          String localtime = data["location"]["localtime"];
          List<String> parts = localtime.split(' ');
          date = parts[0];
          time = parts[1];
          temp = data["current"]["temp_c"];
          wind = "${(20.2 / 3.6).toStringAsFixed(1)} m/s"; // ~5.6 m/s

          humidity = "${data["current"]["humidity"]}%";

          max = "${data["forecast"]["forecastday"][0]["day"]["maxtemp_c"]}° C";
          min = "${data["forecast"]["forecastday"][0]["day"]["mintemp_c"]}° C";

          weatherType = data["current"]["condition"]["text"];
          image = "https:${data["current"]["condition"]["icon"]}";
        });

        Logger().e("Responce done  ${data["location"]}");
        Logger().e("${city}");
      } else {
        Logger().e("Something went wrong");
      }
    } catch (e) {
      Logger().e("Something went wrong: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "$city",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "      $time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\n \n $day $date"),
                ],
              ),
            ),
            Image.network("$image"),
            Text("$weatherType"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$temp° c",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: const Color.fromARGB(255, 27, 72, 94),
                  elevation: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Max: $max ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Min: $min ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Wind: $wind",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Humidity: $humidity",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
