import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  dynamic favorite = [];

  void addtofavorite({required details}) {
    favorite.add(details);
    notifyListeners();
  }
}
