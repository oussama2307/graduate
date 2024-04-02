import 'package:flutter/material.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/widgets/appbar_widget.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({super.key});

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: Container(
        child: const Center(
          child: Text("my posts"),
        ),
      ),
    );
  }
}
