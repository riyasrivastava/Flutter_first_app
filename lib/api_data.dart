import 'package:first_application/database/database_helper.dart';
import 'package:first_application/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'User.dart';

class ApiData extends StatefulWidget {
  String email;
  String pass;
  ApiData(this.email,this.pass);

  @override
  _ApiData createState() => _ApiData(email,pass);
}

class _ApiData extends State<ApiData> {
  late List<dynamic> _data;
  String email;
  String pass;
  _ApiData(this.email,this.pass);
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/todos'));
    final parsed = json.decode(response.body) as List<dynamic>;
    _saveData(parsed);
    setState(() {
      _data = parsed;
    });
  }
  void _saveData(List<dynamic> data) async {
    DatabaseHelper helper = DatabaseHelper();
    List<User> userList = [] ;
    for (int index=0;index<data.length;index++) {
      final item = data[index];
      User user =  User(item['title'],item['id'],item['completed']);
      userList.add(user);
    }
    int result = await helper.insertUser(userList);
    if(result != 0) {
      print("data saved Successfully !!");
    }
    else
      print("problem in saving data");
  }

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Hi $email \n password - $pass"),
        ),
        body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            final item = _data[index];
            return ListTile(
              leading:Text(item['id'].toString()) ,
              title: Text(item['title']),
              subtitle: Text(item['completed'].toString()),
              trailing: iconType(item['completed']),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetail(item: item),
                ));
              },
            );
          },
        ),
      );
    }
  }
  Widget iconType(bool isCompleted){
    if(isCompleted){
      AssetImage assetImage = AssetImage('images/check.png');
      return Padding(padding: EdgeInsets.all(10.0),
        child: Image(image: assetImage),);
    }
    else{
      AssetImage assetImage = AssetImage('images/cross.png');
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Image(image: assetImage),
      );
    }
  }
}
