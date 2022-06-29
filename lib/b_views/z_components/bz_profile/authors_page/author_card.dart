import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card_details.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_pic.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/aaa3_bz_authors_page_controllers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

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
  static const double authorPicSize = 80;
  static const double spaceBetweenImageAndText = 5;
  static const double moreButtonSize = 40;
// -----------------------------------------------------------------------------
  static double authorTextDetailsClearWidth({
    @required BuildContext context,
    @required double bubbleWidth,
  }){

    final double _bubbleClearWidth = Bubble.clearWidth(context, bubbleWidthOverride: bubbleWidth);
    // final double _bubblePaddingValue = Bubble.paddingValue() * 0;
    // const double _spaceBetweenImageAndText = spaceBetweenImageAndText;

    final double _clearTextWidth =
        _bubbleClearWidth
            // - (2 * _bubblePaddingValue)
            // - _spaceBetweenImageAndText
            - authorPicSize
            - moreButtonSize
            ; // for margin

    return _clearTextWidth;
  }
// -----------------------------------------------------------------------------
  static const double imageCornerValue = 15;
// -----------------------------------------------------------------------------
  static double bubbleCornerValue(){
    return imageCornerValue + Bubble.paddingValue();
  }
// -----------------------------------------------------------------------------
  static String getAuthorTitleLine({
    @required String title,
    @required String companyName
  }){
    return '$title @ $companyName';
  }

// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _textAreaBoxWidth = authorTextDetailsClearWidth(
      context: context,
      bubbleWidth: bubbleWidth,
    );
    final double _textAreaWidth = _textAreaBoxWidth - 20;

    final bool _authorIsMaster = AuthorModel.checkUserIsCreatorAuthor(
      userID: author.userID,
      bzModel: bzModel,
    );

    final String _role = AuthorModel.translateRole(
      context: context,
      role: author.role,
    );

    final Color _roleIconColor = _authorIsMaster == true ? null : Colorz.white255;

    return Bubble(
      width: bubbleWidth,
      corners: bubbleCornerValue(),
      margins: Scale.superInsets(context: context, bottom: 10, enLeft: 10, enRight: 10),
      columnChildren: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// PICTURE
            AuthorPicInBzPage(
              width: authorPicSize,
              authorPic: author.pic,
              cornerOverride: 15,
            ),

            /// BODY ( NAME - TITLE - LINE - ROLE - FLYERS COUNT - CONTACTS )
            Container(
              width: _textAreaBoxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// AUTHOR NAME - TITLE - SEPARATOR LINE
                  SizedBox(
                    width: _textAreaWidth,
                    height: authorPicSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        const Expander(),

                        /// NAME
                        SuperVerse(
                          verse: author.name,
                          size: 3,
                          centered: false,
                        ),

                        /// TITLE
                        SuperVerse(
                          verse: getAuthorTitleLine(
                            title: author.title,
                            companyName: bzModel.name,
                          ),
                          italic: true,
                          weight: VerseWeight.thin,
                          maxLines: 2,
                          centered: false,
                        ),

                        const Expander(),

                        /// SEPARATOR LINE
                        Container(
                          width: _textAreaWidth,
                          height: 0.25,
                          color: Colorz.yellow200,
                          // margin: const EdgeInsets.all(5),
                        ),

                      ],
                    ),
                  ),

                  /// Role
                  AuthorCardDetail(
                    verse: _role,
                    icon: Iconz.bz,
                    iconColor: _roleIconColor,
                    boxWidth: _textAreaWidth,
                  ),

                  /// NUMBER OF FLYERS
                  AuthorCardDetail(
                    verse: '${author.flyersIDs.length} published flyers',
                    icon: Iconz.flyer,
                    boxWidth: _textAreaWidth,
                  ),

                  /// CONTACTS
                  ...List.generate(author.contacts.length, (index){

                    final ContactModel _contact = author.contacts[index];

                    return AuthorCardDetail(
                      icon: ContactModel.getContactIcon(_contact.contactType),
                      verse: _contact.value,
                      boxWidth: _textAreaWidth,
                    );

                  }),

                ],
              ),
            ),

            DreamBox(
              width: moreButtonSize,
              height: moreButtonSize,
              icon: Iconz.more,
              iconSizeFactor: 0.6,
              onTap: () => onAuthorOptionsTap(
                context: context,
                bzModel: bzModel,
                authorModel: author,
              ),
            ),


          ],
        ),

      ],
    );

  }
}
