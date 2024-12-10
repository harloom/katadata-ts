import 'package:flutter/material.dart';
import 'package:ilham_kata_data_test/module/data/models/news_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CardNews extends StatelessWidget {
  const CardNews({
  super.key,
  required this.post,
  required
});

final PostModel post;



@override
Widget build(BuildContext context) {
  return Container(
      height: 136.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.0.h),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title ?? '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Text("${post.body}".substring(0, 50),
              style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 8.h),
        ],
      ));
}
}