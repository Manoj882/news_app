// import 'package:flutter/material.dart';
// import 'package:news_app/constants/constant.dart';
// import 'package:news_app/models/news_model.dart';

// class NewsScreen extends StatelessWidget {
//  const NewsScreen({this.news,Key? key}) : super(key: key);

//   final List<NewsModel> news;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("News"),
//       ),
//       body: Padding(
//         padding: basePadding,
//         child: SingleChildScrollView(
//           child: ListView.separated(
//             itemBuilder: news.length,
//             separatorBuilder: separatorBuilder,
//             itemCount: itemCount,
//           ),
//         ),
//       ),
//     );
//   }
// }
