import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop_converter/bloc/converter_page_bloc.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  Size _screenSize;
  TextEditingController _text;
  ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final streamBloc = ConverterPageBloc();

  @override
  void initState() {
    super.initState();
    _text = TextEditingController();
    _scrollController = ScrollController();
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
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Convertidor de longitud',
              style: TextStyle(
                color: Colors.lightBlue[300],
                fontSize: 23,
                fontFamily: 'Righteous',
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 45, left: 8.0, right: 8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Card(
                color: Colors.lightBlue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(25, 25)),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          width: _screenSize.width / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: _text,
                            scrollController: _scrollController,
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 20,
                              fontFamily: 'Righteous',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.indigo[900],
                                  size: 20,
                                ),
                                onPressed: () => _text.clear(),
                              ),
                              hintText: 'Cantidad',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Righteous',
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.indigo[900],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: [
                            DropdownButtonHideUnderline(
                              child: StreamBuilder<String>(
                                  stream: streamBloc.streamValue,
                                  builder: (context, snapshot) {
                                    return DropdownButton<String>(
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
                                        streamBloc.selectMeasure(value);
                                      },
                                      value: snapshot.data,
                                    );
                                  }),
                            ),
                            SizedBox(width: 8),
                            StreamBuilder<String>(
                              stream: streamBloc.streamValue,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data == '1'
                                      ? 'Kilometros(Km)'
                                      : 'Metros(m)',
                                  style: TextStyle(
                                    color: Colors.lightBlue[50],
                                    fontSize: 20,
                                    fontFamily: 'Righteous',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: _screenSize.width * 0.35,
                        child: StreamBuilder<String>(
                            stream: streamBloc.streamValue,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                color: Colors.indigo[900],
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Convertir',
                                    style: TextStyle(
                                      color: Colors.lightBlue[50],
                                      fontFamily: 'Righteous',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                onPressed:
                                    snapshot.data == '1' || snapshot.data == '2'
                                        ? () => _swapTo()
                                        : null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Card(
              color: Colors.lightBlue[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(25, 25)),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Resultado',
                        style: TextStyle(
                          color: Colors.lightBlue[50],
                          fontSize: 25,
                          fontFamily: 'Righteous',
                        ),
                      ),
                    ),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            StreamBuilder<double>(
                                stream: streamBloc.streamResult,
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data == null
                                        ? '0.0'
                                        : snapshot.data.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.lightBlue[50],
                                      fontSize: 20,
                                      fontFamily: 'Righteous',
                                    ),
                                  );
                                }),
                            SizedBox(width: 8),
                            StreamBuilder<String>(
                                stream: streamBloc.streamValue,
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data == '1'
                                        ? 'Kilometros(Km)'
                                        : 'Metros(m)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.lightBlue[50],
                                      fontFamily: 'Righteous',
                                      fontSize: 20,
                                    ),
                                  );
                                }),
                            StreamBuilder<double>(
                                stream: streamBloc.streamResult,
                                builder: (context, snapshot) {
                                  return IconButton(
                                    icon: Icon(Icons.content_copy),
                                    color: Colors.indigo[900],
                                    iconSize: 20,
                                    onPressed: () {
                                      _copyToClipboard(snapshot.data);
                                    },
                                  );
                                })
                          ],
                        ),
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
      streamBloc.convertTo(double.parse(_text.text));
    }
  }
}
