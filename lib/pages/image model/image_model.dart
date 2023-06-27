import 'package:flutter/foundation.dart';

class ImageModel extends ChangeNotifier {
  String avatar = 'question_mark';
  String role = "Debug";
  String firstName = "FirstNameDebug";
  String lastName = "LastNameDebug";
  bool firstConnection = true;

  void setAvatar(String newAvatar) {
    avatar = newAvatar;
    notifyListeners();
  }
  void setRole(String newRole) {
    role = newRole;
    notifyListeners();
  }
  void setFirstName(String newFirstName) {
    firstName = newFirstName;
    notifyListeners();
  }
  void setLastName(String newLastName) {
    lastName = newLastName;
    notifyListeners();
  }
  void setFirstConnection(bool newFirstConnection) {
    firstConnection = newFirstConnection;
    notifyListeners();
  }
}