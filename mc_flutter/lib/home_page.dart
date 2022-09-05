import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAccessSelected = false;
  bool isTimerSelected = false;
  bool isTel1Selected = false;
  bool isTel2Selected = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mc Flutter'),
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: 
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_sharp, size: 50),
                  Column(
                    children: [
                      Text("Flutter McFlutter", style: TextStyle(fontSize: 20)),
                      Text("Experienced App Developer", style: TextStyle(fontSize: 12)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("123 Main Street"),
                  Text("(415) 555-0198"),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.accessibility,
                      color: isAccessSelected ? Colors.indigo : Colors.black,
                    ),
                    onPressed: () {
                      isAccessSelected = !isAccessSelected;
                      isTimerSelected = false; isTel1Selected = false; isTel2Selected = false;
                      setState((){ showResults(); });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.timer,
                      color: isTimerSelected ? Colors.indigo : Colors.black,
                    ),
                    onPressed: () {
                      isTimerSelected = !isTimerSelected;
                      isAccessSelected = false; isTel1Selected = false; isTel2Selected = false;
                      setState((){ showResults(); });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.phone_android,
                      color: isTel1Selected ? Colors.indigo : Colors.black,
                    ),
                    onPressed: () {
                      isTel1Selected = !isTel1Selected;
                      isTimerSelected = false; isAccessSelected = false; isTel2Selected = false;
                      setState((){ showResults(); });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.phone_iphone,
                      color: isTel2Selected ? Colors.indigo : Colors.black,
                    ),
                    onPressed: () {
                      isTel2Selected = !isTel2Selected;
                      isTimerSelected = false; isTel1Selected = false; isAccessSelected = false;
                      setState((){ showResults(); });
                    },
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  void showResults(){
    if(isAccessSelected){
      ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
        SnackBar(
          content: Text("Únete a un club con otras personas"),
          duration: Duration(seconds: 2),
        )
      );
    }
    else if(isTimerSelected){
      ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
        SnackBar(
          content: Text("Cuenta regresiva para el evento: 31 días"),
          duration: Duration(seconds: 2),
        )
      );
    }
    else if(isTel1Selected){
      ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
        SnackBar(
          content: Text("Llama al número 4155550198"),
          duration: Duration(seconds: 2),
        )
      );
    }
    else if(isTel2Selected){
      ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(
        SnackBar(
          content: Text("Llama al celular 3317865113"),
          duration: Duration(seconds: 2),
        )
      );
    }
  }
}