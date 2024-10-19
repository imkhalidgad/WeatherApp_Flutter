import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather/components/hourly_forecast.dart';
import 'package:weather/components/weather_item.dart';
import 'package:weather/ui/details_screen.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    controller.getCityName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        color: !controller.isDarkMode.value
            ? HomeController.constants.value.primaryColor.withOpacity(.1)
            : HomeController.constants.value.blackColor,
        child: Obx(
          () {
            return controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: HomeController.constants.value.primaryColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        height: size.height * .7,
                        decoration: BoxDecoration(
                          gradient: controller.isDarkMode.value
                              ? HomeController
                                  .constants.value.linearGradientBlueDarkMode
                              : HomeController
                                  .constants.value.linearGradientBlue,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: HomeController.constants.value.primaryColor
                          //         .withOpacity(.5),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: const Offset(0, 3),
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.isCelsius.value =
                                          !controller.isCelsius.value;
                                    });
                                  },
                                  icon: Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.thermometer,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        controller.isCelsius.value ? "C" : "F",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/pin.png",
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      controller.location.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _cityController.clear();
                                        showMaterialModalBottomSheet(
                                          backgroundColor:
                                              controller.isDarkMode.value
                                                  ? HomeController.constants
                                                      .value.blackColor
                                                  : Colors.white,
                                          context: context,
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            controller:
                                                ModalScrollController.of(
                                                    context),
                                            child: Container(
                                              height: size.height * .45,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 70,
                                                    child: Divider(
                                                      thickness: 3.5,
                                                      color: HomeController
                                                          .constants
                                                          .value
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        controller
                                                            .fetchWeatherData(
                                                                searchText);
                                                      });
                                                    },
                                                    controller: _cityController,
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        color: HomeController
                                                            .constants
                                                            .value
                                                            .primaryColor,
                                                      ),
                                                      suffixIcon:
                                                          GestureDetector(
                                                        onTap: () =>
                                                            _cityController
                                                                .clear(),
                                                        child: Icon(
                                                          Icons.close,
                                                          color: HomeController
                                                              .constants
                                                              .value
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          color: controller
                                                                  .isDarkMode
                                                                  .value
                                                              ? Colors.white
                                                              : Colors.black),
                                                      hintText:
                                                          "Search City e.g. Cairo",
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: HomeController
                                                              .constants
                                                              .value
                                                              .primaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.isDarkMode.value =
                                          !controller.isDarkMode.value;
                                    });
                                  },
                                  icon: controller.isDarkMode.value
                                      ? const Icon(
                                          CupertinoIcons.sun_max_fill,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          CupertinoIcons.moon_fill,
                                          color: Colors.white,
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 160,
                              child: Image.asset(
                                  "assets/${controller.weatherIcon.value}"),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.isCelsius.value
                                        ? controller.temperatureC.toString()
                                        : controller.temperatureF.toString(),
                                    style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = HomeController
                                            .constants.value.shader,
                                    ),
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader =
                                          HomeController.constants.value.shader,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              controller.currentWeatherStatus.value,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              controller.currentDate.value,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Divider(
                                color: Colors.white70,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value: controller.windSpeed.value.toInt(),
                                    unit: ' km/h',
                                    imageUrl: 'assets/windspeed.png',
                                  ),
                                  WeatherItem(
                                    value: controller.humidity.value.toInt(),
                                    unit: '%',
                                    imageUrl: 'assets/humidity.png',
                                  ),
                                  WeatherItem(
                                    value: controller.cloud.value.toInt(),
                                    unit: '%',
                                    imageUrl: 'assets/cloud.png',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: controller.isDarkMode.value
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailPage(
                                        dailyForecastWeather:
                                            controller.dailyWeatherForecast,
                                        isCelsius: controller.isCelsius.value,
                                        isDarkMode: controller.isDarkMode.value,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Forecasts",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: HomeController
                                          .constants.value.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                itemCount:
                                    controller.hourlyWeatherForecast.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return HourlyForecast(
                                    hourlyWeatherForecast:
                                        controller.hourlyWeatherForecast[index],
                                    isCelsius: controller.isCelsius.value,
                                    isDarkMode: controller.isDarkMode.value,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
