import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class KeywordsPage extends StatelessWidget {
  final List<Keyword> keywords;
  final Function onTap;
  final List<Keyword> selectedKeywords;

  KeywordsPage({
    Key key,
    @required this.keywords,
    @required this.onTap,
    @required this.selectedKeywords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      // height: 20,
      // color: _colors[pageIndex],
      child: ListView.builder(
          itemCount: keywords.length,
          padding: const EdgeInsets.all(Ratioz.appBarMargin),
          itemBuilder: (context, keyIndex){

            Keyword _keyword = keywords[keyIndex];

            Color _color = selectedKeywords.contains(_keyword) ? Colorz.Yellow225 : Colorz.Nothing;

            bool _isIconlessKeyword = Keyword.isIconless(_keyword);

            return
              Align(
                alignment: Alignment.center,
                child: DreamBox(
                  height: 100,
                  width: Scale.superScreenWidth(context) * 0.82,
                  color: _color,
                  icon: _isIconlessKeyword ? null : Keyword.getImagePath(_keyword.keywordID),
                  margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                  verse: _keyword.keywordID,
                  onTap: () => onTap(_keyword),
                ),
              );
          }
      ),
    );
  }
}
