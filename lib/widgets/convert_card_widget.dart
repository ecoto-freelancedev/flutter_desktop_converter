import 'package:flutter/material.dart';

import 'package:flutter_desktop_converter/bloc/converter_page_bloc.dart';

class ConvertCard extends StatefulWidget {
  final Size screenSize;
  final ConverterPageBloc bloC;

  const ConvertCard({@required this.screenSize, @required this.bloC});

  @override
  _ConvertCardState createState() => _ConvertCardState();
}

class _ConvertCardState extends State<ConvertCard> {
  TextEditingController _text;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _text = TextEditingController();
    _scrollController = ScrollController();
  }

  _convertTo() {
    if (double.tryParse(_text.text) != null) {
      widget.bloC.convertTo(double.parse(_text.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: widget.screenSize.width / 2.5,
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
                          stream: widget.bloC.streamValue,
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
                                widget.bloC.selectMeasure(value);
                              },
                              value: snapshot.data,
                            );
                          }),
                    ),
                    SizedBox(width: 8),
                    StreamBuilder<String>(
                      stream: widget.bloC.streamValue,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data == '1' ? 'Kilometros(Km)' : 'Metros(m)',
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
                width: widget.screenSize.width * 0.35,
                child: StreamBuilder<String>(
                    stream: widget.bloC.streamValue,
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
                        onPressed: snapshot.data == '1' || snapshot.data == '2'
                            ? () => _convertTo()
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
    );
  }
}
