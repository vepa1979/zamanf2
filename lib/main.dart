import 'dart:async';
import 'dart:convert';

//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:in_app_webview/in_app_webview.dart';
import 'package:localstorage/localstorage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tapsana/CalendarScreen.dart';
import 'package:tapsana/search.dart';

import 'firebase_options.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'dart:io';
import 'imagePicker.dart';
import 'package:tapsana/ParentScreen.dart';
import 'package:tapsana/ChildScreen.dart';
import "package:tapsana/OptionsScreen.dart";
import 'WelayatScreen.dart';

import 'CalendarScreen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tapsana/DetailScreen.dart';
import 'Searchpagescreen.dart';
import 'package:dio/dio.dart';
import 'package:tapsana/LangScreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tapsana/VideoPlayerApp.dart';











List<String> listcats = <String>[];



List<String> listcategorychild = <String>[];

//List<String> listchild = <String>[];

String listchild="";

final List<String> listselected= <String>[];







var myJson = {
  "data": [
    {'tm': 'Iň täze habarlar', 'ru': "Последние новости"},
    {'tm': 'Habarlar', 'ru': "Новости"},
    {'tm': 'Bölümler', 'ru': "Категории"},
    {'tm': 'Okaň,dynç alyň!', 'ru': "Читайте и отдыхайте!"},
    {'tm': 'Gözleg', 'ru': "Поиск"},
    {'tm': 'Zaman Türkmenistan gazeti arhiw habarlary', 'ru': "Архив новостей газеты «Zaman Türkmenistan»"},
    {'tm': 'Arhiw habarlary', 'ru': "Архив новостей"},
    {'tm': 'Habarlaşmak üçin', 'ru': "Контакт"},
    {'tm': 'Zaman Türkmenistan gazeti', 'ru': "Zaman Türkmenistan"},
    {'tm': 'BIZIŇ SALGYMYZ: Aşgabat şäheri, 1908 (Gündogar köçesi), 10-A jaýy.Tel/Faks: 28-14-05, 28-14-36 Web: https://zamanturkmenistan.com.tm/"', 'ru': "Адрес: г. Ашхабад, ул. 1908. (Гундогар), 10-А.Тел/факс: 28-14-05, 28-14-36 Веб: https://zamanturkmenistan.com.tm/ Электронная почта: zamanturkmenistan@sanly.tm, info.zamanturkmenistan@gmail.com"},
    {'tm': 'gündelik habarlar,watan waspy,ykdysadyýet', 'ru': "ежедневные новости, экономика"},
    {'tm': ' dünýä täzelikleri,syýasy habarlar', 'ru': "мировые новости, политические новости"},
    {'tm': ' bölümlere degişli soňky habarlar', 'ru': "последние новости категории"},
    {'tm': ' gyzykly güýmenjeler,edebi hekaýalar,krosswordlar', 'ru': "литературные рассказы, кроссворды"},





  ]
};

String dynamicText="";
String dynamicTextwel="";
String hinttext="Gözleg";
String hinttextbolumler="Bölümler";
int selectedcategoryid=0;
LocalStorage storage = new LocalStorage('localstorage_app');
List posts = [];

void name() async {


  await storage.ready;

  String? name = await storage.getItem("lang");

 // if(name=="")
  storage.setItem("lang", "tm");


  print(name.toString());
}

void main() async{



  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

name();




  HttpOverrides.global = MyHttpOverrides();






  WidgetsFlutterBinding.ensureInitialized();

  //This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );






  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message != null) {

      List pushes=[];





      navService.pushNamed('/single',

        args:  ScreenArguments(
          '${message.notification?.title}',
          '${message.data["bolum"]}',
          '${message.data["post_id"]}',
        ),

      );






    }

  });

  var token = await FirebaseMessaging.instance.getToken();
  settoken(token);






  runApp(MyApp());


}

settoken(token) async {
  List posts = [];


  try {
    // This is an open REST API endpoint for testing purposes
    String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/tokens/newtoken?Tokens='+token;

    final http.Response response = await http.get(Uri.parse(apiUrl));
    //posts = json.decode(response.body);

print(response.body);





  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
  }

  return posts;
}


