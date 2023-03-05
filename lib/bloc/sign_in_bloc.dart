import 'package:email_validator/email_validator.dart';
import 'package:first_application/bloc/sign_in_event.dart';
import 'package:first_application/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignInBloc extends Bloc<SignInEvent,SignInState>{
  SignInBloc():super(SignInInitialState()){
    on<SignInSubmitEvent>((event, emit) {
      if(event.email == "" || !EmailValidator.validate(event.email)){
         emit(SignInErrorState("Please enter valid email"));
      }
      else if(event.password.length<5){
        emit(SignInErrorState("password length should be more than 4"));
      }
      else{
        emit(SignInValidState());
      }
    });
  }
}