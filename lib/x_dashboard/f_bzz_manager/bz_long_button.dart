import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_types_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double boxWidth;
  final bool showID;
  final Function onTap;
  final bool isSelected;
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
    final double _textZoneWidth =  _bubbleWidth - height;

    return Bubble(
      headerViewModel: const BubbleHeaderVM(),
      onBubbleTap: () => _onTap(
        context: context,
        bzModel: bzModel,
      ),
      columnChildren: <Widget>[

        SizedBox(
          width: _bubbleWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// LOGO
              DreamBox(
                height: height,
                icon: bzModel.logo,
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
                          text: bzModel.name,
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
                        zoneModel: bzModel?.zone,
                        centered: false,
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