class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xfffafafa, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffce5641 ),//10%
      100: const Color(0xffb74c3a),//20%
      200: const Color(0xffa04332),//30%
      300: const Color(0xff89392b),//40%
      400: const Color(0xff733024),//50%
      500: const Color(0xff5c261d),//60%
      600: const Color(0xff451c16),//70%
      700: const Color(0xff2e130e),//80%
      800: const Color(0xff170907),//90%
      900: const Color(0xff000000),//100%
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});









  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigationKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => MyHomePage(title: 'Zaman Türkmenistan gazeti'));
            case '/single':
              return MaterialPageRoute(builder: (_) => DetailScreen());
            default:
              return null;
          }
        },

        title: 'Zaman Türkmenistan',
        theme: ThemeData(
          // Define the default brightness and colors.
          // brightness: Brightness.light,
          primaryColor: Colors.black,
          primarySwatch: Palette.kToDark,

          // Define the default font family.
          //fontFamily: 'Arial',
          fontFamily: "RobotoSlab-VariableFont_wght",

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Arial'),
          ),
        ),
        routes: {
          '/home': (context) => MyHomePage(title: 'Zaman Türkmenistan gazeti'),
          '/details': (context) => MultipleImageSelector(),
          '/single': (context) => DetailScreen(),
          '/category': (context) => CategoryScreen(),
          '/search': (context) => SearchScreen(),
          '/parent': (context) => ParentScreen(),
          '/options': (context) => OptionsScreen(),
          '/mostview': (context) => MostviewScreen(),
          '/arhiw': (context) => CalendarScreen(),
          '/arhiwhabarlar': (context) => ChildScreen(),
          '/contact': (context) => ParentScreen(),
           '/searchpage': (context) =>Searchpagescreen(),
            '/lang': (context) =>LangScreen(),
          '/videoplayer': (context) =>VideoPlayerApp(),
          '/inapp': (context) =>InAppWebView("https://google.com"),
        },

        home: const MyHomePage(title: 'Zaman Türkmenistan gazeti'),




      ),
    );
  }




}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;








  @override

  State<MyHomePage> createState() => _MyHomePageState();




}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex=0;

  String sel_lang="tm";

  String lang="tm";
  List<String> listfour = <String>[];
  List<String> listfourady = <String>[];
  List<String> listfouraciklama = <String>[];
  List<String> listfourid = <String>[];

  void grid() async{

    await storage.ready;
    String lang = await storage.getItem('lang');

    List posts = [];




    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://www.zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/topcategoriesf?lang='+lang;

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);

      for(int t=0;t<posts.length;t++) {
        listfour.add(posts[t]["suraty"]);
        listfourady.add(posts[t]["ady"]);
        listfourid.add(posts[t]["id"]);

        //print(posts[t]["suraty"]);
      }

    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }


  }

  Future<List> _loadnews() async {

    //String lang="tm";

    await storage.ready;
    String lang = await storage.getItem('lang');



    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://www.zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/gethabarlar?lang='+lang;

      final http.Response response = await http.get(Uri.parse(apiUrl),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer Setupvpn20223!',
      });



      posts = json.decode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }

  Future<List> _loadDatabanners() async {

    //String lang="tm";

    await storage.ready;
    String lang = await storage.getItem('lang');



    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://www.zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/topcategoriesf?lang='+lang;

      final http.Response response = await http.get(Uri.parse(apiUrl),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer Setupvpn20223!',
      });



      posts = json.decode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }

  Future<List> _loadData() async {
    List posts = [];

    var token = "Setupvpn2022!";

    await storage.ready;
    String lang = await storage.getItem('lang');

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);


    try {
      // This is an open REST API endpoint for testing purposes


      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/getjsonhometabsf?lang='+lang+'&cat=Iň täze habarlar';

      final http.Response response = await http.get(Uri.parse(apiUrl),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer Setupvpn2022!',
      });
      posts = json.decode(response.body);




    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }

  Future<List> _loadDatacats() async {


    await storage.ready;
    String lang = await storage.getItem('lang')??"tm";





    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/buttons/buttonsf?lang='+lang??"tm";

      final http.Response response = await http.get(Uri.parse(apiUrl));
      posts = json.decode(response.body);


    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    return posts;
  }

  Future<List> _loadmostgood() async {
    List posts = [];
    await storage.ready;
    String lang = await storage.getItem('lang');

    try {
      // This is an open REST API endpoint for testing purposes
      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/mostgoodf?lang='+lang;

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

      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth:180,
            leading:
            Padding(
              padding: EdgeInsets.all(4),
              child:

              Pulse(
                animate: true,
                delay: Duration(seconds: 2),
                duration: Duration(seconds: 1),

                // Just change the Image.asset widget to anything you want to fade in/out:
                child:

                InkWell(
                  onTap: () {},
                  child: Ink.image(
                    image: AssetImage('assets/images/logo.jpg'),
                    fit: BoxFit.contain,
                    height: 80,
                  ),
                )

                      // Image.asset(
                      //   'assets/images/logo.jpg',
                      //   fit: BoxFit.contain,
                      //   height: 80,
                      //
                      // ),


              ) ,// FadeOut







            ),




            title:Container(
              child:
              Row(
                children: [


                  if(storage.getItem('lang')=="tm")
                  Container(
                     padding: EdgeInsets.all(2),

                    child:

                    InkWell(
                      onTap: () {



                        Navigator.pushNamed(
                          context,
                          "/lang",
                        );




                      }, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child:

                      Ink.image(
                        //fit: BoxFit.fitHeight, // Fixes border issues
                        width: 24,
                        height: 24,
                        image: AssetImage(
                          'assets/images/tm.jpg',
                        ),
                      ),



                    ),

                  )
                  else
                  Flexible(
                  // padding: EdgeInsets.all(4),
                  child:

                  InkWell(
                  onTap: () {



                  Navigator.pushNamed(
                  context,
                  "/lang",
                  );




                  }, // Image tapped
                  splashColor: Colors.white10, // Splash color over image
                  child:

                  Ink.image(
                  //fit: BoxFit.contain, // Fixes border issues
                  width: 24,
                  height: 24,
                  image: AssetImage(
                  'assets/images/ru.jpg',
                  ),
                  ),



                  ),

                  ),

                  Flexible(child:
                  Icon(Icons.arrow_drop_down,
                    size: 20.0,
                    color: Colors.grey,
                  ),


                  )


                ],


              ),
            )









        ),

        // implement FutureBuilder
        body:
        Container(
color:Colors.white,

          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.minHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:16,bottom: 0,left:16),

                        child:
                        Text(myJson["data"]![0][storage.getItem("lang")].toString(),
                          style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,color:Colors.black87,fontFamily: "RobotoSlab-Black"),),

                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:2,bottom: 36,left:16),

                        child:
                        Text(myJson["data"]![10][storage.getItem("lang")].toString(),
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.grey),),

                      ),


                      Container(
                        height: 200,
                        child:

//slider
                        CarouselSlider(
                          options: CarouselOptions(
                              height: 200.0,autoPlay: true


                          ),
                          items: [0,1,2,3,4].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return
                                  FutureBuilder(


                                      future: _loadnews(),
                                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                                      snapshot.hasData
                                          ?

                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(horizontal:8),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(

                                            borderRadius: BorderRadius.circular(16),
                                            color: Colors.amber,
                                            image: DecorationImage(
                                              image: Image.network(snapshot.data![i]['suraty']).image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child:
                                          InkWell(

                                            onTap: (){

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
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child:
                                              Text(snapshot.data![i]['ady'],
                                                style: TextStyle(fontSize: 18.0,color:Colors.white,fontWeight: FontWeight.normal,
                                                  shadows:
                                                  <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 50.0,
                                                      color: Colors.black,
                                                    ),

                                                  ],

                                                ),),


                                            ),


                                          )

                                      )



                                          : const Center(
                                        // render the loading indicator
                                        child: CircularProgressIndicator(),
                                      ));



                              },
                            );
                          }).toList(),
                        )
                        ,

                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:24,bottom: 2,left:16),

                        child:
                        Text(myJson["data"]![1][storage.getItem("lang")].toString(),

                        style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,color:Colors.black87,fontFamily: "RobotoSlab-Black"),),

                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:2,bottom: 16,left:16),

                        child:
                        Text(myJson["data"]![11][storage.getItem("lang")].toString(),
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.grey),),

                      ),

                      Container(
                        padding: EdgeInsets.only(left:4),
                        color: Colors.white,
                        //height: 500,
                        // color: Colors.blue,
                        // height: 100,
                        // width: 100,
                        child:
                        FutureBuilder(
                          future: _loadData(),
                          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ?


                          Column(

                            children: [

                              for(int i=0;i<5;i++)
                                Row(

                                  children: [




                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(60), // Image radius
                                        child: Image.network(snapshot.data![i]['suraty'], fit: BoxFit.cover),
                                      ),
                                    ),


                                    // Image.network(snapshot.data![index]['suraty'],width: 100,),

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

                                                    Padding(padding: EdgeInsets.all(4),

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [

                                                          Text(snapshot.data![i]['wagty'],style:TextStyle(color:Colors.grey) ,),

                                                        ],

                                                      ),

                                                    ),

                                                    Padding(padding: EdgeInsets.all(4),

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [


                                                          Text(snapshot.data![i]['ady'],style:TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.bold,height: 1.4) ),


                                                        ],

                                                      ),

                                                    ),

                                                    Padding(padding: EdgeInsets.all(4),

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(snapshot.data![i]['bolum'],style:TextStyle(color:Colors.grey) ,),

                                                        ],

                                                      ),

                                                    )






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
                                              snapshot.data![i]['ady'],
                                              snapshot.data![i]['bolum'],
                                              snapshot.data![i]['id'],
                                            ),
                                          );
                                        },

                                      ),









                                    )


                                  ],


                                )




                            ],



                          )



                              : const Center(


                            // render the loading indicator
                              child: const CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))



                          ),



                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:16,bottom: 2,left:16),

                        child:
                        Text(myJson["data"]![2][storage.getItem("lang")].toString(),

                          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:2,bottom:16,left:16),

                        child:
                        Text(myJson["data"]![12][storage.getItem("lang")].toString(),
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.grey),),

                      ),


                      Container(
                        height: 144,
                        child: Row(
                          children: [
                            Expanded(
                              flex:1,
                              // color: Colors.blue,
                              // height: 100,
                              // width: 100,
                              child:
                              FutureBuilder(
                                  future: _loadDatabanners(),
                                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                                  snapshot.hasData
                                      ? ListView.builder(
                                    // render the list
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context, index) => Card(
                                        margin: const EdgeInsets.all(0),

                                        // render list item

                                        child:



                                        Container(

                                            width: 120,
                                            child:

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                InkWell(
                                                  onTap: (){





                                                    Navigator.pushNamed(
                                                      context,
                                                      "/single",
                                                      arguments: ScreenArguments(
                                                        snapshot.data![index]['ady'],
                                                        snapshot.data![index]['bolum'],
                                                        snapshot.data![index]['id'],
                                                      ),
                                                    );


                                                  },

                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 48, // Image radius
                                                        backgroundImage: NetworkImage(snapshot.data![index]['suraty']),
                                                      )

                                                      ,
                                                      Padding(

                                                        padding:EdgeInsets.all(4),
                                                        child:

                                                        Text(
                                                          snapshot.data![index]['bolum'],
                                                          textAlign: TextAlign.center, // no impact
                                                          style: TextStyle(color: Colors.blue,
                                                              //fontWeight: FontWeight.bold,
                                                              fontSize: 16.0),
                                                        ),

                                                      )
                                                      ,


                                                    ],


                                                  ),


                                                ),






                                              ],


                                            )

                                        )








                                    ),
                                  )
                                      : const Center(
                                    // render the loading indicator
                                    // child: CircularProgressIndicator(),
                                  )),
                            ),

                          ],


                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:16,bottom: 2,left:16),

                        child:
                        Text(myJson["data"]![3][storage.getItem("lang")].toString(),

                          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:2,bottom:16,left:16),

                        child:
                        Text(myJson["data"]![13][storage.getItem("lang")].toString(),
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.grey),),

                      ),

                      Container(
                        padding: EdgeInsets.only(left:4),
                        //height: 500,
                        // color: Colors.blue,
                        // height: 100,
                        // width: 100,
                        child:
                        FutureBuilder(
                          future: _loadmostgood(),
                          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ?


                          Column(

                            children: [

                              for(int i=0;i<10;i++)
                                Row(

                                  children: [




                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(60), // Image radius
                                        child: Image.network(snapshot.data![i]['suraty'], fit: BoxFit.cover),
                                      ),
                                    ),


                                    // Image.network(snapshot.data![index]['suraty'],width: 100,),

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

                                                    Padding(padding: EdgeInsets.all(4),

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [

                                                          Text(snapshot.data![i]['wagty'],style:TextStyle(color:Colors.grey) ,),

                                                        ],

                                                      ),

                                                    ),

                                                    Padding(padding: EdgeInsets.all(4),

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [


                                                          Text(snapshot.data![i]['ady'],style:TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.bold,height: 1.4) ),


                                                        ],

                                                      ),

                                                    ),

                                                    Padding(padding: EdgeInsets.all(4),

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(snapshot.data![i]['bolum'],style:TextStyle(color:Colors.grey) ,),

                                                        ],

                                                      ),

                                                    )






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
                                              snapshot.data![i]['ady'],
                                              snapshot.data![i]['bolum'],
                                              snapshot.data![i]['id'],
                                            ),
                                          );
                                        },

                                      ),









                                    )



                                  ],


                                )




                            ],



                          )



                              : const Center(





                          ),



                        ),
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        padding: EdgeInsets.all(16),

                        child:
                      Spacer()

                      ),



                    ],
                  ),
                ),
              );
            },
          ),


        ),








        endDrawer: Drawer(
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
            child:


            SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child:
                  Container(
              decoration: BoxDecoration(

                border: Border(
                  top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                 // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left:0,top:0),

              child: Column(
                  children: <Widget>[


                    Padding(padding: EdgeInsets.only(left:16,top:48),

                        child:
                        Text(myJson["data"]![2][storage.getItem("lang")].toString(),style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color:Colors.black87

                        ),)

                    ),





                    FutureBuilder(


                        future: _loadDatacats(),
                        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ?

                        Container(
                           alignment: Alignment.centerLeft,
                           padding: EdgeInsets.only(left:24,top:0,bottom:0,),
                          child:
                          Column(

                            children: [

                              for(int i=0;i<snapshot.data!.length;i++)
                                Container(

                                  alignment: Alignment.centerLeft,

                                  child:

                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                        context,
                                        "/category",
                                        arguments: CategoryArguments(
                                          snapshot.data![i]['ady'],
                                        ),
                                      );


                                    },

                                    child:
                                    Text(" "+snapshot.data![i]['ady'],
                                      style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14,
                                        fontFamily: 'Arial Rounded MT Bold',
                                        letterSpacing: 1,
                                        shadows:
                                        <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0,
                                            color: Colors.grey,
                                          ),

                                        ],

                                      ),

                                    ),


                                  ),




                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 30,

                                  margin: EdgeInsets.all(4),
                                ),









                            ],

                          ),


                        )




                            : const Center(
                          // render the loading indicator
                          child: CircularProgressIndicator(),
                        )),




                    Padding(
                      padding: EdgeInsets.all(16),

                      child:

                      Column(
                        children: [
                          Align(

                            alignment: Alignment.centerLeft,
                            child:
                            Text("Habarlaşmak üçin",style: TextStyle(fontSize: 24),),


                          ),

                          Padding(padding: EdgeInsets.all(1)),

                          Text("Biziň salgymyz: Aşgabat şäheri, 1908 (Gündogar köçesi), 10-A jaýy.Tel/Faks: 28-14-05, 28-14-36 bWeb: https://zamanturkmenistan.com.tm Elektron poçta: zamanturkmenistan@sanly.tm, info.zamanturkmenistan@gmail.com"),


                        ],


                      ),

                    )



                  ]),),),








        ),


        bottomNavigationBar:
        Container(
          height: 48,
          child:
          BottomNavigationBar(

              elevation: 0, // to get rid of the shadow
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black12,

              selectedFontSize: 10,
              unselectedFontSize: 10,


              onTap: _onItemTapped,
              backgroundColor: Colors.white, // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
              type: BottomNavigationBarType.fixed,

              items:  <BottomNavigationBarItem>[



                BottomNavigationBarItem(

                  icon: Icon(Icons.grade,size: 18,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_sharp,size: 18,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today,size: 18,),
                  label: '',
                ),
                BottomNavigationBarItem(

                  icon: Icon(Icons.contacts_sharp,size: 18,),
                  label: '',

                ),


              ]
          ),



        ),



        // BottomAppBar(
        //
        //   child: new Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //
        //       Expanded(child: IconButton(icon: Icon(Icons.show_chart,size: 24.0), onPressed: () {
        //         //mostview
        //         Navigator.pushNamed(
        //           context,
        //           "/mostview",
        //
        //         );
        //
        //
        //
        //       },),),
        //
        //       Expanded(child: IconButton(icon: Icon(Icons.search_sharp,size: 24.0), onPressed: () {
        //         //mostview
        //         Navigator.pushNamed(
        //           context,
        //           "/searchpage",
        //
        //         );
        //
        //
        //
        //       },),),
        //
        //
        //       //  Expanded(child: new Text('')),
        //       Expanded(child: IconButton(icon: Icon(Icons.calendar_today,size: 24.0), onPressed: () {
        //         Navigator.pushNamed(
        //           context,
        //           "/arhiw",
        //
        //         );
        //
        //
        //       },),),
        //       Expanded(child: IconButton(icon: Icon(Icons.contacts_sharp,size: 24.0), onPressed: () {
        //
        //
        //
        //         Navigator.pushNamed(
        //           context,
        //           "/contact",
        //
        //         );
        //
        //
        //
        //
        //       },),),
        //     ],
        //   ),
        // ),
        //




      );



  }

  void _onItemTapped(i) async{



    switch (i) {
      case 0:
        Navigator.pushNamed(context, '/mostview');
        break;
      case 1:
        Navigator.pushNamed(context, '/searchpage');
        break;
      case 2:
        Navigator.pushNamed(context, '/arhiw');
        break;
      case 3:
        Navigator.pushNamed(context, '/contact');
        break;
      default:
        Navigator.pushNamed(context, '/mostview');
    }




    setState( () {

      _selectedIndex=i;
    } ) ;




  }


}




































