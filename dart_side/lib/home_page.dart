import 'package:flutter/material.dart';
import 'package:dart_side/pagina2.dart';
import 'package:dart_side/pagina3.dart';

class HomePage extends StatefulWidget {
  final String? numero_random;
  final String? texto;
  final String? emoticon;

  HomePage({
    Key? key,
    required this.numero_random,
    required this.texto,
    required this.emoticon,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textFieldController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarea Opcional'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 4.0, left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'BIEVENIDOS',
                  style: TextStyle(
                    fontFamily: 'Pacifico', 
                    fontSize: 40, 
                    color: Colors.grey.shade700),
                ),
                SizedBox(height: 15),
                Image.asset(
                  'assets/dart_side.png',
                ),
                SizedBox(height: 60),
                Text(
                  'Seleccione la accion a realizar',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro', 
                    fontSize: 20, 
                    fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _mostrarAlerta();
                      },
                      child: Text('Página 2'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _irPagina3();
                      },
                      child: Text('Página 3'),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    "Pg. 2 => ",
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${widget.numero_random}",
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.w500),
                  ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    "Pg. 3 => ",
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${widget.emoticon}",
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.w500),
                  ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _mostrarAlerta(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ingrese datos"),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Ingrese palabra"),
            maxLength: 10,
          ),
          actions: [
            TextButton(
              onPressed: () { 
                _irPagina2("HOLA");
              },
              child: Text(
                "Default",
                style: TextStyle(color: Colors.black)
              ),
            ),
            TextButton(
              onPressed: () { 
                Navigator.pop(context, 'Cancel');
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black)
              ),
            ),
            TextButton(
              onPressed: () { 
                _irPagina2(_textFieldController.text);
              },
              child: Text(
                "Aceptar",
                style: TextStyle(color: Colors.black)
              ),
            ),
          ],
        );
      }
    );
  }

  void _irPagina2(String texto) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Pagina2(
          numero_random: widget.numero_random,
          texto: texto,
          emoticon: widget.emoticon,
        ),
      ),
    );
  }

  void _irPagina3(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Pagina3(
          numero_random: widget.numero_random,
          texto: widget.texto,
          emoticon: widget.emoticon,
        ),
      ),
    );
  }
}
