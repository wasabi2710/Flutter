import 'dart:developer';
import 'package:weather_app/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MainScreen(),
    );
  }
}

//image class
class ImageProvider {
  String? path;

  ImageProvider({this.path});
}

//loading screen
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: const Icon(
          Icons.cloud_circle,
          color: Colors.white,
        ),
      ),
      //body
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.cyan,
          size: 70,
        ),
      ),
    );
  }
}

//mainscreen
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //check time
  var now = DateTime.now();

  //change background
  changeBackground() {
    if (now.hour >= 15) {
      return const AssetImage('night.png');
    } else {
      return const AssetImage('sunny.png');
    }
  }

  //get weather object
  late Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    //fetch weather
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: const Icon(
          Icons.cloud_circle,
          color: Colors.white,
        ),
      ),
      //body
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: changeBackground(),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Weather>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${snapshot.data!.currentTemp}°',
                    style: TextStyle(color: Colors.cyan, fontSize: 50),
                  ),
                  Text(
                    '${snapshot.data!.city}',
                    style: TextStyle(color: Colors.cyan, fontSize: 50),
                  ),
                ],
              );
            }

            return const SpinKitRotatingCircle(
              color: Colors.cyan,
              size: 80,
            );
          },
        ),
      ),
    );
  }
}
