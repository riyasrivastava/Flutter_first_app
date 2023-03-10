import 'dart:ffi';

class ApiModel{
 dynamic id = 0;
 dynamic title = "test";
 dynamic completed = false;

 ApiModel(this.title, this.id, this.completed);

 ApiModel.fromMapObject(Map<String,dynamic> map){
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