import 'dart:io';

import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/super_video_player/a_super_video_player.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoPlayerScreen({
    this.file,
    this.url,
    super.key
  });
  // --------------------
  final File? file;
  final String? url;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playFile({
    required File? file,
  }) async {

    if (file != null){
      await BldrsNav.goToNewScreen(
          screen: VideoPlayerScreen(file: file),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playURL({
    required String? url,
  }) async {

    if (url != null){
      await BldrsNav.goToNewScreen(
        screen: VideoPlayerScreen(url: url),
      );
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidType: PyramidType.crystalWhite,
      title: const Verse(
        id: '',
        translate: false,
      ),
      // appBarRowWidgets: <Widget>[
      //
      //   const Expander(),
      //
      //   AppBarButton(
      //     verse: Verse.plain(''),
      //   ),
      //
      // ],
      child: FloatingList(
        physics: const NeverScrollableScrollPhysics(),
        columnChildren: <Widget>[

          SuperVideoPlayer(
            width: Scale.screenWidth(context),
            file: file,
            autoPlay: true,
            loop: true,
            url: url,
            // asset: ,
            errorIcon: Iconz.yellowAlert,
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
