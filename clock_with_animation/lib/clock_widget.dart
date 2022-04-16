import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyClock extends StatelessWidget {
  final double height;
  final double width;
  final DateTime dateTime ;

  const MyClock({required this.dateTime,required this.width, required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: ClockPainter(dateTime),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  DateTime  dateTime ;

  ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    Offset centerPosition = Offset(width / 2, height / 2);
    double clockRadius = min(height, width) / 2;
    double baseRadius = clockRadius * .09;

    double hourNeedleLength = clockRadius * .6;
    double minutesNeedleLength = clockRadius * .6;
    double secondNeedleLength  = clockRadius*.8;
    double totalSteps = 60;
    double angle = (2 * pi) / 60;

    /*****
        this is clock circle
     */
    Paint clockPaint = Paint()..color = const Color(0XAA673ab7);
    canvas.drawCircle(centerPosition, clockRadius, clockPaint);

    /**
     *
     * Base of Clock
     */

    Paint basePaint = Paint()..color = const Color(0XAA320b86);
    canvas.drawCircle(centerPosition, baseRadius, basePaint);



    /***
     *
     * Digital time
     *
     */

    canvas.drawRect(Rect.fromCenter(center: Offset(centerPosition.dx, centerPosition.dy-clockRadius*.3), width: clockRadius*.6, height: clockRadius*.2), Paint()..color=Color(0XAA320b86));

    String   hour = dateTime.hour.toString();
    String   minutes = dateTime.minute.toString();
    String   isBefore = dateTime.hour<12?'am':'pm';
    TextPainter digitalTime =TextPainter(
      text: TextSpan(text: '$hour : $minutes  $isBefore',style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: clockRadius*.1),),
      textDirection: TextDirection.ltr
    );
    digitalTime.layout();
    digitalTime.paint(canvas, Offset(centerPosition.dx-clockRadius*.22, centerPosition.dy-clockRadius*.36));





    /**
     *
     * NEEDLE FOR Hours
     *
     */

    canvas.save();
    canvas.translate(clockRadius, clockRadius);
    Paint hourNeedlePaint = Paint()
      ..color = const Color(0XAA320b86)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero,
        Offset(-hourNeedleLength,0), hourNeedlePaint);

    /**
     *
     * Minutes Needle Paint
     *
     */

    Paint minutesNeedlePaint = Paint()
      ..color = const Color(0XAA320b86)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;






    /**
     *
     * Tick Printing
     *
     */

    Paint hourTickPaint = Paint()
      ..color = const Color(0XAA320b86)
      ..strokeWidth = 2;
    Paint minutesTickPaint = Paint()..color = const Color(0XAA320b86);
    final double minutesTickLength = clockRadius * .05;
    final double hourTickLength = clockRadius * .1;
    double   tickLength;
    for (int i = 0; i < totalSteps; i++) {

      i%5==0?tickLength = hourTickLength:tickLength=minutesTickLength;

      canvas.drawLine(Offset(0, -clockRadius),
               Offset(0, -clockRadius + tickLength), hourTickPaint);

      if(dateTime.second  == i){
        final minuteNeedleMargin = clockRadius * .4;
        canvas.drawLine(Offset.zero,
            Offset(minuteNeedleMargin, -minutesNeedleLength), minutesNeedlePaint);
      }
      canvas.rotate(angle);
      // if (dateTime.second == i) {
      //   canvas.drawCircle(Offset.zero, needleMinutesRadius, needleMinutePaint);
      //   //Drawing Needle Top
      //   canvas.drawLine(const Offset(-needleMinutesBaseWidth / 2, 0),
      //       Offset(0, -radius + needleMinutesTopMargin), needleMinutePaint);
      //
      //   canvas.drawLine(Offset(needleMinutesBaseWidth / 2, 0),
      //       Offset(0, 0 - radius + needleMinutesTopMargin), needleMinutePaint);
      // }

    }
    canvas.restore();

    /**
     * 12 text
     */

    final double twelveMarginInVertical = clockRadius * .04;
    final double twelveMarginInHorizontal = clockRadius * .08;

    TextPainter textPainter12 = TextPainter(
        text: const TextSpan(
          text: '12',
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter12.layout();
    textPainter12.paint(
        canvas,
        Offset(centerPosition.dx - twelveMarginInHorizontal,
            hourTickLength + twelveMarginInVertical));

    /**
     *
     * One Text
     *
     */

    final double threeMarginInVertical = clockRadius * .09;
    final double threeMarginInHorizontal = clockRadius * .25;

    TextPainter textPainter3 = TextPainter(
        text: const TextSpan(
          text: '3',
          style: TextStyle(fontSize: 15),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter3.layout();
    textPainter3.paint(
        canvas,
        Offset(centerPosition.dx * 2 - threeMarginInHorizontal,
            centerPosition.dy - threeMarginInVertical));

    /**
     *
     * Siz text
     *
     */

    final double sixMarginInVertical = clockRadius * .3;
    final double sixMarginInHorizontal = clockRadius * .05;
    TextPainter textPainter6 = TextPainter(
        text: const TextSpan(
          text: '6',
          style: TextStyle(fontSize: 15),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter6.layout();
    textPainter6.paint(
        canvas,
        Offset(centerPosition.dx - sixMarginInHorizontal,
            (centerPosition.dy * 2) - sixMarginInVertical));

    /**
     *
     * Nine text
     *
     */
    final double nineMarginInVertical = clockRadius * .09;
    final double nineMarginInHorizontal = clockRadius * .13;
    TextPainter textPainter9 = TextPainter(
        text: const TextSpan(
          text: '9',
          style: TextStyle(fontSize: 15),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter9.layout();
    textPainter9.paint(
        canvas,Offset(nineMarginInHorizontal, centerPosition.dy - nineMarginInVertical)
    );

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}




