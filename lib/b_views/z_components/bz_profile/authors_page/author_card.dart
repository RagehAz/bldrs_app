import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/contact_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card_details.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class AuthorCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCard({
    required this.author,
    required this.bzModel,
    required this.bubbleWidth,
    this.onContactTap,
    this.moreButtonIsOn = true,
    super.key
  });
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
    required BuildContext context,
    required double bubbleWidth,
    required bool withMoreButton,
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
    required String title,
    required String companyName
  }){
    return Verse(
      id: '$title @ $companyName',
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------
  Future<void> _onContactTap({
    required ContactModel contactModel,
  }) async {

    if (onContactTap != null){
      onContactTap(contactModel);
    }

    await Launcher.launchContactModel(
      contact: contactModel,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = bubbleWidth ?? Bubble.bubbleWidth(context: context);
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
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
      width: _bubbleWidth,
      corners: bubbleCornerValue(),
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      columnChildren: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// PICTURE
            AuthorPic(
              size: authorPicSize,
              authorPic: author.picPath,
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
                        BldrsText(
                          verse: Verse(
                            id: author.name ?? '...',
                            translate: false,
                          ),
                          size: 3,
                          centered: false,
                        ),

                        /// TITLE
                        BldrsText(
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
              BldrsBox(
                width: moreButtonSize,
                height: moreButtonSize,
                icon: Iconz.more,
                iconSizeFactor: 0.6,
                onTap: () => onAuthorOptionsTap(
                  context: context,
                  oldBz: bzModel,
                  authorModel: author,
                ),
              ),


          ],
        ),

        Container(
          width: _bubbleWidth,
          padding: Scale.superInsets(
            context: context,
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enLeft: authorPicSize,
          ),
          child: Column(
            children: <Widget>[

              /// ROLE
              AuthorCardDetail(
                verse: Verse(
                  id: _rolePhid,
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
                  id: '${author.flyersIDs.length} ${xPhrase('phid_published_flyers')}',
                  translate: false,
                ),
                bubble: false,
                icon: Iconz.flyer,
                boxWidth: _bubbleWidth - authorPicSize - 40,
              ),

              /// CONTACTS
              ...List.generate(author.contacts.length, (index){

                final ContactModel _contact = author.contacts[index];

                return ContactButton(
                    contactModel: _contact,
                    width: _bubbleWidth - authorPicSize - 40,
                    forceShowVerse: true,
                    margins: const EdgeInsets.only(top: 5),
                    onTap: () => _onContactTap(
                      contactModel: _contact,
                    ),
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
