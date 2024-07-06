import 'package:flutter/material.dart';
import 'package:weather_app/repo.dart';
import 'package:weather_app/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  WeatherModel? weatherModel;
  String? lastSearchedCity;

  @override
  void initState() {
    super.initState();
    _loadLastSearchedCity();
  }

  Future<void> _loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lastSearchedCity = prefs.getString('lastSearchedCity');
    });
    if (lastSearchedCity != null) {
      _fetchWeather(lastSearchedCity!);
    }
  }

  Future<void> _saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
    setState(() {
      lastSearchedCity = city;
    });
  }

  Future<void> _fetchWeather(String city) async {
    WeatherModel? model = await Repo().getWeather(city);
    setState(() {
      weatherModel = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.lightBlue[400],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/weather.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: "Enter city name...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              color: Colors.blue,
                              onPressed: () async {
                                if (controller.text.isNotEmpty &&
                                    controller.text != lastSearchedCity) {
                                  await _saveLastSearchedCity(controller.text);
                                  await _fetchWeather(controller.text);
                                  if (weatherModel != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WeatherScreen(weatherModel: weatherModel!),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60,),
                      if (weatherModel != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                "Weather in ${weatherModel!.name}",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${(weatherModel!.main!.temp! - 273.15).toStringAsFixed(1)} °C",
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  Column(
                                    children: [
                                      Text(
                                        "${weatherModel!.weather![0].main}",
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "Humidity: ${weatherModel!.main!.humidity}%",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
