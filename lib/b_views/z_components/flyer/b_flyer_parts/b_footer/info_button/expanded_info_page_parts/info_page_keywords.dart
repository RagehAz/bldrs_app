import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/c_phid_button.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class InfoPageKeywords extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageKeywords({
    @required this.keywordsIDs,
    @required this.pageWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> keywordsIDs;
  final double pageWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Wrap(
        key: const ValueKey<String>('InfoPageKeywords'),
        runSpacing: Ratioz.appBarPadding,
        spacing: Ratioz.appBarPadding,
        // direction: Axis.vertical,
        // verticalDirection: VerticalDirection.down,
        // alignment: WrapAlignment.center,
        // crossAxisAlignment: WrapCrossAlignment.center,
        // runAlignment: WrapAlignment.center,
        // alignment: WrapAlignment.spaceAround,
        children: <Widget>[

          if (keywordsIDs?.isNotEmpty)
          ...List<Widget>.generate(keywordsIDs?.length, (int index) {

            final String _keywordID = keywordsIDs[index];

            return PhidButton(
              phid: _keywordID,
              color: Colorz.white50,
              inverseAlignment: false,
            );
          }
          ),

        ],
      ),
    );
  }
}
