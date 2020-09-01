import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add_DataList extends StatefulWidget {
  static const routename = 'addlist';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddState();
  }
}

class AddState extends State<Add_DataList> {
  TextEditingController _NameCtrl, _NumbCtrl;
  DatabaseReference _reference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _NameCtrl = TextEditingController();
    _NumbCtrl = TextEditingController();
    _reference = FirebaseDatabase.instance.reference().child('Contacts');
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Contact",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: textStyle,
                  controller: _NameCtrl,
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                    hintText: "Enter Name",
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      size: 30.0,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (value) {
                    debugPrint('Something Change in Title TextField');
                  }),
            ),
            Container(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: _NumbCtrl,
                  decoration: InputDecoration(
                    labelText: "Enter Number",
                    hintText: "Enter Password",
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                    prefixIcon: Icon(
                      Icons.phone_iphone,
                      size: 30.0,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (value) {
                    debugPrint('Something Change in Title TextField');
                  }),
            ),
            Container(height: 20.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF219653),
                child: Text(
                  'Save',
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print("Save Button");
                  _Save();
                },
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _Save() {
    String name = _NameCtrl.text;
    String numb = _NumbCtrl.text;

    Map<String, String> contactsList = {'name': name, 'numb': numb};

    _reference.push().set(contactsList).then((value) {
      Navigator.pop(context);
    });
  }
}
