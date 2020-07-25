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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Cantidad:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    //height: 30,
                    //width: 100,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Convertir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
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
                  ),
                ),
                //SizedBox(width: 8),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'De',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        'Medidas',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: '1',
                          child: Text(
                            'metros',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text(
                            'kilometros',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
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
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'A:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        'Medidas',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: '1',
                          child: Text(
                            'metros',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text(
                            'kilometros',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
