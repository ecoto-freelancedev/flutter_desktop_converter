import 'dart:async';

class ConverterPageBloc {
  final _controllerValue = StreamController<String>.broadcast();
  final _controllerResult = StreamController<double>.broadcast();

  Stream<String> get streamValue => _controllerValue.stream;
  Stream<double> get streamResult => _controllerResult.stream;

  String _value;
  double _result;

  selectMeasure(String val) {
    _value = val;
    _result = 0.0;
    _controllerValue.add(_value);
    _controllerResult.add(_result);
  }

  convertTo(double result) {
    _result = result;
    if (_value == '1') {
      _result /= 1000;
    } else {
      _result *= 1000;
    }
    _controllerResult.add(_result);
  }
}
