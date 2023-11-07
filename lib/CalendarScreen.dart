
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'main.dart';
//import 'package:tapsana/imagePicker.dart';

import 'ChildScreen.dart';












class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<CalendarScreen> createState() => _MyStatefulWidgetState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _MyStatefulWidgetState extends State<CalendarScreen>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;



  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {

        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.black,
              surface: Colors.pink,
              onSurface: Colors.yellow,
            ),
            dialogBackgroundColor:Colors.blue[900],
          ),
          child:

            DatePickerDialog(

                restorationId: 'date_picker_dialog',
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),


            ),

        );


        // return DatePickerDialog(
        //   restorationId: 'date_picker_dialog',
        //   initialEntryMode: DatePickerEntryMode.calendarOnly,
        //   initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
        //   firstDate: DateTime(2021),
        //   lastDate: DateTime(2022),
        // );
      },



    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;


int selm=_selectedDate.value.month;

String selmt=selm.toString();

if(selm<10)
  selmt="0"+selm.toString();


        int seld=_selectedDate.value.day;

        String seldt=seld.toString();

        if(seld<10)
          seldt="0"+seld.toString();







        Navigator.pushNamed(
          context,
          "/arhiwhabarlar",
          arguments: CalendarArguments(
            _selectedDate.value.year.toString()+"-"+selmt+"-"+seldt

          ),
        );




        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Seçilen wagt : ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));


      });
    }
  }



  Future<String> _loadlangs() async {

    await storage.ready;
    String lang = await storage.getItem('lang');


    return lang;

  }




  @override
  Widget build(BuildContext context) {



    return Scaffold(


      appBar: AppBar(
        elevation: 0,
        title:

        FutureBuilder(
          future: _loadlangs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(

                  myJson["data"]![5][snapshot.data??""].toString()
                  ,style: TextStyle(color:Colors.black,fontSize: 18));
            } else {
              return Text('Loading...');
            }
          },
        ),
        //backgroundColor: Colors.green,
        actions: const [],
      ),



      body: Center(

        child:


        OutlinedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child:
          Column(
            children: [

              Padding(padding: EdgeInsets.only(top:100),
              child:

              FutureBuilder(
                future: _loadlangs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(

                        myJson["data"]![5][snapshot.data??""].toString()
                        ,style: TextStyle(color:Colors.black,fontSize: 18));
                  } else {
                    return Text('Loading...');
                  }
                },
              ),

             // Text(_loadlangs().toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,color: Colors.black))

              ),
              Padding(padding: EdgeInsets.only(top:50),
                child:
                  Row(
                    children: [


                      FutureBuilder(
                        future: _loadlangs(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(

                                myJson["data"]![6][snapshot.data??""].toString()
                                ,style: TextStyle(color:Colors.black,fontSize: 18));
                          } else {
                            return Text('Loading...');
                          }
                        },
                      ),

                      Icon(Icons.arrow_right,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                    ],


                  )


              )


            //  Text('Arhiw habarlary',style: TextStyle(color:Colors.black),),







            ],

          )




        ),



      ),
    );
  }
}


class CalendarArguments {
  final String title;


  CalendarArguments(this.title);
}









