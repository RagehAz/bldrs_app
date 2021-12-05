import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String verse;
  final bool isMyVerse;
  final String userID;

  const ChatBubble({
    @required this.verse,
    @required this.isMyVerse,
    @required this.userID,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // double _bubbleWidth = Scale.superScreenWidth(context);
    const double _corner = Ratioz.appBarCorner;
    // BorderRadius _bubbleBorderss = Borderers.superBorderAll(context, _corner);

    final BorderRadius _bubbleBorders = isMyVerse ?
    Borderers.superBorderOnly(context: context, enTopLeft: _corner, enBottomLeft: _corner, enBottomRight: 0, enTopRight: _corner)
        :
    Borderers.superBorderOnly(context: context, enTopLeft: 0, enBottomLeft: _corner, enBottomRight: _corner, enTopRight: _corner) ;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMyVerse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
          mainAxisAlignment: isMyVerse ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              // width: _bubbleWidth,
              margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: Ratioz.appBarMargin),
              padding: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: Ratioz.appBarMargin * 2),
              decoration: BoxDecoration(
                borderRadius: _bubbleBorders,
                color: isMyVerse ? Colorz.bloodTest : Colorz.white10,

              ),
              child: SuperVerse(
                verse: verse,
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
