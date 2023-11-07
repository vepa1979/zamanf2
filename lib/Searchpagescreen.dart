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

import 'package:tapsana/search.dart';






class Searchpagescreen extends StatefulWidget{
  const Searchpagescreen({super.key});




  @override
  State<Searchpagescreen> createState() => _Searchpagescreen();


}





class _Searchpagescreen extends State<Searchpagescreen> {













  @override
  Widget build(BuildContext context) {





    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title:

        Text(myJson["data"]![4][storage.getItem("lang")].toString(),

          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body: Container(
        child:


        Padding(
          padding: EdgeInsets.all(0),
          child:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              Container(
                margin: EdgeInsets.all(16),
                height: 48,
                child:
                TextField(
                  autofocus: false,

                  onSubmitted: (value){

                    Navigator.pushNamed(
                      context,
                      "/search",
                      arguments: SeacrhArguments(
                          value
                      ),
                    );




                    // or do whatever you want when you are done editing
                    // call your method/print values etc
                  },


                  decoration: InputDecoration(
                      hintText: hinttext,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),

                      suffixIcon: IconButton(icon:Icon(Icons.search), onPressed: () {
                      },)
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16.0,height:0.6),
                ),


              ),






            ],
          ),



        ),




      ),


    );
  }

}


