import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/components/details_card.dart';
import 'package:weather/components/weather_item.dart';
import 'package:weather/constants.dart';

class DetailPage extends StatefulWidget {
  final dynamic dailyForecastWeather;
  final bool isCelsius;
  final bool isDarkMode;

  const DetailPage({
    super.key,
    this.dailyForecastWeather,
    required this.isCelsius,
    required this.isDarkMode,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    Map<String, dynamic> getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          "${weatherName.replaceAll(' ', '').toLowerCase()}.png";

      int minTemperatureC = weatherData[index]["day"]["mintemp_c"].toInt();
      int minTemperatureF = weatherData[index]["day"]["mintemp_f"].toInt();
      int maxTemperatureC = weatherData[index]["day"]["maxtemp_c"].toInt();
      int maxTemperatureF = weatherData[index]["day"]["maxtemp_f"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperatureC': minTemperatureC,
        'minTemperatureF': minTemperatureF,
        'maxTemperatureC': maxTemperatureC,
        'maxTemperatureF': maxTemperatureF,
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? Colors.black
          : _constants.primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: widget.isDarkMode ? Colors.white : Colors.black),
        title: Text(
          "Forecasts",
          style:
              TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        backgroundColor: widget.isDarkMode
            ? Colors.black
            : _constants.primaryColor,
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: BoxDecoration(
                color: widget.isDarkMode ? _constants.blackColor : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 280,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: widget.isDarkMode
                            ? _constants.linearGradientBlueDarkMode
                            : const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.center,
                                colors: [
                                  Color(0xffa9c1f5),
                                  Color(0xff6696f5),
                                ],
                              ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.blue.withOpacity(.1),
                        //     offset: const Offset(0, 25),
                        //     blurRadius: 3,
                        //     spreadRadius: -10,
                        //   ),
                        // ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            width: 150,
                            child: Image.asset(
                              "assets/${getForecastWeather(0)['weatherIcon']}",
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: " km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.isCelsius
                                          ? getForecastWeather(
                                                  0)["maxTemperatureC"]
                                              .toString()
                                          : getForecastWeather(
                                                  0)["maxTemperatureF"]
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = _constants.shader,
                                      ),
                                    ),
                                    Text(
                                      'o',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = _constants.shader,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 300,
                            left: 0,
                            child: SizedBox(
                              height: 400,
                              width: size.width * 0.9,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: weatherData.length,
                                itemBuilder: (context, index) {
                                  return DetailsCard(
                                    getForecastWeather:
                                        getForecastWeather(index),
                                    isCelsius: widget.isCelsius,
                                    isDarkMode: widget.isDarkMode,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
