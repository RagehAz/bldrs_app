import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String verse;
  final bool myVerse;
  final Key key;
  final String userID;

  ChatBubble({
    @required this.verse,
    @required this.myVerse,
    @required this.key,
    @required this.userID,
});

  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = superScreenWidth(context);
    double _corner = Ratioz.ddAppBarCorner;
    BorderRadius _bubbleBorderss = superBorderAll(context, _corner);

    BorderRadius _bubbleBorders =
    myVerse ?
    superBorderRadius(context, _corner, _corner, 0, _corner) :
    superBorderRadius(context, 0, _corner, _corner, _corner) ;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: myVerse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[

        // FutureBuilder(
        //   future: FirebaseFirestore.instance.collection('users').doc(userID).get(), // this should be removed from inside the fucking bubble ya max ya 5ara
        //   builder: (context, snapshot){
        //
        //     if (connectionIsWaiting(snapshot)){
        //       return Loading();
        //     } else {
        //       String _userName = snapshot.data['name'];
        //       return
        //         SuperVerse(
        //           verse: _userName,
        //         );
        //     }
        //
        //
        //   },
        // ),

        Row(
          mainAxisAlignment: myVerse ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              // width: _bubbleWidth,
              margin: EdgeInsets.symmetric(vertical: Ratioz.ddAppBarPadding, horizontal: Ratioz.ddAppBarMargin),
              padding: EdgeInsets.symmetric(vertical: Ratioz.ddAppBarPadding, horizontal: Ratioz.ddAppBarMargin * 2),
              decoration: BoxDecoration(
                borderRadius: _bubbleBorders,
                color: myVerse ? Colorz.BloodTest : Colorz.WhiteAir,

              ),
              child: SuperVerse(
                verse: verse,
                size: 2,
                maxLines: 100,
                centered: false,
                weight: VerseWeight.thin,
              ),
            ),
          ],
        ),

      ],
    );
  }
}
