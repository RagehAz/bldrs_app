import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarTitle({
    @required this.pageTitle,
    @required this.backButtonIsOn,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pageTitle;
  final bool backButtonIsOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _titleHorizontalMargins = backButtonIsOn == true ? 5 : 15;

    return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _titleHorizontalMargins
          ),
          child:

          pageTitle is String ?
          SuperVerse(
            verse: pageTitle.toUpperCase(),
            weight: VerseWeight.black,
            color: Colorz.white200,
            margin: 0,
            shadow: true,
            italic: true,
            maxLines: 2,
            centered: false,
          )

              :

          pageTitle is ValueNotifier<String> ?
          ValueListenableBuilder(
            valueListenable: pageTitle,
            builder: (_, String title, Widget child){

              return SuperVerse(
                verse: title.toUpperCase(),
                weight: VerseWeight.black,
                color: Colorz.white200,
                margin: 0,
                shadow: true,
                italic: true,
                maxLines: 2,
                centered: false,
              );

              },
          )

              :

          const SizedBox(),

        )
    );


  }
}
