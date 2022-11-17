import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/wev_views_screen.dart';
import 'package:provider/provider.dart';

class LatestNewsScreen extends StatelessWidget {
  const LatestNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().fetchUSNewsData;
    return Container(
      child: Consumer<NewsProvider>(builder: (context, data, child) {
        return data.latestNews.isEmpty && !data.error
            ? const CircularProgressIndicator()
            : data.error
                ? Text(
                    'Oops, something went wrong. ${data.errorMessage}',
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.latestNews.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WebViewsScreen(
                                newsUrl: data.latestNews['articles'][index]['url'],
                              ),
                            ),
                          );
                        },
                        child: LatestNewsCard(
                          latestNews: data.latestNews['articles'][index],
                        ),
                      );
                    },
                  );
      }),
    );
  }
}

class LatestNewsCard extends StatelessWidget {
  const LatestNewsCard({required this.latestNews, Key? key}) : super(key: key);
  final Map<String, dynamic> latestNews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    '${latestNews['urlToImage']}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${latestNews['title']}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${latestNews['description']}',
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black38,
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
