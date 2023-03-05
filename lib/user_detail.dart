import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'User.dart';
import 'database/database_helper.dart';

class UserDetail extends StatefulWidget {
  final dynamic item;
  const UserDetail({Key? key, required this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserDetail(item);
  }
}

class _UserDetail extends State<UserDetail>{
  final dynamic item;
  _UserDetail(this.item);
  late List<User> _data;
  @override
  void initState() {
    super.initState();
    getUserList();
  }
  Future<void> getUserList() async{
    DatabaseHelper helper = DatabaseHelper();
    List<User> userDynamicList= await helper.getUserList(item['id']);
    setState(() {
      _data = userDynamicList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: showUsers(_data)
      ),
    );
   }
  Widget showUsers(List<User> users){
    User currentUser = users.first;
    return Text(" Id : ${currentUser.id.toString()} \n "
        "Tiltle : ${currentUser.title} \n"
        "Completed : ${currentUser.completed.toString()}");
  }


}