
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'main.dart';
//import 'package:tapsana/imagePicker.dart';














class MostviewScreen extends StatefulWidget{
  const MostviewScreen({super.key});




  @override
  State<MostviewScreen> createState() => _WelayatPageState();


}



class _WelayatPageState extends State<MostviewScreen> {




  Future<List> _loadEtraplar() async {
    List posts = [];
    await storage.ready;
    String lang = await storage.getItem('lang');

    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/mostviewf?lang='+lang;

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

   // final args = ModalRoute.of(context)!.settings.arguments as WelayatArguments;









    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title:

        Text(myJson["data"]![3][storage.getItem("lang")].toString(),

          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body: Container(
        child:


          Padding(
            padding: EdgeInsets.all(16),
            child:  FutureBuilder(
                future: _loadEtraplar(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  // render the list

                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.all(16),



                          child:

               InkWell(
                 onTap: (){
                   Navigator.pushNamed(
                     context,
                     "/single",
                     arguments: ScreenArguments(
                       snapshot.data![index]['ady'],
                       'Habarlar',
                       snapshot.data![index]['id'],
                     ),
                   );

                 },

                 child:
                 Text(snapshot.data![index]['ady']),

               ),












                  ),
                )
                    : const Center(
                  // render the loading indicator
                  child: CircularProgressIndicator(),
                )),

          ),




      ),


    );
  }






}












