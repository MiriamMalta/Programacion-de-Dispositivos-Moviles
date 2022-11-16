import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/bloc/auth_bloc.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_4.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                "Sign In", 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/music2.jpeg"), 
                radius: 70
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              child: ElevatedButton(
                onPressed: () {
                  print("Login with Google");
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/google_icon.png",
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text("Iniciar con Google"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}