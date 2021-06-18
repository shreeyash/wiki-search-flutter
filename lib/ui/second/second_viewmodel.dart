import 'package:stacked/stacked.dart';

class SecondViewModel extends BaseViewModel {
  String title = 'Second View';

  void doSomething() {
    title += 'updated ';
    notifyListeners();
  }
}
