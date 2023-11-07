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








class ChildScreen extends StatefulWidget{
  const ChildScreen({super.key});




  @override
  State<ChildScreen> createState() => _ChildScreen();


}





class _ChildScreen extends State<ChildScreen> {





  Future<List> _loadModels(wagty) async {
    List posts = [];


    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/getpostsbydatef?wagt='+wagty+'&lang=tm';

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

    final args = ModalRoute.of(context)!.settings.arguments as CalendarArguments;

print(args.title);



    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title:Text(args.title+" habarlary"),
        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body: Container(
        child:


        Padding(
          padding: EdgeInsets.all(0),
          child:

          FutureBuilder(
              future: _loadModels(args.title.toString()),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                // render the list

                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Card(
                  margin: const EdgeInsets.all(10),
                  // render list item

                  child:

                  Column(

                    children: [

                      Row(

                        children: [




                          ClipRRect(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(50), // Image radius
                              child: Image.network(snapshot.data![index]['suraty'], fit: BoxFit.cover),
                            ),
                          ),


                          Expanded(
                            flex: 1,
                            child:
                            InkWell(

                              child:
                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.all(12),

                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index]['ady']),
                                          Text(snapshot.data![index]['bolum']),

                                        ],

                                      )



                                  )

                                ],

                              ),
                              onTap: () {
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

                            ),









                          )


                        ],


                      )

                    ],

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


class OptionsScreenArguments {
  final String title;
  final String parent;
  final String child;

  OptionsScreenArguments(this.title,this.parent,this.child);
}
