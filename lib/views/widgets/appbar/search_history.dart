import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> _words = <String>['Changel', 'Chandelier', 'Ebony wood', 'Sofa bed', 'Architectural design'];

    double _abWidth = Scale.appBarClearWidth(context);
    double _abHeight = Scale.appBarClearHeight(context, AppBarType.Search);
    double _blurValue = Ratioz.blur1;

    double _spacing = superVerseLabelMargin(context, 3, 1, true);

    return Container(
      width: _abWidth,
      // height: _abHeight,
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
        boxShadow: Shadowz.appBarShadow,
      ),
      child: Stack(
        alignment: Aligners.superCenterAlignment(context),
        children: <Widget>[

          /// --- APPBAR BLUR
          // BlurLayer(
          //   width: _abWidth,
          //   // height: Ratio,
          //   blur: _blurValue,
          //   borders: BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
          // ),
          
          // Expanded(child: Container()),

          Container(
            width: _abWidth,
            // height: _abHeight,
            padding: EdgeInsets.all(Ratioz.appBarMargin),
            child: Wrap(
              // spacing: ,
              children: <Widget>[

                DreamBox(
                  height: superVerseRealHeight(context, 3, 1, Colorz.BlackSmoke),
                  width: superVerseRealHeight(context, 3, 1, Colorz.BlackSmoke),
                  color: Colorz.BlackSmoke,
                  icon: Iconz.Clock,
                  iconSizeFactor: 0.6,
                  bubble: false,
                  boxMargins: EdgeInsets.all(_spacing),
                ),

                ...List<Widget>.generate(
                    _words.length,
                        (index){

                      return
                        // SuperVerse(
                        //   shadow: false,
                        //   size: 3,
                        //   designMode: false,
                        // );

                        DreamBox(
                          height: superVerseRealHeight(context, 3, 1, Colorz.BlackSmoke),
                          verse: _words[index],
                          verseItalic: true,
                          verseWeight: VerseWeight.thin,
                          verseScaleFactor: 1.7,
                          bubble: false,
                          icon: Iconz.XLarge,
                          iconSizeFactor: 0.4,
                          color: Colorz.BlackSmoke,
                          boxMargins: EdgeInsets.all(_spacing),
                          boxFunction: (){
                            print(_words[index]);
                          },
                        );

                    }
                ),

              ],
            ),
          ),


        ],

      ),
    );
  }
}
