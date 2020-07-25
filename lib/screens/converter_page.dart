import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _message;
  String _value;
  String _value2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertidor de longitud'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cantidad:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 100,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text('Medidas'),
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('metros'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('kilometros'),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    value: _value,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'A:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text('Medidas'),
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('metros'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('kilometros'),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                    value: _value2,
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Convertir',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //if (_formKey.currentState.validate()) {}
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
