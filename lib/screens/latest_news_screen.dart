
import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:provider/provider.dart';


class LatestNewsScreen extends StatelessWidget {
  const LatestNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().fetchUSNewsData;
    return Container(
                child: Consumer<NewsProvider>(
                  builder: (context,data,child){
                    return data.latestNews.isEmpty && !data.error
                    ? const CircularProgressIndicator()
                    : data.error
                    ? Text('Oops, something went wrong. ${data.errorMessage}', textAlign: TextAlign.center,)
                    :  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.latestNews.length,
                    itemBuilder: (context, index) {
                      return LatestNewsCard(
                        latestNews: data.latestNews['articles'][index],
                      );
                    },
                  );
                  }
                ),
              );
  }


}

class LatestNewsCard extends StatelessWidget {
  const LatestNewsCard({required this.latestNews, Key? key}) : super(key: key);
  final Map<String, dynamic> latestNews;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 1,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network('${latestNews['urlToImage']}'),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  15,
                  15,
                  10,
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black12.withOpacity(0),
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${latestNews['title']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${latestNews['description']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}