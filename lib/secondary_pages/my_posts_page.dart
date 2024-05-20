import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/secondary_pages/product_details.dart';
import 'package:memoire/widgets/appbar_widget.dart';
import 'package:memoire/services/admin_services.dart';
import 'package:memoire/widgets/card_details.dart';
import 'package:memoire/widgets/card_mypost_details.dart';
import 'package:provider/provider.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({super.key});

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  List<dynamic>? _userPosts;
  late final int id;
  @override
  void initState() {
    super.initState();
    _fetchUserPosts();
    id = Provider.of<UsernameProvider>(context, listen: false).user['userID'];
  }

  Future<void> _fetchUserPosts() async {
    try {
      List<dynamic> posts = await ApiService.fetchUserPosts(context,
          Provider.of<UsernameProvider>(context, listen: false).user['userID']);
      setState(() {
        _userPosts = posts;
      });
    } catch (e) {
      print('Error fetching user posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: _userPosts != null
          ? Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Mes publication",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _userPosts!.length,
                      itemBuilder: (context, index) {
                        final post = _userPosts![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetails(product: post);
                                  },
                                ),
                              );
                            },
                            child: CardDetailMyPost(product: post));
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
