import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class InPyramidsBubble extends StatelessWidget {
final List<Widget> columnChildren;
final bool centered;
final Color bubbleColor;

  InPyramidsBubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.WhiteAir,
});

  @override
  Widget build(BuildContext context) {

    double pageMargin = Ratioz.ddAppBarMargin ;

    return Container(
      width: superBubbleClearWidth(context) + 2*pageMargin,
      margin: EdgeInsets.only(right: pageMargin, left: pageMargin, bottom: pageMargin),
      padding: EdgeInsets.all(pageMargin),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(Ratioz.ddAppBarCorner),
      ),
      alignment: centered == true ? Alignment.center :
      getTranslated(context, 'Text_Direction') == 'ltr' ?
      Alignment.centerLeft : Alignment.centerRight,

      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: centered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}

class BubblesSeparator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
          width: screenWidth,
          height: 15,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colorz.GreySmoke,
            ),
          ),
        );
  }
}

class BubbleTitle extends StatelessWidget {
  final String verse;

  BubbleTitle({
    @required this.verse,
});
  @override
  Widget build(BuildContext context) {

    double spacings = 10;

    return Padding(
      padding: EdgeInsets.only(bottom: spacings),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacings * 0.5),
                  child: SuperVerse(
                    verse: verse,
                    size: 2,
                    scaleFactor: 0.85,
                    maxLines: 2,
                    centered: false,

                  ),
                ),
              ),

              Container(
                width: spacings,
                height: 30,
              ),

              DreamBox(
                height: 30,
                icon: Iconz.Plus,
                iconSizeFactor: 0.6,
                verse: 'Add',
                boxFunction: (){Navigator.pushNamed(context, Routez.AddBz);},
              )

            ],
          ),
    );
  }
}


