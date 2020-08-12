import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mypassword/entities/password_dict.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/password_record.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PasswordRecord> _records = [];
  PasswordDict _dict;

  Future<File> _getLocalFile(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/$filename');
  }

  @override
  void initState() {
    super.initState();
    _getRecordsFromFile().then((value) {
      setState(() {
        _records = value;
      });
    });
  }

  Future<List<PasswordRecord>> _getRecordsFromFile() async {
    String filename = "records.json";
    try {
      File file = await _getLocalFile(filename);
      if (await file.exists()) {
        String data = await file.readAsString();
        return List<PasswordRecord>.from(json.decode(data).map((v) => PasswordRecord.fromJson(v)));
      } else {
        String mock = '[{"appName":"淘宝","key":"taobao","value":"123"},{"appName":"支付宝","key":"zhifubao","value":"123"}]';
        return List<PasswordRecord>.from(json.decode(mock).map((v) => PasswordRecord.fromJson(v)));
      }
    } on FileSystemException {
      return [];
    }
  }

  void _addRecord() {
    print("add record");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemCount: _records.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.blue);
          },
          itemBuilder: (BuildContext context, int index) {
            return PasswordListItem(record: _records[index]);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecord,
        tooltip: '新增password',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PasswordListItem extends StatelessWidget {
  final PasswordRecord record;

  PasswordListItem({Key key, this.record}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: GestureDetector(
        child: Text(record.appName, style: TextStyle(fontSize: 20),),
        onTap: () => Navigator.pushNamed(context, 'detail', arguments: record),
      ),
    );
  }
}