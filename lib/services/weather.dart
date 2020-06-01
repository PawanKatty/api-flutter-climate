import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'f84411c81531ec0f2fa86afbda8dfd7a';

class WeatherModel {

  double latitude;
  double longitude;
  var weatherData;

  Future<dynamic> weatherByCity (String cityName) async{
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=f84411c81531ec0f2fa86afbda8dfd7a&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    weatherData = await networkHelper.getWeatherData();
    return weatherData;
  }

  //function to get location
  //'async' make able to do work timeConsuming task in background instead of doing in foreground.
  //more accurate location will be more Battery intensive.
  Future<dynamic> getLocationWeather () async{
    Location location = Location();
    try{
      await location.getCurrentLocation();
      latitude = location.latitude;
      longitude = location.longitude;
      NetworkHelper networkHelper = NetworkHelper(url:'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
      print(latitude);
      print(longitude);
      weatherData = await networkHelper.getWeatherData();
      return weatherData;
    }
    catch(e){
      print(e);
      weatherData =null;
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
