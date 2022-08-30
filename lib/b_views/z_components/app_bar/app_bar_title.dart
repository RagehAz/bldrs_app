import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarTitle({
    @required this.pageTitle,
    @required this.backButtonIsOn,
    @required this.width,
    @required this.appBarRowWidgets,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pageTitle;
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

    return Center(
        child: pageTitle is String ?
        _HeadlineSuperVerse(
          title: pageTitle,
          width: width,
          appBarRowWidgets: appBarRowWidgets,
          backButtonIsOn: backButtonIsOn,
        )

            :

        pageTitle is ValueNotifier<String> ?
        ValueListenableBuilder(
          valueListenable: pageTitle,
          builder: (_, String title, Widget child){

            return _HeadlineSuperVerse(
              title: title,
              width: width,
              appBarRowWidgets: appBarRowWidgets,
              backButtonIsOn: backButtonIsOn,
            );

            },
        )

            :

        const SizedBox()
    );


  }
}

class _HeadlineSuperVerse extends StatelessWidget {

  const _HeadlineSuperVerse({
    @required this.title,
    @required this.backButtonIsOn,
    @required this.width,
    @required this.appBarRowWidgets,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
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
    else {
      return Container(
        width: width,
        // color: Colorz.bloodTest,
        margin: EdgeInsets.symmetric(
            horizontal: _titleHorizontalMargins
        ),
        child: SuperVerse(
          verse: title.toUpperCase(),
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
}
