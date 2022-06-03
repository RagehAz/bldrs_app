import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card_details.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_pic.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCard({
    @required this.author,
    @required this.bzModel,
    this.bubbleWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  final BzModel bzModel;
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  static List<FlyerModel> _getNumberOfAuthorFlyers({
    @required AuthorModel author,
    @required BuildContext context,
  }){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final List<FlyerModel> _bzFlyers = _bzzProvider.myActiveBzFlyers;

    final List<FlyerModel> _authorFlyers = FlyerModel.getFlyersFromFlyersByAuthorID(
      flyers: _bzFlyers,
      authorID: author?.userID,
    );

    return _authorFlyers;
  }
// -----------------------------------------------------------------------------
  static const double authorPicSize = 80;
  static const double spaceBetweenImageAndText = 5;
// -----------------------------------------------------------------------------
  static double authorTextDetailsClearWidth({
    @required BuildContext context,
    @required double bubbleWidth,
  }){
    final double _bubbleClearWidth = Bubble.clearWidth(context, bubbleWidthOverride: bubbleWidth);
    final double _bubblePaddingValue = Bubble.paddingValue();
    const double _spaceBetweenImageAndText = spaceBetweenImageAndText;
    const double _imageWidth = authorPicSize;

    final double _clearTextWidth =
        _bubbleClearWidth
            - (2 * _bubblePaddingValue)
            - _spaceBetweenImageAndText
            - _imageWidth
            - 5; // for margin

    return _clearTextWidth;
  }
// -----------------------------------------------------------------------------
  static const double imageCornerValue = 15;
// -----------------------------------------------------------------------------
  static double bubbleCornerValue(){
    return imageCornerValue + Bubble.paddingValue();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<FlyerModel> _authorFlyers = _getNumberOfAuthorFlyers(author: author, context: context);
    final int _authorNumberOfFlyers = _authorFlyers.length;
    final double _textAreaWidth = authorTextDetailsClearWidth(
      context: context,
      bubbleWidth: bubbleWidth,
    );

    return Bubble(
      width: bubbleWidth,
      corners: bubbleCornerValue(),
      columnChildren: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            AuthorPicInBzPage(
              width: authorPicSize,
              authorPic: author.pic,
              cornerOverride: 15,
            ),

            Container(
              width: _textAreaWidth,
              margin: const EdgeInsets.symmetric(horizontal: spaceBetweenImageAndText),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// NAME
                  SuperVerse(
                    verse: author.name,
                    size: 3,
                    maxLines: 2,
                    margin: 5,
                    centered: false,
                  ),

                  /// TITLE
                  SuperVerse(
                    verse: '${author.title} @ ${bzModel.name}',
                    italic: true,
                    weight: VerseWeight.thin,
                    margin: 5,
                    maxLines: 2,
                    centered: false,
                  ),

                  /// SEPARATOR LINE
                  Container(
                    width: _textAreaWidth,
                    height: 0.25,
                    color: Colorz.yellow200,
                    margin: const EdgeInsets.all(5),
                  ),

                  /// NUMBER OF FLYERS
                  AuthorCardDetail(
                    verse: '$_authorNumberOfFlyers published flyers',
                    icon: Iconz.flyer,
                    bubbleWidth: bubbleWidth,
                  ),

                  /// CONTACTS
                  ...List.generate(author.contacts.length, (index){

                    final ContactModel _contact = author.contacts[index];

                    return AuthorCardDetail(
                      icon: ContactModel.getContactIcon(_contact.contactType),
                      verse: _contact.value,
                      bubbleWidth: bubbleWidth,
                    );

                  }),

                ],
              ),
            ),




          ],
        ),

      ],
    );

  }
}


class Thing extends StatelessWidget {

  const Thing({
    @required this.onPressed,
    Key key
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed);
  }
}
