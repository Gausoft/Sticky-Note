import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sticky/ui_elements/add_note.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  //create a variable of type Box
  Box<String> noteBox;

  @override
  void initState() {
    //Initialze Hive box we want to add data to
    noteBox = Hive.box('notes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  //Widget appear when we want to add a new note
                  context: context,
                  builder: (BuildContext context) {
                    //Widget child seperated into aad_note.dart
                    return AddNote();
                  });
            },
            child: IconHolder(
              icon: Icons.add,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //dalete all items from database {Hive Box}
                  noteBox.clear();
                },
                child: IconHolder(
                  icon: Icons.delete_outline,
                ),
              ),
              SizedBox(width: 20.0),
              GestureDetector(
                onTap: () {
                  //exit app
                  SystemNavigator.pop();
                },
                child: IconHolder(
                  icon: Icons.close,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //close box and clear the memeory space
    noteBox.close();
    super.dispose();
  }
}

//Extracted Widget hold the icons appear on the top appbar
class IconHolder extends StatelessWidget {
  const IconHolder({this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.grey[400],
      size: 24,
    );
  }
}
