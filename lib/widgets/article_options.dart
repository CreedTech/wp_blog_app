import 'package:flutter/material.dart';

class ArticleOptions extends StatelessWidget {
  final int id;
  final String link;
  final Function bookmark;
  final Function addFavorite;
  final Function share;
  final Function hideStory;

  const ArticleOptions({Key? key,
    required this.id,
    required this.link,
    required this.bookmark,
    required this.addFavorite,
    required this.share,
    required this.hideStory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      child: ListView(
        children: <Widget>[
          // ListTile(
          //   title: const Text('Bookmark'),
          //   leading: Icon(Icons.bookmark),
          //   onTap: () => bookmark(id),
          // ),
          ListTile(
            title: const Text('Add to Favorite'),
            leading: const Icon(Icons.favorite),
            onTap: () => addFavorite(id),
          ),
          ListTile(
            title: const Text('Share'),
            leading: const Icon(Icons.share),
            onTap: () => share(id),
          ),
          ListTile(
            title: const Text('Remove'),
            leading: const Icon(Icons.block),
            onTap: () => hideStory(id),
          ),
        ],
      ),
    );
  }
}
