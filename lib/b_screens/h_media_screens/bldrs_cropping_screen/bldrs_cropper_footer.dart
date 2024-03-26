import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_nab_button/editor_nav_button.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BldrsCropperFooter extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const BldrsCropperFooter({
    required this.onCropImages,
    required this.loading,
    required this.onBack,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Function onCropImages;
  final ValueNotifier<bool> loading;
  final Function onBack;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _navZoneHeight = EditorScale.navZoneHeight();
    final double _navButtonSize = EditorScale.navButtonSize();
    // --------------------
    return FloatingList(
      width: _screenWidth,
      height: _navZoneHeight,
      scrollDirection: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
        columnChildren: <Widget>[

          /// BACK
          EditorNavButton(
            size: _navButtonSize,
            icon: Iconz.exit,
            verse: const Verse(id: 'phid_exit', translate: true),
            onTap: onBack,
          ),

          /// SPACER
          SizedBox(
            width: _navButtonSize * 2,
            height: _navButtonSize,
          ),

          /// CROP
          ValueListenableBuilder(
              valueListenable: loading,
              builder: (_, bool loading, Widget? child) {

                return EditorNavButton(
                  size: _navButtonSize,
                  verse: const Verse(id: 'phid_crop', translate: true),
                  onTap: onCropImages,
                  icon: Iconz.check,
                  isDisabled: loading,
                  loading: loading,
                );
              }
          ),

        ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
