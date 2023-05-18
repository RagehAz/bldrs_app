import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SearchFilterBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchFilterBox({
    @required this.children,
    Key key
  }) : super(key: key);
  // --------------------
  final List<Widget> children;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: Ratioz.appBarPadding,
        right: Ratioz.appBarPadding,
        bottom: Ratioz.horizon,
        top: Ratioz.appBarPadding,
      ),
      children: children,
    );

  }
  // -----------------------------------------------------------------------------
}