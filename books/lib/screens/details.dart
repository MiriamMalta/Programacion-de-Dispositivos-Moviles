import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Details extends StatefulWidget {
  final String? image;
  final String? title;
  final String? publishedDate;
  final String? description;
  final int? pageCount;

  const Details({
    super.key, 
    required this.image, 
    required this.title, 
    required this.publishedDate, 
    required this.description, 
    required this.pageCount
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _isComplete = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Detalles del libro"),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.public),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _sharedPressed,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height / 2.7),
              child: Image.network(
                widget.image!, 
                fit: BoxFit.fill,
              )
            ),
            SizedBox(height: 25.0),
            Text(
              "${widget.title}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 25.0),
            Row(
              children: [
                Text(
                  "${widget.publishedDate}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Paginas: ${widget.pageCount}",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            GestureDetector(
              onTap: () { 
                _isComplete = !_isComplete; 
                setState(() {});
              },
              child: _text(_isComplete),
            ),
          ],
        ),
      ),
    );
  }
  
  void _sharedPressed() {
    String message = "Hola!! Quería compartirte este libro! Se llama \"${widget.title}\" y tiene ${widget.pageCount} páginas. ¡Espero que te guste!";
    Share.share(message);
  }

  Text _text(bool isComplete) {
    if (isComplete) {
      return Text(
        "${widget.description}",
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      );
    } else {
      return Text(
        "${widget.description}",
        overflow: TextOverflow.ellipsis,
        maxLines: 6,
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      );
    }
  }
}