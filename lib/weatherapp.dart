// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wheather_app/a_i.dart';
import 'package:wheather_app/cards.dart';
import 'package:wheather_app/footer.dart';
import 'package:wheather_app/sc.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Future<Map<String , dynamic>> getWeather() async {
    try {
      String areaName = 'Indore';
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$areaName&appid=$apiKey'));
           
      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw data['message']; // it will return message that occur with that cod
      }
      // return data['list'][0]['main']['temp'];
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wheather App',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                highlightColor: Colors.amber,
                icon: const Icon(Icons.refresh_rounded))
          ],
        ),
        body: FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            // print(snapshot);
            // print(snapshot.runtimeType);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child:  CircularProgressIndicator.adaptive(backgroundColor: Colors.amber, ));
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
        
            final data = snapshot.data!;
        
            final currentData = data['list'][0];
            // final WeatherTemp = currentData['main']['temp'];
            final sky = currentData['weather'][0]['main'];
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 230,
                    child: Card(
                      elevation: 23,
                      color: const Color.fromARGB(255, 33, 86, 243),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40), // it is use to set border on "BackdropFilter" property
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${(currentData['main']['temp']-273.15).toStringAsFixed(2)}.°C',
                                    // '$WeatherTemp° C ',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    sky == 'Clouds'? Icons.cloud:Icons.thunderstorm_rounded ,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '$sky',
                                    style:const TextStyle(color: Colors.white, fontSize: 30),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child:Row(
                  //     children: [
                  //       for(int i = 0 ; i < 5 ; i++)...[
                  //         Cards(
                  //           icon:data['list'][i+1]['weather'][0]['main'] != 'Clouds'?Icons.thunderstorm_rounded : Icons.cloud,
                  //           temp: '${(data['list'][i+1]['main']['temp']-273.15).toStringAsFixed(2)}°',
                  //           time: data['list'][i+1]['dt'].toString(),
                  //          ),
                  //       ]
                  //     ],
                  //   ),
                  // ),
                  
                  SizedBox(
                    height: 158,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,                      
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final hourlyHorecast = data['list'][index+1];
                        final skyForecast = hourlyHorecast['weather'][0]['main'];
                        final hourlyTime = DateTime.parse(hourlyHorecast['dt_txt'].toString());
                        return Cards(
                          icon: skyForecast!= 'Clouds'?Icons.thunderstorm_rounded : Icons.cloud,
                          temp: '${(data['list'][index+1]['main']['temp']-273.15).toStringAsFixed(2)}°C',
                          time: DateFormat.j().format(hourlyTime),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Additional Information",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  const SizedBox(
                    height: 13,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Ai(
                        icon: Icons.water_drop_outlined,
                        info: 'Humidity',
                        value: currentData['main']['humidity'].toString(),
                      ),
                      Ai(
                        icon: Icons.wind_power_rounded,
                        info: 'Wind',
                        value: currentData['wind']['speed'].toString(),
                      ),
                      Ai(
                        icon: Icons.tsunami_sharp ,
                        info: 'Sea Level',
                        value: currentData['main']['sea_level'].toString(),
                      ),
                      Ai(
                        icon: Icons.air_sharp,
                        info: 'Pressure', 
                        value: currentData['main']['pressure'].toString(),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: const Footer());
  }
}
