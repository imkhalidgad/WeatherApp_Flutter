import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather/constants.dart';

class HomeController extends GetxController {
  static var constants = Constants().obs;
  var location = ''.obs;
  var weatherIcon = ''.obs;
  var temperatureC = 0.obs;
  var temperatureF = 0.obs;
  var windSpeed = 0.obs;
  var humidity = 0.obs;
  var cloud = 0.obs;
  var currentDate = ''.obs;
  var currentWeatherStatus = ''.obs;
  var hourlyWeatherForecast = [].obs;
  var dailyWeatherForecast = [].obs;
  var isLoading = true.obs;
  var isDarkMode = false.obs;
  var isCelsius = true.obs;

  static String apiKey = constants.value.apiKey;
  String searchWeatherApi =
      "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=";

  // Method to get current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best));
  }

  // Method to get city name and fetch weather data
  Future<void> getCityName() async {
    try {
      Position position = await _getCurrentLocation();
      location.value = "${position.latitude},${position.longitude}";
      await fetchWeatherData(location.value);
    } catch (e) {}
  }

  // Method to fetch weather data
  Future<void> fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherApi + searchText));

      if (searchResult.statusCode == 200) {
        final weatherData =
            Map<String, dynamic>.from(jsonDecode(searchResult.body) ?? {});
        var locationData = weatherData["location"];
        var currentWeather = weatherData["current"];

        location.value = getShortLocationName(locationData["name"]);
        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate.value = newDate;

        currentWeatherStatus.value = currentWeather["condition"]["text"];
        weatherIcon.value =
            "${currentWeatherStatus.value.replaceAll(' ', '').toLowerCase()}.png";
        temperatureC.value = currentWeather["temp_c"].toInt();
        temperatureF.value = currentWeather["temp_f"].toInt();
        windSpeed.value = currentWeather["wind_kph"].toInt();
        humidity.value = currentWeather["humidity"].toInt();
        cloud.value = currentWeather["cloud"].toInt();

        dailyWeatherForecast.value = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast.value = dailyWeatherForecast[0]["hour"];

        isLoading.value = false;
      }
    } catch (e) {}
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");
    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return "${wordList[0]} ${wordList[1]}";
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }
}
