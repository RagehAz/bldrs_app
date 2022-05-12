import 'package:bldrs/b_views/z_components/artworks/bldrs_name_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DashBoardLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DashBoardLayout({
    @required this.listWidgets,
    this.pageTitle,
    this.loading = false,
    this.onBldrsTap,
    this.scrollable = true,
    this.scrollerIsOn = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> listWidgets;
  final String pageTitle;
  final bool loading;
  final Function onBldrsTap;
  final bool scrollable;
  final bool scrollerIsOn;
  /// --------------------------------------------------------------------------
  static double clearScreenHeight(BuildContext context) {
    return Scale.superScreenHeight(context) -
        Ratioz.stratosphere -
        (2 * Ratioz.appBarMargin);
  }

  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout> {

  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return MainLayout(
      // scaffoldKey: _globalKey,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: widget.pageTitle,
      // loading: loading,
      appBarRowWidgets: <Widget>[
        const Expander(),
        BldrsNameButton(
          onTap: widget.onBldrsTap,
        ),
      ],

      layoutWidget: Scroller(
        key: const ValueKey<String>('dashboard_scroller'),
        isOn: widget.scrollerIsOn,
        controller: _controller,
        child: ListView(
          physics: widget.scrollable ?
          const BouncingScrollPhysics()
              :
          const NeverScrollableScrollPhysics(),

          controller: _controller,
          children: <Widget>[

            // const Stratosphere(),

            ...widget.listWidgets,

          ],
        ),
      ),
    );
  }
}
