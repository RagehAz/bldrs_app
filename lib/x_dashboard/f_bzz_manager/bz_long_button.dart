import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/fff_author_label.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_types_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzLongButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLongButton({
    @required this.bzModel,
    this.boxWidth,
    this.showID = true,
    this.onTap,
    this.isSelected = false,
    this.showAuthorsPics = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double boxWidth;
  final bool showID;
  final Function onTap;
  final bool isSelected;
  final bool showAuthorsPics;
  /// --------------------------------------------------------------------------
  static const double height = 60;
  static const double bzButtonMargin = Ratioz.appBarPadding;
  static const double extent = BzLongButton.height + bzButtonMargin;
  // --------------------
  Future<void> _onTap({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    if (onTap != null){
      onTap();
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.clearWidth(context, bubbleWidthOverride: boxWidth);
    final double _textZoneWidth =  _bubbleWidth - height - 20;

    return Bubble(
      width: _bubbleWidth,
      headerViewModel: BubbleHeaderVM(
        headerWidth: _bubbleWidth - 20,
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
              DreamBox(
                height: height,
                icon: bzModel?.logo,
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
                      child: SuperVerse(
                        verse: Verse(
                          text: bzModel?.name,
                          translate: false,
                        ),
                        centered: false,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        size: 3,
                        maxLines: 2,
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

                    /// BZ AUTHORS
                    if (showAuthorsPics == true)
                      Container(
                        width: _textZoneWidth,
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                        ),
                        decoration: const BoxDecoration(
                          color: Colorz.white10,
                          borderRadius: Borderers.constantCornersAll10,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              if (Mapper.checkCanLoopList(bzModel?.authors) == true)
                                SuperVerse(
                                verse: Verse.plain('${bzModel.authors.length} Authors in ${bzModel.name} '),
                                margin: 5,
                                italic: true,
                                weight: VerseWeight.black,
                                color: Colorz.white80,
                              ),

                              if (Mapper.checkCanLoopList(bzModel?.authors) == true)
                              ...List.generate( bzModel?.authors?.length, (index){

                                // final AuthorModel _author = bzModel.authors[index];
                                final AuthorModel _author = bzModel.authors[0];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: AuthorLabel(
                                    flyerBoxWidth: _textZoneWidth * 1.5,
                                    authorID: _author.userID,
                                    bzModel: bzModel,
                                    showLabel: true,
                                    labelIsOn: true,
                                    authorGalleryCount: _author.flyersIDs.length,
                                    onTap: null,
                                  ),
                                );

                              }),

                            ],
                          ),
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
