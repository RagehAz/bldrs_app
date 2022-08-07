import 'package:bldrs/b_views/z_components/chains_drawer/parts/d_phid_button.dart';
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

    /// TASK : SHOULD UN COMMENT THESE AND MANAGE EMPTY VALUES
    // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
    // final List<KW> _allKeywords = _keywordsProvider.allKeywords;
    // final List<KW> _keywords = KW.getKeywordsFromKeywordsByIDs(
    //     sourceKWs: _allKeywords,
    //     keywordsIDs: flyerModel.keywordsIDs,
    // );


    return Wrap(
      key: const ValueKey<String>('InfoPageKeywords'),
      children: <Widget>[

        if (keywordsIDs?.isNotEmpty)
        ...List<Widget>.generate(keywordsIDs?.length, (int index) {

          final String _keywordID = keywordsIDs[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
            child: PhidButton(
              phid: _keywordID,
              color: Colorz.white50,
            ),
          );
        }
        ),

      ],
    );
  }
}
