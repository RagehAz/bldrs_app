import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/keywords/keyword_button.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class InfoPageKeywords extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageKeywords({
    @required this.flyerModel,
    @required this.pageWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
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

    final List<String> _keywords = [];

    return Wrap(
      key: const ValueKey<String>('InfoPageKeywords'),
      children: <Widget>[
        ...List<Widget>.generate(_keywords?.length, (int index) {

          final String _keyword = _keywords[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
            child: KeywordBarButton(
              keywordID: _keyword,
              xIsOn: false,
              color: Colorz.white50,
            ),
          );
        }),
      ],
    );
  }
}
