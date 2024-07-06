import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';

class Repo {
  Future<WeatherModel?> getWeather(String? city) async {
    var url = "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=cc175c0e36eee33d98f100b64b258445";
    final res = await http.get(Uri.parse(url));
    var resBody = res.body;
    try {
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(resBody));
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
