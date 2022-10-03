import 'package:flutter/material.dart';
import 'Xanimating.dart';

class HearingMusic extends StatefulWidget {  
  const HearingMusic({super.key});

  @override
  State<HearingMusic> createState() => _HearingMusicState();
}

class _HearingMusicState extends State<HearingMusic> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =  AnimationController(
      vsync: this, 
      lowerBound: 0.3,
      duration: Duration(milliseconds: 3000)
    );
  }
  
  var estado_texto = {
    0: "Toque para escuchar",
    1: "Escuchando...",
  };
  bool estado_boton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                estado_boton == false ? estado_texto[0]! : estado_texto[1]!,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 385,
                child: 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        estado_boton = !estado_boton;
                        if (!estado_boton) controller.reset();
                        else controller.repeat();
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Animating(radius: 250, color: Colors.indigoAccent),
                        Animating(radius: 300, color: Colors.deepPurpleAccent),
                        Animating(radius: 350, color: Colors.pink.shade900),
                        Align(
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/music2.jpeg"), 
                            radius: 100
                          )
                        ),
                        Align(),
                      ],
                    ),
                  ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print("Favoritos");
                  });
                },
                child: CircleAvatar(
                  radius: 20, 
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.black),
                ),
              ),
            ],
        ),
      ),
    );
  }

}