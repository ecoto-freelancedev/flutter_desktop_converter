import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _value;
  double _result;
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
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                height: 145,
                width: MediaQuery.of(context).size.width,
                image: AssetImage('images/fondo.png'),
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 25,
                left: 20,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Convertidor de longitud',
                  style: TextStyle(
                    color: Colors.lightBlue[50],
                    fontFamily: 'Righteous',
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 8.0),
            child: Wrap(
              spacing: 15,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Cantidad:',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.indigo[900],
                            fontSize: 25,
                            fontFamily: 'Righteous',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        color: Colors.indigo[900],
                        onPressed: () => _text.clear(),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.indigo[900],
                  child: Text(
                    'Convertir',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Righteous',
                      fontSize: 25,
                    ),
                  ),
                  onPressed: _value == '1' || _value == '2' ? _swapTo : null,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: Wrap(
              spacing: 15,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      'Medidas',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Righteous',
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text(
                          'Metros(m)',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Righteous',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text(
                          'Kilometros(Km)',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Righteous',
                          ),
                        ),
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
                Icon(
                  Icons.swap_horiz,
                  size: 35,
                ),
                Text(
                  _value == '1' ? 'Kilometros(Km)' : 'Metros(m)',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Righteous',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 75,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
            color: Colors.lightBlue[50],
            child: Wrap(
              spacing: 15,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Resultado:',
                  style: TextStyle(fontFamily: 'Righteous', fontSize: 20),
                ),
                Text(
                  _result == null ? '' : _result.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Righteous',
                  ),
                ),
                Text(
                  _value == '1' ? 'Kilometros(Km)' : 'Metros(m)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Righteous',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  color: Colors.indigo[900],
                  onPressed: () {
                    _copyToClipboard(_result);
                  },
                )
              ],
            ),
          )
        ],
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
