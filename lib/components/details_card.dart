import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class DetailsCard extends StatelessWidget {
  final dynamic getForecastWeather;
  final bool isCelsius;
  final bool isDarkMode;
  final _constants = Constants();

  DetailsCard(
      {super.key,
      required this.getForecastWeather,
      required this.isCelsius,
      required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkMode ? Colors.black : Colors.white,
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getForecastWeather["forecastDate"],
                  style: const TextStyle(
                    color: Color(0xff6696f5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCelsius
                              ? getForecastWeather["minTemperatureC"].toString()
                              : getForecastWeather["minTemperatureF"]
                                  .toString(),
                          style: TextStyle(
                            color: _constants.greyColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            color: _constants.greyColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCelsius
                              ? getForecastWeather["maxTemperatureC"].toString()
                              : getForecastWeather["maxTemperatureF"]
                                  .toString(),
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : _constants.blackColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : _constants.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/${getForecastWeather["weatherIcon"]}",
                      width: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      getForecastWeather["weatherName"],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${getForecastWeather["chanceOfRain"]}%",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "assets/lightrain.png",
                      width: 30,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
