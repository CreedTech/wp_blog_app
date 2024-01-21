import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String title;

  const Headline(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title),
    );
  }
}
