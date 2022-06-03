import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:flutter/material.dart';

class AuthorCardDetail extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCardDetail({
    @required this.icon,
    @required this.verse,
    @required this.bubbleWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final String verse;
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 30,
      width: AuthorCard.authorTextDetailsClearWidth(
        context: context,
        bubbleWidth: bubbleWidth,
      ),
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
