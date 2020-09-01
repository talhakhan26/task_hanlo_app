import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_data_screen.dart';

class Dashboard extends StatefulWidget {
  static const routename = 'dashboard';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DB_State();
  }
}

class DB_State extends State<Dashboard> {
  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference()
        .child('Contacts').orderByChild('name');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Contacts List",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Add Contact',
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            debugPrint('FAB');
            Navigator.of(context).pushNamed(Add_DataList.routename);
          },
        ),
        body: WillPopScope(
          child: Container(
           height: double.infinity,
           child: FirebaseAnimatedList(query: _ref,itemBuilder:
               (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){

             Map contact = snapshot.value;

             return _dataItem(contact: contact);
           },),
          ), onWillPop: onwillpop,
        ),
    );
  }

  Widget _dataItem({Map contact}){
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        elevation: 5.0,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, color: Theme.of(context).primaryColor,size: 40),
          SizedBox(width: 10),
          Column(
            children: <Widget>[
              Text(contact['name'],style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
              SizedBox(height: 6,),
              Text(contact['numb'],style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),)
            ],
          )],
      ),);
  }

//  ListView notesBody() {}

  Future<bool> _onBackPressed() {
    return showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Do You want to exit the App?'),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: (){

          },
        ),
    FlatButton(
      child: Text('No'),
      onPressed: (){

      })
      ],
    ));
  }

  DateTime currentBackPressTime;



  Future<bool> onwillpop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Do You Want to exit?');
      return Future.value(false);
    }
    return Future.value(true);
  }
}