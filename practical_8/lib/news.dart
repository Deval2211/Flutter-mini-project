import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/article.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  Future<NewsResponse> fetchNews() async {
    try {
      final apiUrl = dotenv.env['NEWS_API_1'] ?? '';

      if (apiUrl.isEmpty) {
        throw Exception('API URL not configured');
      }

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(json.decode(response.body));
      } else {
        // Return mock data for demo purposes
        return _getMockNewsResponse();
      }
    } catch (e) {
      // Return mock data if API fails (good for college demos)
      return _getMockNewsResponse();
    }
  }

  NewsResponse _getMockNewsResponse() {
    return NewsResponse(
      status: 'ok',
      totalResults: 3,
      articles: [
        Article(
          title: 'Flutter Development Best Practices',
          description:
              'Learn the best practices for developing Flutter applications.',
          url: 'https://flutter.dev',
          urlToImage:
              'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
          publishedAt: '2025-10-01T12:00:00Z',
          author: 'Flutter Team',
          content: 'This is a comprehensive guide to Flutter development...',
        ),
        Article(
          title: 'Mobile App Development Trends 2025',
          description:
              'Explore the latest trends in mobile application development.',
          url: 'https://example.com',
          urlToImage: 'https://picsum.photos/400/200?random=1',
          publishedAt: '2025-10-01T10:00:00Z',
          author: 'Tech News',
          content: 'Mobile development continues to evolve...',
        ),
        Article(
          title: 'API Integration in Flutter',
          description:
              'How to effectively integrate APIs in your Flutter applications.',
          url: 'https://example.com',
          urlToImage: 'https://picsum.photos/400/200?random=2',
          publishedAt: '2025-10-01T08:00:00Z',
          author: 'Developer Guide',
          content: 'API integration is crucial for modern apps...',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: FutureBuilder<NewsResponse>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final newsResponse = snapshot.data!;
            return ListView.builder(
              itemCount: newsResponse.articles?.length ?? 0,
              itemBuilder: (context, index) {
                final article = newsResponse.articles![index];
                return ListTile(
                  leading: article.urlToImage != null
                      ? Image.network(
                          article.urlToImage!,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : null,
                  title: Text(article.title ?? 'No Title'),
                  subtitle: Text(article.description ?? 'No Description'),
                  onTap: () {
                    // Optionally open the article URL
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
