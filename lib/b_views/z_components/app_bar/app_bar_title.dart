import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarTitle({
    @required this.pageTitleVerse,
    @required this.backButtonIsOn,
    @required this.width,
    @required this.appBarRowWidgets,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse pageTitleVerse;
  final bool backButtonIsOn;
  final double width;
  final List<Widget> appBarRowWidgets;
  /// --------------------------------------------------------------------------
  static double getTitleHorizontalMargin({
    @required bool backButtonIsOn,
  }){
    final double _titleHorizontalMargins = backButtonIsOn == true ? 5 : 15;
    return _titleHorizontalMargins;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (pageTitleVerse == null){
      return const SizedBox();
    }

    else {
      return Center(
          child: pageTitleVerse?.notifier == null ?
          _HeadlineSuperVerse(
            title: pageTitleVerse,
            width: width,
            appBarRowWidgets: appBarRowWidgets,
            backButtonIsOn: backButtonIsOn,
          )

              :

          ValueListenableBuilder(
            valueListenable: pageTitleVerse.notifier,
            builder: (_, String value, Widget child){

              return _HeadlineSuperVerse(
                title: pageTitleVerse.copyWith(id: value),
                width: width,
                appBarRowWidgets: appBarRowWidgets,
                backButtonIsOn: backButtonIsOn,
              );

            },
          ),

      );
    }


  }
  // --------------------------------------------------------------------------
}

class _HeadlineSuperVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _HeadlineSuperVerse({
    @required this.title,
    @required this.backButtonIsOn,
    @required this.width,
    @required this.appBarRowWidgets,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse title;
  final bool backButtonIsOn;
  final double width;
  final List<Widget> appBarRowWidgets;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _titleHorizontalMargins = AppBarTitle.getTitleHorizontalMargin(
      backButtonIsOn: backButtonIsOn,
    );

    if (Mapper.checkCanLoopList(appBarRowWidgets) == true){
      return BldrsText(
        verse: title.copyWith(casing: Casing.upperCase),
        weight: VerseWeight.black,
        color: Colorz.white200,
        margin: 0,
        shadow: true,
        italic: true,
        // maxLines: 1,
        centered: false,
        scaleFactor: 0.9,
      );
    }

    else {
      return Container(
        width: width,
        // color: Colorz.bloodTest,
        margin: EdgeInsets.symmetric(
            horizontal: _titleHorizontalMargins
        ),
        child: BldrsText(
          verse: title.copyWith(casing: Casing.upperCase),
          weight: VerseWeight.black,
          color: Colorz.white200,
          margin: 0,
          shadow: true,
          italic: true,
          maxLines: 2,
          centered: false,
          scaleFactor: 0.9,
        ),
      );
    }

  }
  // --------------------------------------------------------------------------
}
