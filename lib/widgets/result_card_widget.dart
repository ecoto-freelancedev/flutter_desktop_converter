import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_desktop_converter/bloc/converter_page_bloc.dart';

class ResultCard extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ConverterPageBloc bloC;

  const ResultCard({@required this.scaffoldKey, @required this.bloC});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      stream: bloC.streamResult,
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
                      },
                    ),
                    SizedBox(width: 8),
                    StreamBuilder<String>(
                      stream: bloC.streamValue,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data == '1' ? 'Kilometros(Km)' : 'Metros(m)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightBlue[50],
                            fontFamily: 'Righteous',
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                    StreamBuilder<double>(
                        stream: bloC.streamResult,
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
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
