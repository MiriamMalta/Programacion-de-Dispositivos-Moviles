import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController serviceController = new TextEditingController();
  bool round = false;
  double tip = 0.0;
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.store, color: Colors.green.shade900),
            title: Padding(
              padding: EdgeInsets.only(right: 150),
              child: TextField(
                controller: serviceController,
                decoration: InputDecoration(
                  labelText: 'Cost of Service',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.green.shade900),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room_service, color: Colors.green.shade900),
            title: Text("How was the service?"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Column(
              children: [
                ListTile(
                  leading: Radio(
                    value: 0.20,
                    groupValue: tip,
                    activeColor: Colors.cyan.shade700,
                    onChanged: (value) {
                      setState(() {
                        tip = value as double;
                      });
                    },
                  ),
                  title: Text('Amazing (20%)'),
                ),
                ListTile(
                  leading: Radio(
                    value: 0.18,
                    groupValue: tip,
                    activeColor: Colors.cyan.shade700,
                    onChanged: (value) {
                      setState(() {
                        tip = value as double;
                      });
                    },
                  ),
                  title: Text('Good (18%)'),
                ),
                ListTile(
                  leading: Radio(
                    value: 0.15,
                    groupValue: tip,
                    activeColor: Colors.cyan.shade700,
                    onChanged: (value) {
                      setState(() {
                        tip = value as double;
                      });
                    },
                  ),
                  title: Text('Okay (15%)'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: ListTile(
                  leading: Icon(Icons.north_east, color: Colors.green.shade900),
                  title: Text("Round up tip"),
                ),
              ),
              Switch(
                value: round,
                onChanged: (value) {
                  setState(() {
                    round = value;
                  });
                },
                activeTrackColor: Colors.cyan.shade200,
                activeColor: Colors.cyan.shade700,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left:73, right: 12),
            child: MaterialButton(
              child: Text("CALCULATE"),
              onPressed: _tipCalculation,
              color: Colors.green.shade900,
              textColor: Colors.white,
              hoverColor: Colors.green.shade200,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15, right:12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Tip amount: \$${total.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    if (serviceController.text.isNotEmpty) {
      total = double.parse(serviceController.text);
      total = total * (1 + tip);
      if (!round) {
        total = double.parse((total).toStringAsFixed(2));
      }
      else if (round) {
        total = total.ceil().toDouble();
      }
      setState(() {});
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Empty content"),
            content: Text("Please enter the cost of service"),
            actions: [
              TextButton(
                onPressed: () { 
                  Navigator.pop(context, 'OK');
                },
                child: Text("OK"),
              ),
            ],
          );
        }
      );
    }
  }
}