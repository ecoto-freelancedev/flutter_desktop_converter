import 'package:flutter/material.dart';

class ConverterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConverterAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
