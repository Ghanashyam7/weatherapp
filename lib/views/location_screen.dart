import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/weather_controller.dart';
import 'package:weatherapp/models/weather_models.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/weather_status.dart';

class LocationScreen extends StatelessWidget {
  final controller = Get.put(WeatherController());
  final weatherStatus = Get.put(WeatherStatus());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
          future: controller.getWeatherData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.toString()}"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              var weatherIcon = weatherStatus.getWeatherIcon(data!.cod);

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(''),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
                  ),
                ),
                constraints: BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              controller.getWeatherData();
                            },
                            child: const Icon(
                              Icons.near_me,
                              size: 50.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${data.main.temp.toInt().toString()}??",
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherStatus.getWeatherIcon(data.cod),
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          "${weatherStatus.getMessage(data.main.temp.toInt())} in ${data.name}!",
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: SpinKitDoubleBounce(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          }),
    );
  }
}
