// import 'dart:developer';
import 'dart:math';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wp_blog_app/models/posts.dart';


class WpApi {
  static const api = "https://allure.vanguardngr.com/wp-json/wp/v2/";
  static const listApi = "https://allure.vanguardngr.com/wp-json/wp/v2/";
  static const headers = {"Accept": "application/json"};

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  List randomIds = [30, 22786,3,15750,15775,34,23419,265,16,42];



  Future<List<Posts>> fetchTopPosts() async {
    List<Posts> posts = [];
    try {
      var response = await http.get(
        Uri.parse("$api/posts?_embed&per_page=20"),
        headers: headers,
      );

      var convertDataToJson = json.decode(response.body);
      convertDataToJson.forEach((post) {
        var id = post['id'];
        String title = _parseHtmlString(post['title']['rendered']);

        // if (title.length > 30) {
        //   title = _parseHtmlString(post['title']['rendered']).substring(0, 20) + "...";
        // }

        var time = post['date'];

        var content = _parseHtmlString(post['content']['rendered']);

        var imageUrl = post['_embedded']['wp:featuredmedia'] != null
            ? post['_embedded']['wp:featuredmedia'][0]['source_url']
            : '';

        posts.add(Posts(
          id:id.toString(),
          title: title,
          image: imageUrl,
          contents: content,
          time: time,
        ));
      });
    } catch (e) {
      // log(e.toString());
      rethrow;
    }

    return posts;
  }

  // call for all Game articles
  Future<List<Posts>> fetchListPosts() async {

    var response = await http.get(
      Uri.parse("${listApi}posts?_embed&categories=4&per_page=100"),
      headers: headers,
    );

    var convertDataToJson = jsonDecode(response.body);

    List<Posts> posts = [];
    convertDataToJson.forEach((post) {
      var id = post['id'];
      String title = _parseHtmlString(post['title']['rendered']);

      var content = _parseHtmlString(post['content']['rendered']);
      var time = post['date'];

      var imageUrl = post['_embedded']['wp:featuredmedia'] != null
          ? post['_embedded']['wp:featuredmedia'][0]['source_url']
          : Image.network(
              'assets/images/img_error.jpg',
              fit: BoxFit.cover,
              width: 100,
              height: 90,
            );

      posts.add(
          Posts(
              id:id.toString(),
              title: title, image: imageUrl, contents: content, time: time));
    });

    return posts;
  }

  // api call for categories sections
  Future<List<Posts>> fetchOtherCategories(int cartCode) async {
    var response = await http.get(
      Uri.parse("${listApi}posts?_embed&categories=$cartCode"),
      headers: headers,
    );

    var convertDataToJson = jsonDecode(response.body);

    List<Posts> posts = [];

    convertDataToJson.forEach((post) {
      var id = post['id'];
      String title = _parseHtmlString(post['title']['rendered']);

      var content = _parseHtmlString(post['content']['rendered']);
      var time = post['date'];

      var imageUrl = post['_embedded']['wp:featuredmedia'] != null
          ? post['_embedded']['wp:featuredmedia'][0]['source_url']
          : Image.network(
              'assets/images/img_error.jpg',
              fit: BoxFit.cover,
              width: 100,
              height: 90,
            );

      // var time = post['date'];

      posts.add(
          Posts(title: title, image: imageUrl, contents: content, time: time,
              id: id.toString()
          ));
    });


    return posts;
  }

  Future<List<Posts>> fetchCategories() async {
    var response = await http.get(
      Uri.parse("${listApi}posts?_embed&categories?per_page=74"),
      headers: headers,
    );

    var convertDataToJson = jsonDecode(response.body);

    List<Posts> posts = [];

    convertDataToJson.forEach((post) {
      var id = post['id'];
      String title = _parseHtmlString(post['title']['rendered']);

      var content = _parseHtmlString(post['content']['rendered']);
      var time = post['date'];

      var imageUrl = post['_embedded']['wp:featuredmedia'] != null
          ? post['_embedded']['wp:featuredmedia'][0]['source_url']
          : Image.network(
        'assets/images/img_error.jpg',
        fit: BoxFit.cover,
        width: 100,
        height: 90,
      );

      // var time = post['date'];

      posts.add(
          Posts(title: title, image: imageUrl, contents: content, time: time,
              id: id.toString()
          ));
    });


    return posts;
  }

  Future<List<Posts>> searchNews({required String query}) async {
    final limit = 3;
    final url =
        '${listApi}search?_embed&search=$query';
    List<Posts> posts = [];

    // final response = await http.get(url);
    // final body = json.decode(response.body);

    var response = await http.get(
      Uri.parse("${listApi}search?search=$query"),
      headers: headers,
    );
    var convertDataToJson = jsonDecode(response.body);
    // print(convertDataToJson);


    convertDataToJson.forEach((post) {
      var id = post['id'];
      String title = _parseHtmlString(post['title']['rendered']);

      var content = _parseHtmlString(post['content']['rendered']);
      var time = post['date'];

      var imageUrl = post['_embedded']['wp:featuredmedia'] != null
          ? post['_embedded']['wp:featuredmedia'][0]['source_url']
          : Image.network(
        'assets/images/img_error.jpg',
        fit: BoxFit.cover,
        width: 100,
        height: 90,
      );

      // var time = post['date'];

      posts.add(
          Posts(title: title, image: imageUrl, contents: content, time: time,
              id: id.toString()
          ));
      // print(posts);
    });

    // print(posts);
    return posts;
  }

  // Future<List<Posts>> fetchCategories() async {
  //   var response = await http.get(
  //     Uri.parse("${listApi}posts?_embed&categories"),
  //     headers: headers,
  //   );
  //
  //   var convertDataToJson = jsonDecode(response.body);
  //
  //   List<Posts> posts = [];
  //
  //   convertDataToJson.forEach((post) {
  //     var id = post['id'];
  //     String title = _parseHtmlString(post['title']['rendered']);
  //
  //     var content = _parseHtmlString(post['content']['rendered']);
  //     var time = post['date'];
  //
  //     var imageUrl = post['_embedded']['wp:featuredmedia'] != null
  //         ? post['_embedded']['wp:featuredmedia'][0]['source_url']
  //         : Image.network(
  //       'assets/images/img_error.jpg',
  //       fit: BoxFit.cover,
  //       width: 100,
  //       height: 90,
  //     );
  //
  //     // var time = post['date'];
  //
  //     posts.add(
  //         Posts(title: title, image: imageUrl, contents: content, time: time,
  //             id: id.toString()
  //         ));
  //   });
  //   print(posts);
  //   return posts;
  // }
}
