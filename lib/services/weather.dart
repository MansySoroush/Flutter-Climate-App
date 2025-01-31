import 'location.dart';
import 'networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final owmApiKey = dotenv.env['OWM_API_KEY'];
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      print('APIKey: $owmApiKey');

      NetworkHelper networkHelper = NetworkHelper(
          uri: '$openWeatherMapURL?q=$cityName&appid=$owmApiKey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();

      print(location.latitude);
      print(location.longitude);

      NetworkHelper networkHelper = NetworkHelper(
          uri:
              '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$owmApiKey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
