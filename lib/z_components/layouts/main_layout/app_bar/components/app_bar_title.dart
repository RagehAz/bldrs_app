// ignore_for_file: unused_element
part of bldrs_app_bar;

class AppBarTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarTitle({
    required this.pageTitleVerse,
    // required this.backButtonIsOn,
    required this.width,
    // required this.appBarRowWidgets,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? pageTitleVerse;
  // final bool backButtonIsOn;
  final double width;
  // final List<Widget> appBarRowWidgets;
  /// --------------------------------------------------------------------------
  static double getTitleHorizontalMargin({
    required bool backButtonIsOn,
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
            // appBarRowWidgets: appBarRowWidgets,
            // backButtonIsOn: backButtonIsOn,
          )

              :

          ValueListenableBuilder(
            valueListenable: pageTitleVerse!.notifier!,
            builder: (_, dynamic value, Widget? child){

              final String? _string = value as String?;

              return _HeadlineSuperVerse(
                title: pageTitleVerse?.copyWith(id: _string),
                width: width,
                // appBarRowWidgets: appBarRowWidgets,
                // backButtonIsOn: backButtonIsOn,
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
    required this.title,
    required this.width,
    // required this.appBarRowWidgets,
    super.
key
  });
  /// --------------------------------------------------------------------------
  final Verse? title;
  final double width;
  // final List<Widget> appBarRowWidgets;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    // if (Lister.checkCanLoop(appBarRowWidgets) == true){
    //   return BldrsText(
    //     verse: title.copyWith(casing: Casing.upperCase),
    //     weight: VerseWeight.black,
    //     color: Colorz.white200,
    //     shadow: true,
    //     italic: true,
    //     // maxLines: 1,
    //     centered: false,
    //     scaleFactor: 0.9,
    //   );
    // }
    //
    // else {
      return BldrsText(
        width: width,
        verse: title?.copyWith(casing: Casing.upperCase),
        weight: VerseWeight.black,
        color: Colorz.white200,
        shadow: true,
        italic: true,
        maxLines: 2,
        centered: false,
        scaleFactor: 0.9,
        textDirection: UiProvider.getAppTextDir(),
      );
    // }

  }
  // --------------------------------------------------------------------------
}
