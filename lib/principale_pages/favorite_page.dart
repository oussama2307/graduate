import 'package:flutter/material.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/favorite_provider.dart';

import 'package:memoire/widgets/appbar_widget.dart';
import 'package:memoire/widgets/card_details.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyColor,
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 57),
          child: AppbarWidget(),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      Provider.of<FavoriteProvider>(context).favorite.length,
                  itemBuilder: (context, index) {
                    final post =
                        Provider.of<FavoriteProvider>(context).favorite[index];
                    if (Provider.of<FavoriteProvider>(context)
                            .favorite
                            .length ==
                        0) {
                      return const Center(
                        child: Text(
                          "there is no favorites",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CardDetail(
                          type: (post['type'] as String),
                          soustype: (post['soustype'] as String),
                          imageUrl: (post['imageurl'] as String),
                          description: (post['description'] as String),
                          userName: (post['username'] as String),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
