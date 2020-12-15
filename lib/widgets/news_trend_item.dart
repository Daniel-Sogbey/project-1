import 'package:flutter/material.dart';

import '../models/news_trend.dart';

class NewsTrendItem extends StatelessWidget {
  final NewsTrend _newsList;

  NewsTrendItem(this._newsList);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: () {},
      splashColor: Colors.black12,
      child: Container(
        width: 200,
        height: 250.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            _newsList == null
                ? Card(
                    elevation: 6,
                    child: Text(
                      'No Image Found',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17.0,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 6,
                    child: Image.network(
                      _newsList.image,
                      fit: BoxFit.cover,
                      width: 400,
                      height: 100,
                    ),
                  ),
            Text(
              _newsList.title.length > 16
                  ? _newsList.title
                      .replaceRange(16, _newsList.title.length, '...')
                  : _newsList.title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
