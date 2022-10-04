import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card_details.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x3_bz_authors_page_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCard({
    @required this.author,
    @required this.bzModel,
    @required this.bubbleWidth,
    this.onContactTap,
    this.moreButtonIsOn = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  final BzModel bzModel;
  final double bubbleWidth;
  final ValueChanged<ContactModel> onContactTap;
  final bool moreButtonIsOn;
  // --------------------
  static const double authorPicSize = 80;
  static const double spaceBetweenImageAndText = 5;
  static const double moreButtonSize = 40;
  // --------------------
  static double authorTextDetailsClearWidth({
    @required BuildContext context,
    @required double bubbleWidth,
    @required bool withMoreButton,
  }){

    final double _bubbleClearWidth = bubbleWidth - 20;
    // final double _bubblePaddingValue = Bubble.paddingValue() * 0;
    // const double _spaceBetweenImageAndText = spaceBetweenImageAndText;

    final double _moreButtonSize = withMoreButton == true ? moreButtonSize : 0;

    final double _clearTextWidth =
        _bubbleClearWidth
            // - (2 * _bubblePaddingValue)
            // - _spaceBetweenImageAndText
            - authorPicSize
            - _moreButtonSize
    ; // for margin

    return _clearTextWidth;
  }
  // --------------------
  static const double imageCornerValue = 15;
  // --------------------
  static double bubbleCornerValue(){
    return imageCornerValue + Bubble.paddingValue();
  }
  // --------------------
  static Verse getAuthorTitleLine({
    @required String title,
    @required String companyName
  }){
    return Verse(
      text: '$title @ $companyName',
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = bubbleWidth ?? BldrsAppBar.width(context);
    // --------------------
    final double _textAreaBoxWidth = authorTextDetailsClearWidth(
        context: context,
        bubbleWidth: _bubbleWidth,
        withMoreButton: true
    );
    // --------------------
    final double _textAreaWidth = _textAreaBoxWidth - 20;
    // --------------------
    final bool _authorIsMaster = AuthorModel.checkUserIsCreatorAuthor(
      userID: author.userID,
      bzModel: bzModel,
    );
    // --------------------
    final String _rolePhid = AuthorModel.getAuthorRolePhid(
      context: context,
      role: author.role,
    );
    // --------------------
    final Color _roleIconColor = _authorIsMaster == true ? null : Colorz.white255;
    // --------------------
    return Bubble(
      headerViewModel: const BubbleHeaderVM(),
      width: _bubbleWidth,
      corners: bubbleCornerValue(),
      margins: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      columnChildren: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// PICTURE
            AuthorPic(
              size: authorPicSize,
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
                          verse: Verse(
                            text: author.name ?? '...',
                            translate: false,
                          ),
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

                ],
              ),
            ),

            if (moreButtonIsOn == true)
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

        Container(
          width: _bubbleWidth,
          padding: Scale.superInsets(context: context, enLeft: authorPicSize),
          child: Column(
            children: <Widget>[

              /// ROLE
              AuthorCardDetail(
                verse: Verse(
                  text: _rolePhid,
                  translate: true,
                ),
                bubble: false,
                icon: Iconz.bz,
                iconColor: _roleIconColor,
                boxWidth: _bubbleWidth - authorPicSize - 40,
              ),

              /// NUMBER OF FLYERS
              AuthorCardDetail(
                verse: Verse(
                  text: '${author.flyersIDs.length} ${xPhrase(context, 'phid_published_flyers')}',
                  translate: false,
                ),
                bubble: false,
                icon: Iconz.flyer,
                boxWidth: _bubbleWidth - authorPicSize - 40,
              ),

              /// CONTACTS
              ...List.generate(author.contacts.length, (index){

                final ContactModel _contact = author.contacts[index];

                return AuthorCardDetail(
                    icon: ContactModel.concludeContactIcon(_contact.type),
                    bubble: true,
                    verse: Verse(
                      text: _contact.value,
                      translate: false,
                    ),
                    boxWidth: _bubbleWidth - authorPicSize - 40,
                    onTap: () async {

                      if (onContactTap != null){
                        onContactTap(_contact);
                      }

                      await Launcher.launchContactModel(
                        context: context,
                        contact: _contact,
                      );

                    }
                );

              }),

            ],
          ),
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
