import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier {
  int _cout =0;


  int get cout => _cout;

  void tang(){
    _cout++;
    notifyListeners();
  }
  void giam(){
    _cout--;
    notifyListeners();
  }
}