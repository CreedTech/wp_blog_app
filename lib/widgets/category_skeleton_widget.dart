import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/component_skeleton.dart';


class CategorySkeletonWidget extends StatelessWidget {
  const CategorySkeletonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.5),
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Skeleton(height: 120.h, width: 120.w),
            // Skeleton(height: 120.h, width: 120.w),
            // Skeleton(height: 120.h, width: 120.w),
          ],
        ),
      ],
    );
  }
}
