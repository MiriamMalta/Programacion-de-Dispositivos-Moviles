import 'package:flutter/material.dart';

class ItemMovie extends StatefulWidget {
  //final Map<String, String> movie;
  final List<dynamic> movie;

  ItemMovie({super.key, required this.movie});

  @override
  State<ItemMovie> createState() => _ItemMovieState();
}

class _ItemMovieState extends State<ItemMovie> {
  var heart_selected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 30, left:30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                //"${widget.movie['image']}",
                "${widget.movie[3]}", //"${widget.movie[6]}",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 0,
              child: IconButton(
                icon: heart_selected == false ? Icon(Icons.favorite_border, color: Colors.white,) : Icon(Icons.favorite, color: Colors.white,),
                onPressed: () {
                  setState(() {
                    heart_selected = !heart_selected;
                  });
                },
              )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                color: Colors.blueAccent.shade400.withOpacity(0.9),
                child: Column(
                  children: [ 
                    Text(
                      //"${widget.movie["title"]}",
                      "${widget.movie[0]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      //"${widget.movie["artist"]}",
                      "${widget.movie[1]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 15,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}