import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarTitle({
    @required this.pageTitle,
    @required this.backButtonIsOn,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pageTitle;
  final bool backButtonIsOn;
  final double width;
  /// --------------------------------------------------------------------------
  Widget _titleSuperVerse(String title){

    return SuperVerse(
      verse: title.toUpperCase(),
      weight: VerseWeight.black,
      color: Colorz.white200,
      margin: 0,
      shadow: true,
      italic: true,
      maxLines: 2,
      centered: false,
      scaleFactor: 0.9,
    );

  }
  // --------------------------------------------------------------------------
  static double getTitleHorizontalMargin({
    @required bool backButtonIsOn,
  }){
    final double _titleHorizontalMargins = backButtonIsOn == true ? 5 : 15;
    return _titleHorizontalMargins;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _titleHorizontalMargins = getTitleHorizontalMargin(
      backButtonIsOn: backButtonIsOn,
    );

    return Center(
        child: Container(
          width: width,
          // color: Colorz.bloodTest,
          margin: EdgeInsets.symmetric(
              horizontal: _titleHorizontalMargins
          ),
          child:

          pageTitle is String ?
          _titleSuperVerse(pageTitle)

              :

          pageTitle is ValueNotifier<String> ?
          ValueListenableBuilder(
            valueListenable: pageTitle,
            builder: (_, String title, Widget child){

              return _titleSuperVerse(title);

              },
          )

              :

          const SizedBox(),

        )
    );


  }
}
