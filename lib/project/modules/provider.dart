import 'package:flutter/material.dart';

class SkinfPyProvider with ChangeNotifier {
  bool opend = false;
  bool stopLogo = false;
  bool verificationPlay = false;
  bool verificationMove = false;
  int verificationNumber = 0;
  setboolstopLogo() {
    stopLogo = true;
    notifyListeners();
  }

  setBoolOpend() {
    opend = true;
    notifyListeners();
  }

  // setBoolverificationPlay() {
  //   opend = true;
  //   notifyListeners();
  // }

  // setBoolverificationMove() {
  //   opend = true;
  //   notifyListeners();
  // }
}
