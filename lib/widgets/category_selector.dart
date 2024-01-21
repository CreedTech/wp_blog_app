import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/components/component_theme.dart';


class CategorySelector extends StatelessWidget {
  final String name;
  final int id;
  final Function onPressed;
  final bool isSelected;

  const CategorySelector({Key? key,
    required this.name,
    required this.onPressed,
    required this.id,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 7.h),
      child: TextButton(
        onPressed: () => onPressed(id),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => isSelected ? colorPrimary : null),
        ),
        child: Text(
          name.toUpperCase(),
          style: const TextStyle(color: textGray),
        ).normalSized(10).colors(textGray),
        // textColor: isSelected ? Colors.red : null,
      ),
    );
  }
}
