import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //used for search box{
  TextEditingController SearchController = new TextEditingController();
  //}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is home");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("disposing");
  }

  @override
  Widget build(BuildContext context) {
// assign values from worker via loading to home{
    final Map? info = ModalRoute.of(context)?.settings.arguments as Map?;
    String icon = info?['icon_value'] ?? 'default'; //icon
    String weather_dec = info?['weather_value'] ?? 'default'; //weather info
    String city = info?['city_value'] ?? 'default'; //city name
    String temp =
        ((info?['temp_value'].toString())!) ?? 'default'; //tempreature
    String wind_speed =
        ((info?['air_speed'].toString())!) ?? 'default'; //tempreature
    if (temp == "NA") {
      print("NA");
    } else {
      temp = temp.substring(0, 4);
      wind_speed = wind_speed.substring(0, 3);
      //wind speed
    }
    String humidity = info?['hum_value'] ?? 'default'; //humidity
    // };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.black,
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => {
                        if ((SearchController.text).replaceAll(" ", "") == "")
                          {
                            print("blank search"),
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "search_value": SearchController.text,
                                })
                          }
                      },
                      child: Container(
                        child: Icon(Icons.search),
                        margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      controller: SearchController,
                      decoration: InputDecoration(
                        hintText: "search any city name",
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Image.network(
                              "https://openweathermap.org/img/wn/$icon@2x.png"),
                          Column(
                            children: [
                              Text(
                                "$weather_dec",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                "$city",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 230,
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(35)),
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        padding:
                             EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 100),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 35),
                                  child: const Icon(
                                    WeatherIcons.celsius,
                                    size: 40,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(35)),
                      margin: EdgeInsets.fromLTRB(15, 15, 8, 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            WeatherIcons.day_cloudy_windy,
                            size: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$wind_speed",
                                style: TextStyle(fontSize: 45),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "km/hr",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(35)),
                      margin: EdgeInsets.fromLTRB(8, 15, 15, 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            WeatherIcons.humidity,
                            size: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$humidity",
                                style: TextStyle(fontSize: 50),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "%",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: const Column(
                    children: [
                      Text(
                        "Made by Phckoff",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("Thanks to OPENWEATHER",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
