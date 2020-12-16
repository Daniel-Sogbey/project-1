import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants/constants.dart';

class LoadingScreen extends StatelessWidget {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Colors.pinkAccent,
              // Colors.amber,
              // Colors.blue,
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
            children: <Widget>[
              Center(
                heightFactor: 2.0,
                child: slider,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  'SolveShare',
                  style: kLoadingText,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  'A SolveShare Production @2020',
                  style: kCiteTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 30,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                ),
              ),
            ],
          )
              // child: Column(
              //   children: [
              //     Center(
              //       heightFactor: 2.0,
              //       child: Container(
              //         width: 150.0,
              //         height: 150.0,
              //         child: LoadingIndicator(
              //           indicatorType: Indicator.orbit,
              //           color: Colors.pinkAccent,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: double.infinity,
              //       padding: EdgeInsets.symmetric(
              //         vertical: 30.0,
              //         horizontal: 30.0,
              //       ),
              //       child: Text(
              //         'SolveShare',
              //         style: kLoadingText,
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ],
              // ),
              ),
        ),
      ),
    );
  }
}
