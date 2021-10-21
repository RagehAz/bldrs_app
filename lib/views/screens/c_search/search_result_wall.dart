import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bzz_bubble.dart';
import 'package:flutter/material.dart';

class SearchResultWall extends StatelessWidget {
  final List<BzModel> bzzModels;

  const SearchResultWall({
    @required this.bzzModels,
    });

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    return Container(
      width: _screenWidth,
      height: _screenHeight,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[

          if (Mapper.canLoopList(bzzModels))
            ...List.generate(bzzModels.length, (index) =>

                BzzBubble(
                  title: 'title',
                  bzzModels: bzzModels,
                  onTap: (){print('on tapppppp');},
                  numberOfColumns: 3,
                  numberOfRows: 3,
                )

            ),

        ],
      ),
    );
  }
}
