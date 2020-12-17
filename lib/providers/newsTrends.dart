import 'package:flutter/foundation.dart';

import '../models/news_trend.dart';

class NewsTrends with ChangeNotifier {
  List<NewsTrend> _news = [];

  List<NewsTrend> get news {
    return [..._news];
  }

//   Future<void> fetchTopHeadlines() async {
//     const url =
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=d6d61e8cb2634b43923da78a9a50d230';
//
//     final response = await http.get(url);
//
//     final List<NewsTrend> loadedPosts = [];
//
//     final responseData = json.decode(response.body)['articles'] as List;
//
//     responseData.forEach((item) {
//       loadedPosts.add(
//         NewsTrend(
//           title: item['title'],
//           image: item['urlToImage'],
//         ),
//       );
//     });
//
//     _news = loadedPosts;
//     notifyListeners();
//
//     print(json.decode(response.body)['articles']);
//     print(loadedPosts);
//   }
// }
}
