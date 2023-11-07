import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xid/xid.dart';

import 'dart:io';
import 'main.dart';
import 'dart:developer' as developer;

import 'main.dart';
import 'ChildScreen.dart';
import 'imagePicker.dart';







String defaultType1="-----";
String defaultType2="-----";
String defaultType3="-----";

enum SingingCharacter { lafayette, jefferson }







class OptionsScreen extends StatefulWidget{
  const OptionsScreen({super.key});









  @override
  State<OptionsScreen> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<OptionsScreen> {



  Future<List> _loadDataoptions(type,optionname) async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://sanlysahypa.com/index.php/options/getoptions?optionname='+optionname+'&type='+type;

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);


    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }







  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as OptionsScreenArguments;










    final newList = jsonEncode(
        {"Esaslar":"Atlary","options":

        [ {"Awto":"Motor","Emläk":"Gat sany","Hyzmat":"Ýyly"},
          {"Awto":"Karobka","Emläk":"Otag sany","Hyzmat":"Gat sany"},
          {"Awto":"Ýyly","Emläk":"Otag sany","Hyzmat":"Gat sany"},



]});




    final extractedData = jsonDecode(newList) as Map<String, dynamic>;

    final options = extractedData['options'].map((e) => e[args.parent]).toList();

print(options);






    //List<String> options= <String>["Motor","Karobka","Ýyly",""];



    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title:Text(args.title),
        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body: Container(
       child:

       ListView(
         padding: const EdgeInsets.all(8),
         children: <Widget>[

               Column(

                 children: [
                   Container(
                     padding: EdgeInsets.only(left:16),
                     child:
                     Row(

                       children: [
                         Container(
                         width:200,
                           child: Text(options[0]),

                         ),

                         Container(
                           //width: MediaQuery.of(context).size.width * 0.8,
                           child:
                           FutureBuilder(
                             future:_loadDataoptions('Type1',args.title),
                             builder: (BuildContext context, AsyncSnapshot snapshot) {
                               return snapshot.hasData
                                   ? Container(
                                 child: DropdownButton<String>(
                                   hint: Text(defaultType1 ?? 'Make a selection'),
                                   items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                     return DropdownMenuItem<String>(
                                       value:item["ady"],
                                       child: Text(item["ady"]),
                                     );
                                   }).toList(),
                                   onChanged: (value) {
                                     setState(() {
                                       defaultType1 =value.toString();
                                       dynamicText="";

                                       listselected.clear();

                                       listselected.add(value.toString());


                                     });
                                   },
                                 ),
                               )
                                   : Container(
                                 child: Center(
                                   child: Text('Loading...'),
                                 ),
                               );
                             },
                           ),

                         )

                       ],

                     ),


                   ),


                 ],

               ),
               Column(

                 children: [
                   Container(
                     padding: EdgeInsets.only(left:16),
                     child:
                     Row(

                       children: [
                         Container(
                           width:200,
                           child: Text(options[1]),

                         ),

                         Container(
                           //width: MediaQuery.of(context).size.width * 0.8,
                           child:
                           FutureBuilder(
                             future:_loadDataoptions('Type2',args.title),
                             builder: (BuildContext context, AsyncSnapshot snapshot) {
                               return snapshot.hasData
                                   ? Container(
                                 child: DropdownButton<String>(
                                   hint: Text(defaultType2 ?? 'Make a selection'),
                                   items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                     return DropdownMenuItem<String>(
                                       value:item["ady"],
                                       child: Text(item["ady"]),
                                     );
                                   }).toList(),
                                   onChanged: (value) {
                                     setState(() {
                                       defaultType2 =value.toString();
                                       dynamicText="";

                                       listselected.clear();

                                       listselected.add(value.toString());


                                     });
                                   },
                                 ),
                               )
                                   : Container(
                                 child: Center(
                                   child: Text('Loading...'),
                                 ),
                               );
                             },
                           ),

                         )

                       ],

                     ),


                   ),


                 ],

               ),
           Column(

             children: [
               Container(
                 padding: EdgeInsets.only(left:16),
                 child:
                 Row(

                   children: [
                     Container(
                       width:200,
                       child: Text(options[2]),

                     ),

                     Container(
                       //width: MediaQuery.of(context).size.width * 0.8,
                       child:
                       FutureBuilder(
                         future:_loadDataoptions('Type3',args.title),
                         builder: (BuildContext context, AsyncSnapshot snapshot) {
                           return snapshot.hasData
                               ? Container(
                             child: DropdownButton<String>(
                               hint: Text(defaultType3 ?? 'Make a selection'),
                               items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                 return DropdownMenuItem<String>(
                                   value:item["ady"],
                                   child: Text(item["ady"]),
                                 );
                               }).toList(),
                               onChanged: (value) {
                                 setState(() {
                                   defaultType3 =value.toString();
                                   dynamicText="";

                                   listselected.clear();

                                   listselected.add(value.toString());


                                 });
                               },
                             ),
                           )
                               : Container(
                             child: Center(
                               child: Text('Loading...'),
                             ),
                           );
                         },
                       ),

                     )

                   ],

                 ),


               ),


             ],

           ),
           Column(

             children: [
               Container(
                 padding: EdgeInsets.only(left:16),
                 child:
                 Row(

                   children: [


                     Container(
                       //width: MediaQuery.of(context).size.width * 0.8,
                       child:
                       TextButton(onPressed: (){



                         dynamicText=args.parent+" / "+args.child+" / "+args.title+" / "+defaultType1+" / "+defaultType2+" / "+defaultType3;

                         Navigator.pushNamed(
                           context,
                           "/details",
                         );



                       },
                         child: Text("Kabul Et",style: TextStyle(color:Colors.deepOrange)),),

                     )

                   ],

                 ),


               ),


             ],

           ),

         ],
       ),






























      ),


    );
  }






}


class OptionsArguments {
  final String motors;



  OptionsArguments(this.motors);
}


