import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/secondary_pages/product_details.dart';
import 'package:memoire/services/admin_services.dart';
import 'package:memoire/widgets/appbar_widget.dart';
import 'package:memoire/widgets/card_details.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
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
      final posts = await ApiService.fetchPosts();
      setState(() {
        _allPosts = posts; // Store the original list
        _posts = posts; // Initialize _posts with the original list
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  void _applyFilter(String filterName) {
    setState(() {
      _selectedFilter = filterName;
      if (filterName.isEmpty) {
        _posts =
            _allPosts; // Reset to the original list if no filter is selected
      } else {
        _posts =
            _allPosts!.where((post) => post['type'] == filterName).toList();
      }
      if (filterName == "Tout") {
        _posts = _allPosts;
      }
    });
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
                        S.of(context).principal_page_text1,
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
                          onTap: () {
                            _applyFilter(filter['name'] as String);
                          },
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
