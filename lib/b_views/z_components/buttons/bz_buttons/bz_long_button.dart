import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/bz_buttons/authors_wrap.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_types_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:flutter/material.dart';

class BzBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzBubble({
    required this.bzModel,
    this.boxWidth,
    this.showID = true,
    this.onTap,
    this.isSelected = false,
    this.showAuthorsPics = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  final double? boxWidth;
  final bool showID;
  final Function? onTap;
  final bool isSelected;
  final bool showAuthorsPics;
  /// --------------------------------------------------------------------------
  static const double height = 60;
  static const double bzButtonMargin = Ratioz.appBarPadding;
  static const double extent = BzBubble.height + bzButtonMargin;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onTap({
    required BuildContext context,
    required BzModel? bzModel,
  }) async {

    if (onTap != null){
      onTap?.call();
    }

    else {

      await Nav.goToNewScreen(
        context: context,
        screen: BzPreviewScreen(
          bzModel: bzModel,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onAuthorTap(AuthorModel author) async {

    await onCallTap(
        bzModel: bzModel?.copyWith(
          authors: [author],
        ),
        flyerModel: null,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.clearWidth(
        context: context,
        bubbleWidthOverride: boxWidth,
    );
    final double _textZoneWidth =  _bubbleWidth - height - 20 - 10;
    final double _teamZoneWidth = _textZoneWidth;

    return Bubble(
      width: _bubbleWidth,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headerWidth: _bubbleWidth - 20,
        textDirection: UiProvider.getAppTextDir(),
      ),
      bubbleColor: isSelected == true ? Colorz.green255 : Colorz.white10,
      onBubbleTap: () => _onTap(
        context: context,
        bzModel: bzModel,
      ),
      columnChildren: <Widget>[

        SizedBox(
          width: _bubbleWidth - 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// LOGO + CONTACTS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// LOGO
                  BldrsBox(
                    height: height,
                    icon: bzModel?.logoPath,
                  ),

                  /// SPACING
                  if (Mapper.checkCanLoopList(bzModel?.contacts) == true)
                  const Spacing(size: 5),

                  /// CONTACTS
                  if (Mapper.checkCanLoopList(bzModel?.contacts) == true)
                  ... List.generate(bzModel!.contacts!.length, (index){

                    final ContactModel _contact = bzModel!.contacts![index];

                    return BldrsBox(
                      height: 25,
                      iconSizeFactor: 0.7,
                      icon: ContactModel.concludeContactIcon(
                          contactType: _contact.type,
                          isPublic: true,
                      ),
                      margins: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 5,
                      ),
                      color: Colorz.white10,
                      corners: 5,
                      onTap: () => Launcher.launchContactModel(contact: _contact),
                    );

                  }),

                ],
              ),

                /// SPACING
              const Spacing(),

              /// INFO
              SizedBox(
                width: _textZoneWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// BZ NAME
                    SizedBox(
                      width: _textZoneWidth,
                      child: BldrsText(
                        verse: Verse(
                          id: bzModel?.name,
                          translate: false,
                        ),
                        centered: false,
                        // margin: const EdgeInsets.symmetric(horizontal: 10),
                        scaleFactor: 1.1,
                        maxLines: 2,
                        textDirection: UiProvider.getAppTextDir(),
                      ),
                    ),

                    const Spacing(size: 5),

                    /// BZ TYPES
                    BzTypesLine(
                      bzModel: bzModel,
                      width: _textZoneWidth,
                      centered: false,
                      oneLine: true,
                    ),

                    /// ZONE
                    if (bzModel?.zone != null)
                      ZoneLine(
                        width: _textZoneWidth,
                        zoneModel: bzModel?.zone,
                        centered: false,
                      ),

                    /// IN BLDRS SINCE
                    BldrsBox(
                      width: _textZoneWidth,
                      height: ZoneLine.flagSize,
                      icon: Iconz.calendar,
                      verse: Verse.plain(BldrsTimers.generateString_in_bldrs_since_month_yyyy(bzModel?.createdAt)),
                      verseWeight: VerseWeight.thin,
                      verseItalic: true,
                      verseColor: ZoneLine.textColor,
                      verseScaleFactor: 1.3,
                      verseMaxLines: 2,
                      bubble: false,
                      verseCentered: false,
                    ),



                    const Spacing(size: 5),

                    /// TEAM
                    Center(
                      child: Container(
                        width: _teamZoneWidth,
                        decoration: const BoxDecoration(
                          color: Colorz.white10,
                          borderRadius: Borderers.constantCornersAll10,
                        ),
                        child: Column(
                          children: <Widget>[

                            const Spacing(size: 5),

                            /// TEAM MEMBERS HEADLINE
                            if (Mapper.checkCanLoopList(bzModel?.authors) == true)
                              BldrsBox(
                                height: 25,
                                width: _teamZoneWidth - 10,
                                verseMaxLines: 3,
                                verse: const Verse(
                                  id: 'phid_team',
                                  translate: true,
                                ),
                                verseItalic: true,
                                verseWeight: VerseWeight.regular,
                                verseColor: Colorz.white80,
                                bubble: false,
                                verseCentered: false,
                                icon: Iconz.bzWhite,
                                iconSizeFactor: 0.9,
                                verseScaleFactor: 1.1 / 0.9,
                                margins: const EdgeInsets.symmetric(horizontal: 5),
                              ),

                            const Spacing(size: 5),

                            /// BZ AUTHORS
                            if (showAuthorsPics == true)
                              AuthorsWrap(
                                boxWidth: _teamZoneWidth - 10,
                                bzModel: bzModel,
                                picSize: 40,
                              ),

                            const Spacing(size: 5),

                          ],
                        )
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