class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}















class CategoryScreen extends StatelessWidget {






  Future<List> _loadDatabycat(bolum) async {

    await storage.ready;
    String lang = await storage.getItem('lang');




    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes


      String apiUrl = 'https://zamanturkmenistan.com.tm/zaman/admin/index.php/urunler/getanabolumcatjf?bolum='+bolum+'&lang='+lang;




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

    final args = ModalRoute.of(context)!.settings.arguments as CategoryArguments;



    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title:Text(args.title),
        //backgroundColor: Colors.green,
        actions: const [],
      ),


      body:

      Container(
        color: Colors.white,
        child:



        Padding(
            padding: EdgeInsets.all(0),
            child:


            FutureBuilder(
              future: _loadDatabycat(args.title),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.separated(
                // render the list

                itemCount: snapshot.data!.length,

                itemBuilder: (BuildContext context, index) =>

                    Container(

                  margin: const EdgeInsets.all(10),
                  // render list item

                  child:

                  Column(

                    children: [


                      Row(

                        children: [




                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(60), // Image radius
                              child: Image.network(snapshot.data![index]['suraty'], fit: BoxFit.cover),
                            ),
                          ),


                          // Image.network(snapshot.data![index]['suraty'],width: 100,),

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
                                          Text(snapshot.data![index]['ady'],style:TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold,height: 1.4) ),

                                          Text(snapshot.data![index]['bolum']),

                                        ],

                                      )



                                  )

                                ],

                              ),
                              onTap: () {

                                //Navigator.of(context).pop();



                                if(snapshot.data![index]['bolum']=="Şekilli ertekiler")
                                  Navigator.pushNamed(
                                    context,
                                    "/videoplayer",
                                    arguments: VideoArguments(
                                      snapshot.data![index]['ady'],
                                      snapshot.data![index]['bolum'],
                                      snapshot.data![index]['suraty7'],

                                    ),
                                  );
                                  else
                                Navigator.pushNamed(
                                  context,
                                  "/single",
                                  arguments: ScreenArguments(
                                    snapshot.data![index]['ady'],
                                    snapshot.data![index]['bolum'],
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
    separatorBuilder: (context, index) {
      return Divider(thickness: 0.2,
        indent: 5,
        endIndent: 5,
      );
    },

              )
                  : const Center(
                // render the loading indicator
                  child: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))),
            )),






      ),


    );






  }
}







class ScreenArguments {



  final String title;
  final String bolum;
  final String  idsi;

  ScreenArguments(this.title,this.bolum, this.idsi);
}


class CategoryArguments {
  final String title;


  CategoryArguments(this.title);
}


class ParentArguments {
  final String title;


  ParentArguments(this.title);
}


class VideoArguments {
  final String name,category,url;


  VideoArguments(this.name,this.category,this.url);
}





















