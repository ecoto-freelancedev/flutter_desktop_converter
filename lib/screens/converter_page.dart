import 'package:flutter/material.dart';

import 'package:flutter_desktop_converter/bloc/converter_page_bloc.dart';
import 'package:flutter_desktop_converter/widgets/converter_app_bar.dart';
import 'package:flutter_desktop_converter/widgets/convert_card_widget.dart';
import 'package:flutter_desktop_converter/widgets/result_card_widget.dart';

class ConverterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamBloc = ConverterPageBloc();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue[100],
      appBar: ConverterAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 45, left: 8.0, right: 8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: ConvertCard(screenSize: _screenSize, bloC: streamBloc),
            ),
            SizedBox(height: 25),
            ResultCard(scaffoldKey: _scaffoldKey, bloC: streamBloc),
            // SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
