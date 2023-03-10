import 'package:first_application/dashboard/dashboard.dart';
import 'package:first_application/bloc/sign_in_bloc.dart';
import 'package:first_application/bloc/sign_in_event.dart';
import 'package:first_application/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
   Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    ),
    );
  }
}

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    hintText: 'Enter valid mail id as abc@gmail.com'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                onPressed: () {
                  BlocProvider.of<SignInBloc>(context)
                      .add(SignInSubmitEvent(emailController.text, passwordController.text));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    if(state is SignInErrorState){
                      return Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      );
                    }
                    else if(state is SignInValidState){
                      /*Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Dashboard(emailController.text, passwordController.text)
                      ));*/
                      WidgetsBinding.instance.addPostFrameCallback((_){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard(emailController.text, passwordController.text)),
                        );

                      });

                    }
                    return Container();
                    // return widget here based on BlocA's state
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
