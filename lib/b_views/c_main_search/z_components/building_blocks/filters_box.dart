import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:flutter/material.dart';

class SearchFilterBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchFilterBox({
    required this.children,
    super.key
  });
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
