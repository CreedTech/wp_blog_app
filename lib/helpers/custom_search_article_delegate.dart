import 'package:flutter/material.dart';

import '../models/posts.dart';
import '../wp_api.dart';

class CustomSearchArticleDelegate extends SearchDelegate<String> {
  WpApi api = WpApi();

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        query.isEmpty ? null : () => query = '';
      },
    )
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => FutureBuilder(
    future: api.searchNews(query: query),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return Container(
              color: Colors.black,
              alignment: Alignment.center,
              child:  Text(
                '${snapshot.error}',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            );
          } else {
            return SearchCard(post: snapshot.data as Posts);
          }
      }
    },
  );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
    // color: Colors.black,
    // child: FutureBuilder(
    //   future: api.searchNews(query: query),
    //   builder: (context, snapshot) {
    //     if (query.isEmpty) return buildNoSuggestions();
    //
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return const Center(child: CircularProgressIndicator());
    //       default:
    //         if (snapshot.hasError) {
    //           return buildNoSuggestions();
    //         } else {
    //           return Container();
    //         }
    //     }
    //   },
    // ),
  );

  Widget buildNoSuggestions() => const Center(
    child: Text(
      'No suggestions!',
      style: TextStyle(fontSize: 28, color: Colors.white),
    ),
  );

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      final suggestion = suggestions[index];
      final queryText = suggestion.substring(0, query.length);
      final remainingText = suggestion.substring(query.length);

      return ListTile(
        onTap: () {
          query = suggestion;

          // 1. Show Results
          showResults(context);

          // 2. Close Search & Return Result
          // close(context, suggestion);

          // 3. Navigate to Result Page
          //  Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ResultPage(suggestion),
          //   ),
          // );
        },
        leading: const Icon(Icons.location_city),
        // title: Text(suggestion),
        title: RichText(
          text: TextSpan(
            text: queryText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: remainingText,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget buildResultSuccess(Posts post) =>
      Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3279e2), Colors.purple],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: ListView(
      padding: const EdgeInsets.all(64),
      children: [
        Text(
          post.title!,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        // Icon(
        //   .icon,
        //   color: Colors.white,
        //   size: 140,
        // ),
        const SizedBox(height: 72),
        Text(
          post.contents!,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
      ],
    ),
  );


}


class SearchCard extends StatelessWidget {
  const SearchCard({Key? key, required this.post}) : super(key: key);
  final Posts post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3279e2), Colors.purple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(64),
        children: [
          Text(
            post.title!,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          // Icon(
          //   .icon,
          //   color: Colors.white,
          //   size: 140,
          // ),
          const SizedBox(height: 72),
          Text(
            post.contents!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
