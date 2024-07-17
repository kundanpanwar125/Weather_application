import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:weather_icons/weather_icons.dart';
void main() {
  runApp(MaterialApp(
     debugShowCheckedModeBanner:false,
     home: wheather_app(),
  ));
}

class wheather_app extends StatefulWidget{
  @override
  wheather_app ({super.key});

  @override
  State<wheather_app> createState() => _wheather_appState();
}

class _wheather_appState extends State<wheather_app> {

  String country="";
  String ?state="";
  String ?city="select the location";
  String ?temp="0";
  String ?_weather="null";
  String ?humidity="0";
  List<Weather> ? _data;
  int wd=0;

  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  int setweek(i,j){
      int tmp=i+j;
  
      if (tmp>6){
          tmp-=7;
      }

      return tmp;
  }
  void weather_testing(String? city) async {
    if (city != null) {
      WeatherFactory wf = WeatherFactory("7c6af894cde1bee06b97a6d2072a7b70");
      Weather w = await wf.currentWeatherByCityName(city);
      List<Weather> forecast = await wf.fiveDayForecastByCityName(city);

      setState(() {
        _weather = w.weatherDescription.toString();
        wd = w.date!.weekday;
        _data = forecast;
        temp = w.temperature?.celsius?.toStringAsFixed(2);
        humidity = w.humidity.toString();
      });
    }
  }


  @override
  Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
               title: Text("weather app"),
               centerTitle:true,
            ),
            body: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                   Container(
                      width: 680,
                      margin: EdgeInsets.all(10),
                      child:  CSCPicker(
                        onCountryChanged: (value) {
                          setState(() {
                            country= value;
                          });
                        },
                        onStateChanged:(value) {
                          setState(() {
                            state= value;
                          });
                        },
                        onCityChanged:(value) {
                          setState(() {
                            city = value;
                          });
                          weather_testing(city);
                        },
                      ),
                   ),

                  Center(

                     child: Container(
                       padding: EdgeInsets.all(10),
                       width: 680,
                       margin: EdgeInsets.all(15),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5),
                           boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 3,offset: Offset(2,2))]
                       ),
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               const Icon(
                                 Icons.location_city,
                                 size: 30,
                                 color: Colors.lightBlue,
                               ),
                               Text("$city",style: const TextStyle(fontSize: 20),)
                             ],
                           ),

                           SizedBox(
                             height:20 ,
                           ),

                           Text("$temp°C",style:const TextStyle(fontSize: 20),),

                           SizedBox(
                             height:20 ,
                           ),

                           Text("$_weather",style:const TextStyle(fontSize: 20),),

                           SizedBox(
                             height:10 ,
                           ),

                           Text("Humidity : $humidity",style:const TextStyle(fontSize: 20),),
                         ],
                       ),
                     ),
                  ),



                 Center(
                   child: Container(
                     height: 200,
                     width: 710,

                     child: ListView.builder(itemBuilder:(context,index){
                          return Container(
                              child:Column(
                                 children: [
                                Container(
                                height: 100,
                                width: 120,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 3,offset: Offset(2,2))]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    (_data==null)? const Text("0°C"): Text("${_data?[index].temperature}°C"),
                                   // SizedBox(height: 10,),

                                    SizedBox(height: 10,),
                                    //   Icon( const BoxedIcon(WeatherIcons.day_sunny) as IconData?,),
                                    (_data==null)? const Text("null"): Text("${_data?[index].weatherDescription}"),

                                  ],
                                ),
                              ),


                                Container(

                                    width: 120,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 3,offset: Offset(2,2))]
                                    ),
                                    child:  (_data==null)? const Text("null"): Text("${weekdays[setweek(wd, index)]}"),
                                )

                                 ],
                              ),
                          );
                     }
                     ,itemCount: 5,
                      scrollDirection: Axis.horizontal,

                     ),
                   ),
                 ),

               ],
            ),
        );
  }
}