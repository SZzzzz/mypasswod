import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../password_record.dart';

class DetailPage extends StatefulWidget {
  final PasswordRecord record;
  DetailPage({Key key, this.record}): super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(record);


}

class _DetailPageState extends State<DetailPage> {
  bool isEditing = false;
  final PasswordRecord record;

  _DetailPageState(this.record);

  TextEditingController _appNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _appNameController.text = record.appName;
    _usernameController.text = record.key;
    _passwordController.text = record.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
        title: Text(record.appName),
        actions: <Widget>[_renderEditButton()],
      ),
      body: _renderBody(),
    );
  }

  Widget _renderEditButton() {
    if (isEditing) {
      return FlatButton(child: Text('保存'), onPressed: () {
        setState(() {
          isEditing = !isEditing;
        });
      });
    } else {
      return FlatButton(child: Text('编辑'), onPressed: () {
        setState(() {
          isEditing = !isEditing;
        });
      });
    }
  }

  Widget _renderBody() {
    if (isEditing) {
      return Column(
        children: <Widget>[
          TextField(
            controller: _appNameController,
            decoration: InputDecoration(
              labelText: '应用名',
            ),
          ),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
                labelText: '用户名'
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
                labelText: '密码'
            ),
          ),
        ],
      );
    }
    if (!isEditing) {
      return Column(
        children: <Widget>[
          Text(record.appName),
          Text(record.key),
          Text(record.value),
        ],
      );
    }
  }
}