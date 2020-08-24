import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _value;
  double _result;
  Size _screenSize;
  TextEditingController _text;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _text = TextEditingController();
    _result = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: Center(
          child: Text(
            'Convertidor de longitud',
            maxLines: 2,
            style: TextStyle(
              color: Colors.lightBlue[300],
              fontSize: 23,
              fontFamily: 'Righteous',
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              height: _screenSize.height / 3.5,
              width: _screenSize.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.lightBlue[300],
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Cantidad:',
                                style: TextStyle(
                                  color: Colors.lightBlue[50],
                                  fontFamily: 'Righteous',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                height: 30,
                                width: _screenSize.width * 0.48,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextField(
                                  controller: _text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: 18,
                                    fontFamily: 'Righteous',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.indigo[900],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  hint: Text('Medidas'),
                                  style: TextStyle(
                                    color: Colors.lightBlue[50],
                                    fontSize: 20,
                                    fontFamily: 'Righteous',
                                  ),
                                  dropdownColor: Colors.lightBlue[200],
                                  items: [
                                    DropdownMenuItem(
                                      value: '1',
                                      child: Text('Metros(m)'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2',
                                      child: Text('Kilometros(Km)'),
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                      _result = 0.0;
                                    });
                                  },
                                  value: _value,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                _value == '1' ? 'Kilometros(Km)' : 'Metros(m)',
                                style: TextStyle(
                                  color: Colors.lightBlue[50],
                                  fontSize: 20,
                                  fontFamily: 'Righteous',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          RaisedButton(
                            color: Colors.indigo[900],
                            child: Text(
                              'Convertir',
                              style: TextStyle(
                                color: Colors.lightBlue[50],
                                fontFamily: 'Righteous',
                                fontSize: 20,
                              ),
                            ),
                            onPressed:
                                _value == '1' || _value == '2' ? _swapTo : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(8),
              height: _screenSize.height / 7,
              width: _screenSize.width / 2.2,
              decoration: BoxDecoration(
                color: Colors.lightBlue[300],
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  children: [
                    Text(
                      'Resultado',
                      style: TextStyle(
                        color: Colors.lightBlue[50],
                        fontSize: 30,
                        fontFamily: 'Righteous',
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            _result == null ? '' : _result.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlue[50],
                              fontSize: 20,
                              fontFamily: 'Righteous',
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            _value == '1' ? 'Kilometros(Km)' : 'Metros(m)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlue[50],
                              fontFamily: 'Righteous',
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.content_copy),
                            color: Colors.indigo[900],
                            iconSize: 20,
                            onPressed: () {
                              _copyToClipboard(_result);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  _copyToClipboard(double result) {
    final snackBar = SnackBar(
      content: Text(
        'Resultado copiado al portapapeles',
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      width: 270,
    );
    Clipboard.setData(ClipboardData(text: result.toString()));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _swapTo() {
    if (double.tryParse(_text.text) != null) {
      _result = double.parse(_text.text);
      if (_value == '1') {
        _result /= 1000;
      } else {
        _result *= 1000;
      }
      setState(() {});
    }
  }
}
