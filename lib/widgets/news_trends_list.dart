import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/newsTrends.dart';
import '../widgets/news_trend_item.dart';

class NewsTrendsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsTrends = Provider.of<NewsTrends>(context).news;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newsTrends.length,
      itemBuilder: (ctx, i) => NewsTrendItem(newsTrends[i]),
    );
  }
}
