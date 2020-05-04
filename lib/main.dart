// full clone of microsoft sticky note app 
// by : amiri abdelghafour
// github : https://github.com/gt-theamiri
// instgram : https://www.instagram.com/in_theamiri
// twitter : https://twitter.com/tw_theamiri

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sticky/ui_elements/custom_appbar.dart';
import 'package:sticky/ui_elements/custom_note.dart';

void main() async {
  //ensureInitialized of wiget
  WidgetsFlutterBinding.ensureInitialized();
  //create a directory for the app
  Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
  //Initialized Hive db
  Hive.init(appDocumentDirectory.path);
  //create a box inside db named notes
  await Hive.openBox<String>('notes');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Notes',
      debugShowCheckedModeBanner: false,
      //provide essentiel theme data
      theme: ThemeData(
        primaryColor: Colors.green[500],
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            color: Colors.white30,
          ),
        ),
      ),
      home: Scaffold(
        //dark mode color
        backgroundColor: Color(0xff121212),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                //main screen element, each seperated in a single file to be easy to review
                //Custom appbar
                CustomAppBar(),
                SizedBox(height: 10.0),
                //notes list container
                Container(
                  height: 590,
                  child: CustomeNoteDisplayer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
