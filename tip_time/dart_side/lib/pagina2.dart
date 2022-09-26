import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dart_side/home_page.dart';

class Pagina2 extends StatefulWidget {
  final String? numero_random;
  final String? texto;
  final String? emoticon;

  Pagina2({
    Key? key,
    required this.numero_random,
    required this.texto,
    required this.emoticon,
  }) : super(key: key);

  @override
  _Pagina2 createState() => _Pagina2();
}

class _Pagina2 extends State<Pagina2> {
  int numero_random = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página 2")),
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.pink,
                Colors.amber,
                Colors.cyan,
                Colors.purpleAccent,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.texto}',
                style: TextStyle(
                  fontFamily: 'Pacifico', 
                  fontSize: 40, 
                  color: Colors.blueGrey.shade50),
              ),
              SizedBox(height: 15),
              Text(
                'Genere numero random',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple),
              ),
              SizedBox(height: 15),
              Text(
                '${numero_random}',
                style: TextStyle(
                  fontStyle: FontStyle.italic, 
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade600),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    numero_random = (new Random().nextInt(999));
                  });
                },
                child: Text(
                  'Generar',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          numero_random: "$numero_random",
                          texto: widget.texto,
                          emoticon: widget.emoticon,
                        ),
                      ),
                    );
                  });
                },
                child: Text(
                  'Guardar',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
