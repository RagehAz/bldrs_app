import 'package:bldrs/view_brains/drafters/timerz.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DateFuckingTimers extends StatefulWidget {
  @override
  _DateFuckingTimersState createState() => _DateFuckingTimersState();
}

class _DateFuckingTimersState extends State<DateFuckingTimers> {
  @override
  Widget build(BuildContext context) {

    DateTime dateTimeNow = DateTime.now();
    String cipheredDateTime = cipherDateTimeToString(dateTimeNow);
    DateTime decipheredDateTime = decipherDateTimeString(cipheredDateTime);
    int day = decipheredDateTime.day;
    int weekday = decipheredDateTime.weekday;

    return MainLayout(
      layoutWidget: Center(
        child: Column(

          children: [

            SuperVerse(
              verse: 'dateTimeNow \n $dateTimeNow',
              labelColor: Colorz.BlackBlack,
              margin: 20,
              size: 2,
              maxLines: 2,
              centered: false,
            ),

            SuperVerse(
              verse: 'cipheredDateTime \n $cipheredDateTime',
              labelColor: Colorz.BlackBlack,
              margin: 20,
              size: 2,
              maxLines: 2,
              centered: false,
            ),

            SuperVerse(
              verse: 'decipheredDateTime \n $decipheredDateTime',
              labelColor: Colorz.BlackBlack,
              margin: 20,
              size: 2,
              maxLines: 2,
              centered: false,
            ),

            SuperVerse(
              verse: 'day \n $day',
              labelColor: Colorz.BlackBlack,
              margin: 20,
              size: 2,
              maxLines: 2,
              centered: false,
            ),

            SuperVerse(
              verse: 'weekday \n $weekday',
              labelColor: Colorz.BlackBlack,
              margin: 20,
              size: 2,
              maxLines: 2,
              centered: false,
            ),

          ],
        ),
      ),
    );
  }
}
