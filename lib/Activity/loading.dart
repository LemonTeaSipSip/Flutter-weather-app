import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String tempre, hum, ci = "vellore", a_s, we, ico;

  void startApp(String ci) async {
    worker instance = worker(location: ci);
    await instance.getData();

    tempre = instance.temperature;
    hum = instance.humidity;
    // ci = instance.city;
    a_s = instance.air_speed;
    we = instance.weather;
    ico = instance.icon;
    Future.delayed(
        Duration(seconds: 1),
        () => {
              Navigator.pushReplacementNamed(context, '/home', arguments: {
                "icon_value": ico,
                "temp_value": tempre, //in c
                "hum_value": hum, // in %
                "city_value": ci,
                "air_speed": a_s, //in km/hr
                "weather_value": we
              }),
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // statApp();
  }

  @override
  Widget build(BuildContext context) {
    final Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if (search?.isNotEmpty ?? false) {
      ci = search!['search_value'];
    }
    startApp(ci);
    // print(ci)
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 350,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Loading",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
