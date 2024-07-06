*** Weather App ***
This Flutter application allows users to check the current weather conditions of any city using data from the OpenWeatherMap API.

Features-
Home Page: Enter a city name to fetch and display current weather information.
Weather Screen: Detailed view showing temperature, weather condition, humidity, wind speed, and a corresponding weather icon.
Persistent City: Remembers the last searched city using SharedPreferences for convenience.
API Integration: Utilizes HTTP requests to fetch weather data from the OpenWeatherMap API.

Screenshots-
![home_page](https://github.com/yashbansal200005/weather_app/assets/174886554/b4ac871f-1dd5-4068-bb65-3b20a8edb3d1

Getting Started-
To run this application:
1.Clone this repository.
2.Open the project in your preferred Flutter IDE (e.g., VS Code, Android Studio).
3.Run the app on an emulator or physical device.

Dependencies-
http: For making HTTP requests to fetch weather data.
shared_preferences: For storing the last searched city locally.
Other Flutter dependencies as specified in pubspec.yaml.

How to Use-

Home Page:
Enter the name of the city you want to check the weather for.
Press the search button or hit Enter to fetch weather data.
The app will display the current temperature, weather condition, and other details.

Weather Screen:
Upon searching for a city, the app navigates to the Weather Screen.
Detailed weather information is displayed, including temperature in Celsius, humidity percentage, wind speed in km/h, and an icon representing the weather condition.

Persistent City:
The app remembers the last searched city even after closing and reopening the app.
