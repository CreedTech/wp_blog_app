import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/models/posts.dart';

import '../components/component_theme.dart';

class RefreshButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;

  const RefreshButton({Key? key, this.text, this.onPressed}) : super(key: key);
  @override
  _RefreshButtonState createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {
  @override
  Widget build(BuildContext context) {
    // final Posts? changeData = Hive.box(appState).get('state');
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return colorPrimary;
        }),
      ),
      onPressed: widget.onPressed,
      child: Text(
        '${widget.text}',
        style: const TextStyle(
          color: defaultWhite,
        ),
      ),
    );
  }
}
