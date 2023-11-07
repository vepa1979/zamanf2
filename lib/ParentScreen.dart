import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';






class ParentScreen extends StatefulWidget{
  const ParentScreen({super.key});









  @override
  State<ParentScreen> createState() => _ParentScreen();


}









class _ParentScreen extends State<ParentScreen> {




  @override
  Widget build(BuildContext context) {






    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title:

        //Text("Habarlaşmak üçin…"),

        Text(myJson["data"]![7][storage.getItem("lang")].toString(),
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body: Container(
        color: Colors.white,
        child:


            Column(

              children: [

                Padding(
                  padding: EdgeInsets.all(16),
                  child:

                  //Text("Zaman Türkmenistan gazeti",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
                  Text(myJson["data"]![8][storage.getItem("lang")].toString(),
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),


                ),


        Padding(
          padding: EdgeInsets.all(16),
          child:
          Center(

            child:
            Container(

              width: 300,
              height: 100,
              decoration: BoxDecoration(
                //color: AppColor.appColor,
                color: Colors.white,
                //borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: new DecorationImage(
                          image: Image.asset('assets/images/zamanlogo.jpg').image,
                          fit: BoxFit.contain,
                        ))),
              ),
            ),




          ),

        ),




                Padding(
                  padding: EdgeInsets.all(16),
                  child:

                  // Text("BIZIŇ SALGYMYZ: Aşgabat şäheri, 1908 (Gündogar köçesi), 10-A jaýy."+
                  //     "Tel/Faks: 28-14-05, 28-14-36"+
                  //     "Web: https://zamanturkmenistan.com.tm/",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,height: 1.5),),

                  Text(myJson["data"]![9][storage.getItem("lang")].toString(),
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),


                ),

              ],
            )






      ),


    );
  }



}






class ChildArguments {
  final String title;
  final String parent;


  ChildArguments(this.title,this.parent);
}






