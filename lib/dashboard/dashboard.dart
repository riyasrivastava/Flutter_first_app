import 'package:first_application/database/database_helper.dart';
import 'package:first_application/dashboard/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/api_model.dart';
import '../network/api_service.dart';
import '../bloc/api_bloc.dart';
import '../bloc/api_event.dart';
import '../bloc/api_state.dart';

class Dashboard extends StatefulWidget {
  String email;
  String pass;
  Dashboard(this.email,this.pass);

  @override
  _Dashboard createState() => _Dashboard(email,pass);
}

class _Dashboard extends State<Dashboard> {
  String email;
  String pass;
  _Dashboard(this.email,this.pass);
  @override
  void initState() {
    super.initState();
  }
  void _saveData(List<dynamic> data) async {
    DatabaseHelper helper = DatabaseHelper();
    List<ApiModel> userList = [] ;
    for (int index=0;index<data.length;index++) {
      final item = data[index];
      ApiModel user =  ApiModel(item['title'],item['id'],item['completed']);
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

      return Scaffold(
        appBar: AppBar(
          title: Text("Hi $email \n password - $pass"),
        ),
        body: BlocProvider<ApiBloc>(
          create: (context) => ApiBloc(apiService:
            ApiService(),
          )..add(FetchDataEvent()),
          child: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) {
              if (state is ApiLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApiLoadedState) {
                _saveData(state.data);
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.data[index];
                    return ListTile(
                      leading:Text(item['id'].toString()) ,
                      title: Text(item['title']),
                      subtitle: Text(item['completed'].toString()),
                      trailing: iconType(item['completed']),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemDetail(item: item),
                        ));
                      },
                    );
                  },
                );
              } else if (state is ApiErrorState) {
                return Center(child: Text(state.error));
              } else {
                return Container();
              }
            },
          ),
        ),
      );

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
