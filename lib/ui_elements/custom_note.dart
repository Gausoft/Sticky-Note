import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomeNoteDisplayer extends StatefulWidget {
  @override
  _CustomeNoteDisplayerState createState() => _CustomeNoteDisplayerState();
}

class _CustomeNoteDisplayerState extends State<CustomeNoteDisplayer> {
  //create a variable of type Box
  Box<String> notebox;
  @override
  void initState() {
    //Initialze Hive box we want to add data to
    notebox = Hive.box<String>("notes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      //Widget used to listen for changes on db and display back to screen
      valueListenable: notebox.listenable(),
      builder: (context, Box<String> notebox, _) {
        return ListView.separated(
            itemBuilder: (context, index) {
              //get index of item and store inside a key variable
              final key = notebox.keys.toList()[index];
              //use key variable to fetch data at index
              final value = notebox.get(key);
              //return Final Widget
              return NoteSnap(noteText: value);
            },
            separatorBuilder: (_, index) => SizedBox(height: 15.0),
            itemCount: notebox.keys.toList().length);
      },
    );
  }
}

//Extracted Widget that diplay note fetch from db
class NoteSnap extends StatelessWidget {
  NoteSnap({@required this.noteText});

  final String noteText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 7.0,
          decoration: BoxDecoration(
            color: Colors.green[500],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
          ),
          child: Text(
            '$noteText',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
              fontFamily: 'jost',
            ),
          ),
        ),
      ],
    );
  }
}
