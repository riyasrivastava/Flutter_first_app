import 'dart:ffi';

class User{
 dynamic id = 0;
 dynamic title = "test";
 dynamic completed = false;

 User(this.title, this.id, this.completed);
 //User({required this.title,required this.id,required this.completed});
  /*static User fromJson(json) => User(
    id:json['id'],
    title : json['title'],
    completed:json['completed'],
  );*/
 User.fromMapObject(Map<String,dynamic> map){
   this.id = map['id'];
   this.title = map['title'];
   this.completed = map['completed'];
 }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'completed' : completed,
    };
  }


}