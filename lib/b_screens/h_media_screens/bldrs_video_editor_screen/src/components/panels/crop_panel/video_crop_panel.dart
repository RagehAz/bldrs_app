import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_video_editor_screen/src/components/panels/crop_panel/video_aspect_ratio_button.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class VideoCropPanel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoCropPanel({
    required this.onSetAspectRatio,
    required this.onConfirmCrop,
    super.key
  });
  // --------------------
  final Function onConfirmCrop;
  final Function(double? aspectRatio) onSetAspectRatio;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _panelHeight = EditorScale.panelZoneHeight(isOn: true) + EditorScale.subPanelHeight;
    final double _flyerRatio = FlyerDim.flyerAspectRatio();
    // --------------------
    return FloatingList(
      width: _screenWidth,
      height: _panelHeight,
      scrollDirection: Axis.horizontal,
      columnChildren: <Widget>[

        /// FLYER
        VideoAspectRatioButton(
          verse: Verse.plain('Flyer'),
          aspectRatio: _flyerRatio,
          onTap: () => onSetAspectRatio(_flyerRatio),
        ),

        /// SQUARE
        VideoAspectRatioButton(
          verse: Verse.plain('Square'),
          aspectRatio: 1,
          onTap: () => onSetAspectRatio(1),
        ),

        /// FREE
        VideoAspectRatioButton(
          verse: Verse.plain('Free'),
          aspectRatio: null,
          onTap: () => onSetAspectRatio(null),
        ),

        // /// CONFIRM CROP
        // VideoAspectRatioButton(
        //   verse: Verse.plain('Crop'),
        //   aspectRatio: null,
        //   onTap: onConfirmCrop,
        // ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
