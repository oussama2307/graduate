import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/favorite_provider.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/secondary_pages/product_details.dart';
import 'package:memoire/services/admin_services.dart';

import 'package:memoire/widgets/appbar_widget.dart';
import 'package:memoire/widgets/card_details.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<dynamic>? _posts;
  List<dynamic>? _allPosts;
  String? _selectedFilter;
  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await ApiService.fetchFavo(context,
          Provider.of<UsernameProvider>(context, listen: false).user['userID']);
      setState(() {
        _allPosts = posts; // Store the original list
        _posts = posts; // Initialize _posts with the original list
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle mystyle = GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return Scaffold(
      backgroundColor: greyColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: _posts != null
          ? Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mes favoris",
                        style: mystyle,
                      ),
                    ],
                  ),
                  /********************************************************** */
                  const SizedBox(
                    height: 10,
                  ),
                  /********************************************************** */
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Filters.length,
                      itemBuilder: (context, index) {
                        final filter = Filters[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              width: 90,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      blurRadius: 5,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (filter["icon"] as Widget),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    (filter["name"] as String),
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  /********************************************************************** */
                  Expanded(
                    child: ListView.builder(
                      itemCount: _posts!.length,
                      itemBuilder: (context, index) {
                        final post = _posts![index];
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
                          child: CardDetail(
                            type: post['type'],
                            soustype: post['service'],
                            description: post['description'],
                            userName: post['userName'],
                            imageUrl: post['images'][0],
                            pfp: post["userProfilePicture"],
                            liked: true,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
