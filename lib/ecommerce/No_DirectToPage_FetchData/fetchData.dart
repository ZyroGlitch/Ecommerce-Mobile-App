import 'package:flutter/foundation.dart';

class UserIDProvider with ChangeNotifier {
  late String _userID;

  String get userID => _userID;

  void setUserID(String id) {
    _userID = id;
    notifyListeners();
  }
}
