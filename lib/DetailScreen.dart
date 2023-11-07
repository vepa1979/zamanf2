
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';


import 'dart:io';

import 'package:share_extend/share_extend.dart';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import 'package:firebase_analytics/firebase_analytics.dart';



import 'package:url_launcher/url_launcher.dart';



FirebaseAnalytics analytics = FirebaseAnalytics.instance;


List<String> listhabar = <String>[];


String Title="";
String Text2="";
String Image2="";

String lang="";

String dynamicText="";






late  String videoname="";
late  String postname="";

final Uri _url = Uri.parse('https://flutter.dev');


class DetailScreen extends StatefulWidget{
  const DetailScreen({super.key});









  @override
  State<DetailScreen> createState() => _DetailScreen();


}








class _DetailScreen extends State<DetailScreen> {






  setview(postid) async {
    List posts = [];


    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/setview?postid'+postid;

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);







    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }



  Future<List> getposts(id) async {
    List posts = [];


    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/harytf?id='+id;

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);

      Title=posts[0]["ady"];
      Text2=posts[0]["aciklama"];
      Image2=posts[0]["suraty"];
      lang=posts[0]["sostaw"];





    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }



  Future<List> _loadDatabycat(bolum) async {




    await storage.ready;
    String lang = await storage.getItem('lang');

    print(lang);


    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/getanabolumcatjf?bolum='+bolum+"&lang="+lang;

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }


  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then(
          (_) {
        if (mounted) {
          setshow(context);
        };
      },
    );










  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.


    super.dispose();
  }

  setshow(context){


    dynamicText="Gyzykly bolup biler";


    //String sel_lang=storage.getItem('lang');

    if(lang=="ru")
      dynamicText="Читайте также";



  }



  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    dynamicText="";


    return Scaffold(

      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,

        body:


        Center(

      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(

              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(

                    // A fixed-height child.
                   padding: EdgeInsets.only(left: 16,right: 16),
                    color: Colors.white, // Yellow
                   // height: 500,
                    alignment: Alignment.center,
                    child:

                    FutureBuilder(
                      future: getposts(args.idsi.toString()),
                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ?

                         Column(

                           children: [
                             ClipRRect(
                               child: SizedBox.fromSize(
                                 //size: Size.fromRadius(50), // Image radius
                                 child: Image.network(snapshot.data![0]['suraty'], fit: BoxFit.cover),
                               ),
                             ),

                             Align(
                               alignment: Alignment.centerLeft,
                               child: Container(
                                 color: Colors.white60,
                                 padding: EdgeInsets.all(4),
                                 height: 50,
                                 child:
                                 Padding(
                                   padding: EdgeInsets.all(0),


                                   child: Row(
                                     children: [

                                       Expanded(
                                         child:
                                         Text(snapshot.data![0]['bolum']+" / "+snapshot.data![0]['wagty'],
                                           style: TextStyle(color: Colors.grey),
                                         ),
                                       ),





                                     ],


                                   ),
                                 ),




                               ),
                             ),

                             Align(
                               alignment: Alignment.centerRight,
                               child:

                               TextButton(

                                   onPressed: (){




                                     ShareExtend.share(snapshot.data![0]['ady']+"\n"+snapshot.data![0]['linki'], "text",
                                         sharePanelTitle: snapshot.data![0]['ady'],
                                         subject: "Zaman Türkmenistan gazeti");


                                   }, child:
                               Icon(Icons.share,
                                 size: 20.0,
                                 color: Colors.grey,
                               )
                                 //Text("Paýlaş",style: TextStyle(color: Colors.grey))
                               ),

                             ),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [

                                 HtmlWidget(snapshot.data![0]['ady'], textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),



              Padding(padding: EdgeInsets.only(top:16),
                child:



                HtmlWidget(snapshot.data![0]['aciklama'],textStyle: TextStyle(fontSize: 24,height: 1.6)),

              ),


                                 switchWithString(snapshot.data![0]['bolum'],snapshot.data![0]['ady'],snapshot.data![0]['suraty7']),



                               ],

                             ),

                           ],

                         )







                          : const Center(
                        // render the loading indicator
                          child: const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))),

                    ),




                  ),






                  Container(
                    // Another fixed-height child.
                    color: Colors.white,// Green
                   // height: auto,
                    alignment: Alignment.center,
                    child:
                    Column(

                      children: [





                        Padding(
                            padding: EdgeInsets.only(left: 16,bottom: 16),
                            child:


                            FutureBuilder(
                              future: _loadDatabycat(args.bolum),
                              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                              snapshot.hasData
                                  ?

                                  Column(
                       children: [


                         if(lang=="tm")
                         Padding(
                           padding: EdgeInsets.all(16),
                           child:
                           Align(
                             alignment: Alignment.centerLeft,
                             child:
                             Text('Gyzykly bolup biler',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color:Colors.black)),
                           ),

                         )
                         else
                           Padding(
                             padding: EdgeInsets.all(16),
                             child:
                             Align(
                               alignment: Alignment.centerLeft,
                               child:
                               Text('Читайте также',style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color:Colors.black)),
                             ),

                           ),





                         for(int i=0;i<getlenth(snapshot.data!.length);i++)

                            Align(
                              alignment: Alignment.centerLeft,
                              child:

                                TextButton(
                                  onPressed: (){
                                    Navigator.pushNamed(
                                      context,
                                      "/single",
                                      arguments: ScreenArguments(
                                        snapshot.data![i]['ady'],
                                        snapshot.data![i]['bolum'],
                                        snapshot.data![i]['id'],
                                      ),
                                    );

                                  },
                                  child:
                                  Text(snapshot.data![i]['ady'],style: TextStyle(color:Colors.black))
                                  ,

                                ),



                            ),




                       ],


                                  )





                                  : const Center(
                                // render the loading indicator
                                  child: const CircularProgressIndicator()),
                            )),







                      ],


                    ),
                  ),


                ],
              ),
            ),
          );
        },
      ),


        ),
    );
  }


  getlenth(len){
    if(len>=5)
      return 5;
    else
      return len;

  }

   switchWithString(categoryname,ady,aciklama) {

    switch(categoryname){

      case 'Zaman Türkmenistan pdf formatda' :
        return
          TextButton(onPressed: () async {




            final File? file = await FileDownloader.downloadFile(
                url:aciklama,
                name: 'zamanpdf.pdf',
                onProgress: (String? fileName, double progress) {



                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Göçürme dowam edýär'),
                  ));






                },


                onDownloadCompleted:(path){

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Pdf göçürüldi'+path),
                  ));



                }




            );


          }, child:

          Text("Göçürip almak üçin",style: TextStyle(color:Colors.blue,fontSize: 24),)



          );


        break;

      case 'Şekilli ertekiler' :
        return
   Text("");

    break;



      default:
        return Text("");





    }

  }






}












