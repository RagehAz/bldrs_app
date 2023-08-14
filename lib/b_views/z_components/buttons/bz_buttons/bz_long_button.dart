import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
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
import 'package:flutter/material.dart';

class BzLongButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLongButton({
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
  static const double extent = BzLongButton.height + bzButtonMargin;
  // --------------------
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

    final double _textZoneWidth =  _bubbleWidth - height - 20;

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

              /// LOGO
              BldrsBox(
                height: height,
                icon: bzModel?.logoPath,
              ),

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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        size: 3,
                        maxLines: 2,
                        textDirection: UiProvider.getAppTextDir(),
                      ),
                    ),

                    /// BZ TYPES
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: BzTypesLine(
                        bzModel: bzModel,
                        width: _textZoneWidth,
                        centered: false,
                        oneLine: true,
                      ),
                    ),

                    /// ZONE
                    if (bzModel?.zone != null)
                      ZoneLine(
                        width: _textZoneWidth,
                        zoneModel: bzModel?.zone,
                        centered: false,
                      ),

                    if (Mapper.checkCanLoopList(bzModel?.authors) == true)
                      BldrsText(
                        width: _textZoneWidth,
                        maxLines: 3,
                        verse: const Verse(
                          id: 'phid_team',
                          translate: true,
                        ),
                        margin: 5,
                        italic: true,
                        weight: VerseWeight.black,
                        color: Colorz.white80,
                        centered: false,
                      ),

                    /// BZ AUTHORS
                    if (showAuthorsPics == true)
                      AuthorsWrap(
                        boxWidth: _textZoneWidth,
                        bzModel: bzModel,
                      ),

                      // Container(
                      //   width: _textZoneWidth,
                      //   // constraints: const BoxConstraints(
                      //   //   maxHeight: 200,
                      //   // ),
                      //   decoration: const BoxDecoration(
                      //     // color: Colorz.white10,
                      //     borderRadius: Borderers.constantCornersAll10,
                      //   ),
                      //   child: Wrap(
                      //     // crossAxisAlignment: CrossAxisAlignment.start,
                      //     runSpacing: 10,
                      //     spacing: 10,
                      //     children: <Widget>[
                      //
                      //
                      //       if (Mapper.checkCanLoopList(bzModel?.authors) == true)
                      //       ...List.generate( bzModel!.authors!.length, (index){
                      //
                      //         final AuthorModel _author = bzModel!.authors![index];
                      //
                      //         return AuthorLabel(
                      //           flyerBoxWidth: _textZoneWidth * 0.75,
                      //           authorID: _author.userID,
                      //           bzModel: bzModel,
                      //           showLabel: true,
                      //           labelIsOn: true,
                      //           onLabelTap: () => onAuthorTap(_author),
                      //         );
                      //
                      //       }),
                      //
                      //     ],
                      //   ),
                      // ),

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