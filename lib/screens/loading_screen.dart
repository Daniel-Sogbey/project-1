import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/posts.dart';
import '../screens/tabs_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();

    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    fbm.subscribeToTopic('posts');
    setState(() {
      _isLoading = true;
    });
    try {
      Future.delayed(Duration.zero).then((_) async {
        await Provider.of<Posts>(context, listen: false)
            .fetchPostsBasedOnFilters()
            .then((_) async {
          await Provider.of<Answers>(context, listen: false).fetchAnswers();
        });

        await Provider.of<Posts>(context, listen: false)
            .fetchPosts(true)
            .then((_) async {
          await Provider.of<Answers>(context, listen: false).fetchAnswers();
          setState(() {
            _isLoading = false;
          });
        });
      });
    } catch (error) {
      print(
          'ERROR CAUGHT------------------------------------------------ my posts');
    }
  }

  final slider = SleekCircularSlider(
    appearance: CircularSliderAppearance(
      spinnerMode: true,
      customColors: CustomSliderColors(
        trackColor: Colors.white,
        dotColor: Colors.amber,
        progressBarColor: Colors.blue,
      ),
      customWidths: CustomSliderWidths(
        trackWidth: 1.0,
        progressBarWidth: 5.0,
        handlerSize: 10.0,
      ),
      startAngle: 20.0,
      animationEnabled: true,
      counterClockwise: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                // color: Colors.white,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 17, 225, 1).withOpacity(0.7),
                    Color.fromRGBO(255, 188, 17, 1).withOpacity(1.0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                ),
              ),
              child: SafeArea(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      heightFactor: 2.0,
                      child: Container(
                        width: 90,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScale,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Ask :: Solve :: Share',
                            style: kLoadingTextAlt,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Anonymously',
                            style: kLoadingText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            )
          : TabsScreen(),
    );
  }
}
