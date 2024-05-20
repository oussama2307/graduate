import 'package:flutter/material.dart';

class PostsProvider extends ChangeNotifier {
  List<dynamic> newposts = [];
  List<dynamic> _posts = [];

  List<dynamic> get posts => _posts;

  void addtoposts({required dynamic postDetails}) {
    _posts.add(postDetails);
    notifyListeners();
  }

  Future<void> addnew({required dynamic postDetails}) async {
    _posts.add(postDetails);
    notifyListeners();
  }
}
