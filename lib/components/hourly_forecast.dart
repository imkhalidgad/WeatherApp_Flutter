import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/constants.dart';

class HourlyForecast extends StatelessWidget {
  final dynamic hourlyWeatherForecast;
  final bool isCelsius;
  final bool isDarkMode;
  final _constants = Constants();

  HourlyForecast({
    super.key,
    this.hourlyWeatherForecast,
    required this.isCelsius,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    String currentHour = currentTime.substring(0, 2);

    String forecastTime = hourlyWeatherForecast["time"].substring(11, 16);
    String forecastHour = hourlyWeatherForecast["time"].substring(11, 13);

    String forecastWeatherName = hourlyWeatherForecast["condition"]["text"];
    String forecastWeatherIcon =
        "${forecastWeatherName.replaceAll(" ", "").toLowerCase()}.png";

    String forecastTemperatureC =
        hourlyWeatherForecast["temp_c"].round().toString();

    String forecastTemperatureF =
        hourlyWeatherForecast["temp_f"].round().toString();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.only(right: 20),
      width: 65,
      decoration: BoxDecoration(
        color: currentHour == forecastHour
            ? Colors.white
            : isDarkMode
                ? _constants.primaryColorDarkMode
                : _constants.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: _constants.primaryColor.withOpacity(.2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            forecastTime,
            style: TextStyle(
              fontSize: 17,
              color: _constants.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            'assets/$forecastWeatherIcon',
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isCelsius ? forecastTemperatureC : forecastTemperatureF,
                style: TextStyle(
                  color: _constants.greyColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'o',
                style: TextStyle(
                  color: _constants.greyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
