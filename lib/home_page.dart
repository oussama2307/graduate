import 'package:flutter/material.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/principale_pages/chat_page.dart';
import 'package:memoire/principale_pages/favorite_page.dart';
import 'package:memoire/principale_pages/addposts_page.dart';
import 'package:memoire/principale_pages/principal_page.dart';
import 'package:memoire/principale_pages/profile_page.dart';
import 'package:memoire/principale_pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    PostsPage(),
    const FavoritePage(),
    const MyPostPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: Stack(
            children: [
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: greenColor,
                selectedItemColor: const Color.fromARGB(255, 226, 189, 79),
                unselectedItemColor: Colors.white,
                currentIndex: currentindex,
                iconSize: 20,
                selectedIconTheme: const IconThemeData(
                  size: 25,
                ),
                selectedFontSize: 0,
                unselectedFontSize: 0,
                onTap: (value) => {
                  setState(
                    () {
                      currentindex = value;
                    },
                  ),
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '',
                  ),
                ],
              ),
              Positioned(
                bottom: 13.0,
                right: 4.0,
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height *
                            0.85, // Adjust this value to your desired height
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const ProfilePage();
                      },
                    );
                  },
                  child: const Icon(
                    Icons.person,
                    size: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
