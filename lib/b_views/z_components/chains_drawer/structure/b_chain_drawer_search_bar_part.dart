import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsDrawerSearchBarPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsDrawerSearchBarPart({
    @required this.width,
    @required this.onSearchChanged,
    @required this.onSearchSubmit,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('ChainsDialogSearchBarPart'),
      width: width,
      height: Ratioz.appBarButtonSize,
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin + Ratioz.appBarPadding
      ),

      child: Row(
        children: <Widget>[

          const BackAndSearchButton(
            backAndSearchAction: BackAndSearchAction.goBack,
          ),

          SearchBar(
            height: Ratioz.appBarButtonSize,
            boxWidth: width - 40,
            onSearchSubmit: (String val) => onSearchSubmit(val),
            historyButtonIsOn: false,
            onSearchChanged: (String val) => onSearchChanged(val),
            hintText: superPhrase(context, 'phid_search_keywords'),
          ),

        ],
      ),
    );
  }
}
