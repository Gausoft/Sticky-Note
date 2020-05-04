import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _noteController = TextEditingController();

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
      padding: EdgeInsets.symmetric(vertical: 120.0, horizontal: 10.0),
      child: Card(
        color: Color(0xff121212),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.green[500],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'New Note',
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          String _val = _noteController.text;
                          //check if user save an empty note
                          if (_val.isNotEmpty) {
                            noteBox.add(_val);
                            //clear text field
                            _noteController.clear();
                          } else {
                            EdgeAlert.show(
                              context,
                              title: 'Not Valid',
                              description: 'you try to save an empty note',
                              icon: Icons.warning,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          }
                        });
                        //return to main screen
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadiusDirectional.circular(30.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.save,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              child: TextField(
                controller: _noteController,
                maxLines: 5,
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w300,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
                cursorColor: Colors.green[500],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 0, top: 11, right: 15),
                    hintText: 'Type your note here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
