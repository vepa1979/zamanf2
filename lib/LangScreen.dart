import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:xid/xid.dart';

import 'dart:io';
import 'main.dart';
import 'dart:developer' as developer;

import 'main.dart';
import 'ParentScreen.dart';
import 'CalendarScreen.dart';








class LangScreen extends StatefulWidget{
  const LangScreen({super.key});




  @override
  State<LangScreen> createState() => _LangScreen();


}





class _LangScreen extends State<LangScreen> {





  String sel_lang="tm";

  String lang="tm";








  @override
  Widget build(BuildContext context) {

  //  final args = ModalRoute.of(context)!.settings.arguments as CalendarArguments;




    return Scaffold(



      body: Center(
        child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(

            child:
            ClipOval(
              child:
              Image.asset(
                'assets/images/zamanlogo.jpg',
                // fit: BoxFit.fitWidth,
                scale:0.1,
                width: 200,

              ),


            ),

          ),
          Padding(padding: EdgeInsets.all(10),
            child:
            const Text(
              'Siz haýsy dilde habarlary okamak isleýäňiz',
            ),

          )
          ,
          Column(
            children: [

              Container(
                width:100,
                child:
                Column(
                  children: [
                    Row(

                      mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                      children: [


                        Padding(
                          padding: EdgeInsets.only(top:15),
                          child:

                          InkWell(
                            onTap: () {
                              storage.setItem('lang', 'tm');

                              sel_lang=storage.getItem('lang');

                              hinttext="Gözleg";
                              hinttextbolumler="Bölümler";

                              Navigator.pushNamed(
                                context,
                                "/",
                              );


                            }, // Image tapped
                            splashColor: Colors.white10, // Splash color over image
                            child: Ink.image(
                              fit: BoxFit.cover, // Fixes border issues
                              width: 36,
                              height: 24,
                              image: AssetImage(
                                'assets/images/tm.jpg',
                              ),


                            ),
                          ),

                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top:15),
                          child:

                          InkWell(
                            onTap: () {

                              storage.setItem('lang', 'ru');
                              sel_lang=storage.getItem('lang');

                              hinttext="Поиск";
                              hinttextbolumler="Категории";

                              Navigator.pushNamed(
                                context,
                                "/",
                              );




                            }, // Image tapped
                            splashColor: Colors.white10, // Splash color over image
                            child: Ink.image(
                              fit: BoxFit.cover, // Fixes border issues
                              width: 36,
                              height: 24,
                              image: AssetImage(
                                'assets/images/ru.jpg',
                              ),


                            ),
                          ),

                        ),



                      ],


                    ),


                  ],

                )
                ,

              )



            ],

          )

        ],
      ),



      ),


    );
  }

}


class OptionsScreenArguments {
  final String title;
  final String parent;
  final String child;

  OptionsScreenArguments(this.title,this.parent,this.child);
}
