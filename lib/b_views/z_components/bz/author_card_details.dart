import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/bz/author_card.dart';
import 'package:flutter/material.dart';

class AuthorCardDetail extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCardDetail({
    @required this.icon,
    @required this.verse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final String verse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 30,
      width: AuthorCard.authorTextDetailsClearWidth(context: context),
      icon: icon,
      verse: verse,
      iconSizeFactor: 0.7,
      bubble: false,
      verseWeight: VerseWeight.thin,
      verseShadow: false,
      verseCentered: false,
    );

  }
}
