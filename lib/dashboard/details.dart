import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/api_model.dart';
import '../database/database_helper.dart';

class ItemDetail extends StatefulWidget {
  final dynamic item;
  const ItemDetail({Key? key, required this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ItemDetail(item);
  }
}

class _ItemDetail extends State<ItemDetail>{
  final dynamic item;
  _ItemDetail(this.item);
  List<ApiModel>? _data;
  @override
  void initState() {
    super.initState();
    getUserList();
  }
  Future<void> getUserList() async{
    DatabaseHelper helper = DatabaseHelper();
    List<ApiModel> userDynamicList= await helper.getUserList(item['id']);
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
      body: getData(),
    );
   }
  Widget showUsers(List<ApiModel> users){
    ApiModel currentUser = users.first;
    return Text(" Id : ${currentUser.id.toString()} \n "
        "Tiltle : ${currentUser.title} \n"
        "Completed : ${currentUser.completed.toString()}");
  }
  Widget getData(){
    var localData = _data;
    if(localData!=null) {
      return Center(
      child: showUsers(localData)
      );
    }
    else {
      return Center(
          child: Text("Data not found")
      );
    }
  }
}