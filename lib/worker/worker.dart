import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart";
import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';

class worker {
  String location;
  // constructor
  worker({required this.location}) {
    location = this.location;
  }
  late String weather, temperature, humidity, air_speed, city, icon;
  // make a method to extract these info;
  Future<void> getData() async {
    // String key = dotenv.get("API_KEY", fallback: "");

    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid= App api key "));
      /// please add api key


      Map data = jsonDecode(response.body);
      List weatherData = data['weather'];
      Map wet_data = weatherData[0];
      Map tempData = data['main'];

      double temp = tempData['temp'] - 273.15; //gives temperature data in c;
      String humi_Data =
          tempData['humidity'].toString(); // gives humidity data in %;
      Map airData = data['wind'];
      double air_Data =
          airData['speed'] / 0.27777777; //gives air data in km/hr;

      weather = wet_data['main']; //gives weather data;
      icon = wet_data['icon'].toString();
      city = data['name']; //gives description;
      temperature = temp.toString();
      humidity = humi_Data.toString();
      air_speed = air_Data.toString();
    } catch (e) {
      icon = "NA";
      weather = "NA";
      city = "NA";
      temperature = "NA";
      humidity = "NA";
      air_speed = "NA";
    }
  }
}
