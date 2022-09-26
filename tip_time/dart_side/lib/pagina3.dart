import 'package:flutter/material.dart';
import 'package:dart_side/home_page.dart';

class Pagina3 extends StatefulWidget {
  final String? numero_random;
  final String? texto;
  final String? emoticon;

  Pagina3({
    Key? key,
    required this.numero_random,
    required this.texto,
    required this.emoticon,
  }) : super(key: key);

  @override
  _Pagina3 createState() => _Pagina3();
}

class _Pagina3 extends State<Pagina3> {
  var page = {
    0: "(✿◠‿◠)",
    1: "ʕ•́ᴥ•̀ʔっ♡",
    2: "ᕙ(`▿´)ᕗ",
  };
  var change = {
    0: 0,
    1: 0,
    2: 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página 3")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                change[0] = 1;
                _return (page[0]!);
              });
            },
            child: Text(
              '${page[0]}',
              style: TextStyle(color: change[0] == 0 ? Colors.black : Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: change[0] == 0 ? Colors.grey.shade300 : Colors.black,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                change[1] = 1;
                _return (page[1]!);
              });
            },
            child: Text(
              '${page[1]}',
              style: TextStyle(color: change[1] == 0 ? Colors.black : Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: change[1] == 0 ? Colors.grey.shade300 : Colors.black,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                change[2] = 1;
                _return (page[2]!);
              });
            },
            child: Text(
              '${page[2]}',
              style: TextStyle(color: change[2] == 0 ? Colors.black : Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: change[2] == 0 ? Colors.grey.shade300 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _return (String texto){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(
          numero_random: widget.numero_random,
          texto: widget.texto,
          emoticon: texto,
        ),
      ),
    );
  }
}
