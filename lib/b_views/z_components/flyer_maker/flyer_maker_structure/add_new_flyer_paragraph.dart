import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AddNewFlyerParagraph extends StatelessWidget {

  const AddNewFlyerParagraph({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.superScreenWidth(context),
      height: Ratioz.appBarSmallHeight,
      padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
      child: const SuperVerse(
        verse: 'Add a flyer',
        centered: false,
      ),
    );
  }

}
