import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'ab_strip.dart';

class BldrsAppBar extends StatefulWidget {
  final AppBarType appBarType;
  final List<Widget> appBarRowWidgets;
  final String pageTitle;
  final Function switchPages;
  // final PageType currentPage;
  final UserModel userModel;

  BldrsAppBar({
    this.appBarType = AppBarType.Main,
    this.appBarRowWidgets,
    this.pageTitle,
    this.switchPages,
    // this.currentPage,
    this.userModel,
});

  @override
  _BldrsAppBarState createState() => _BldrsAppBarState();
}

class _BldrsAppBarState extends State<BldrsAppBar> {
  AppBarType _appBarType;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _appBarType = widget.appBarType;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _triggerLocalizer(){
    setState(() {
      _appBarType == AppBarType.Localizer ?
      _appBarType = widget.appBarType
          :
      _appBarType = AppBarType.Localizer;
    });
    print('tapping localizer button, appbar is : $_appBarType');
  }
// ---------------------------------------------------------------------------
  void _triggerSections(bool _sectionsAreExpanded){
      _sectionsAreExpanded == true ?
    setState(() {
      _appBarType = AppBarType.Sections;
    })
          :
      setState(() {
        _appBarType = widget.appBarType;
      });
    print('appBarType is : $_appBarType');

  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return

      _appBarType == AppBarType.Main
          || _appBarType == AppBarType.Intro
          || _appBarType == AppBarType.Sections ?
      ABMain(
        tappingLocalizer: _triggerLocalizer,
        currentAppBarType: _appBarType,
        sectionsAreOn: _appBarType == AppBarType.Intro ? false : true,
        searchButtonOn: _appBarType == AppBarType.Intro ? false : true,
        expandingSections: (_sectionsAreExpanded) =>
            _triggerSections(_sectionsAreExpanded),
      )

          :

      //     ABInPyramids(
      //         currentPage: widget.currentPage,
      //         switchingPages: (page){
      //           print(page);
      //           widget.switchPages(page);
      //         },
      //     )
      //
      // :

      _appBarType == AppBarType.Basic
          || _appBarType == AppBarType.Scrollable
          || _appBarType == AppBarType.InPyramids ?
      ABStrip(
        scrollable: _appBarType == AppBarType.Scrollable ? true : false,
        appBarType: _appBarType,
        rowWidgets: (_appBarType == null && widget.pageTitle == null) ? [Container()] :
        <Widget>[

          ... widget.appBarRowWidgets == null ? [Container()] : widget.appBarRowWidgets,

          widget.pageTitle == null ? Container() :
          Center(
            child: SuperVerse(
              verse: widget.pageTitle,
              size: 3,
              margin: 10,
              shadow: true,
            ),),

        ],
      )

          :

      _appBarType == AppBarType.Localizer ?
          ABLocalizer(
            triggerLocalizer: _triggerLocalizer,
          )

          :

      Container()

    ;
  }
}



