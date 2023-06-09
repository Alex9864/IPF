import 'package:flutter/foundation.dart';

class ImageModel extends ChangeNotifier {
  String _selectedImage = 'assets/images/Avatars/chauve-souris.png';
  String role = "User";

  String get selectedImage => _selectedImage;

  void changeImage(String newImage) {
    _selectedImage = newImage;
    notifyListeners();
  }

  void setRole(String newRole) {
    role = newRole;
    notifyListeners();
  }
}