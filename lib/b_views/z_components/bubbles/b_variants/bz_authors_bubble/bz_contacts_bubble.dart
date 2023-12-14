import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/bz_buttons/contact_button.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:flutter/material.dart';

class BzContactsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzContactsBubble({
    required this.width,
    required this.bzModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final BzModel? bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = width;
    // --------------------
    final double _textAreaBoxWidth = AuthorCard.authorTextDetailsClearWidth(
        context: context,
        bubbleWidth: _bubbleWidth,
        withMoreButton: true
    );
    // --------------------
    final double _textAreaWidth = _textAreaBoxWidth - 20;
    // --------------------

    final double _bodyWidth = _bubbleWidth - AuthorCard.authorPicSize - 40;
    // --------------------
    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
      width: _bubbleWidth,
      corners: AuthorCard.bubbleCornerValue(),
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      columnChildren: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// PICTURE
            BzLogo(
              width: AuthorCard.authorPicSize,
              isVerified: bzModel?.isVerified,
              image: bzModel?.logoPath,
              corners: Borderers.constantCornersAll15, // 15
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
                    height: AuthorCard.authorPicSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        const Expander(),

                        /// NAME
                        BldrsText(
                          width: _textAreaWidth,
                          verse: Verse(
                            id: bzModel?.name ?? '...',
                            translate: false,
                          ),
                          size: 3,
                          centered: false,
                          scaleFactor: 0.9,
                        ),

                        // /// TITLE
                        // BldrsText(
                        //   width: _textAreaWidth,
                        //   verse: getAuthorTitleLine(
                        //     title: author.title,
                        //     companyName: bzModel?.name,
                        //   ),
                        //   italic: true,
                        //   weight: VerseWeight.thin,
                        //   maxLines: 2,
                        //   centered: false,
                        //   scaleFactor: 0.8,
                        // ),

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

            // if (Mapper.boolIsTrue(moreButtonIsOn) == true)
            //   BldrsBox(
            //     width: moreButtonSize,
            //     height: moreButtonSize,
            //     icon: Iconz.more,
            //     iconSizeFactor: 0.6,
            //     onTap: () => onAuthorOptionsTap(
            //       context: context,
            //       oldBz: bzModel,
            //       authorModel: author,
            //     ),
            //   ),


          ],
        ),

        Container(
          width: _bubbleWidth,
          padding: Scale.superInsets(
            context: context,
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enLeft: AuthorCard.authorPicSize,
          ),
          child: Column(
            children: <Widget>[

              /// CONTACTS
              if (Lister.checkCanLoop(bzModel?.contacts) == true)
              ...List.generate(bzModel!.contacts!.length, (index){

                final ContactModel _contact = bzModel!.contacts![index];

                return ContactButton(
                  contactModel: _contact,
                  width: _bodyWidth,
                  height: 40,
                  forceShowVerse: true,
                  margins: const EdgeInsets.only(top: 5),
                  isPublic: true,
                  onTap: () => Launcher.launchContactModel(
                    contact: _contact,
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
  /// --------------------------------------------------------------------------
}
