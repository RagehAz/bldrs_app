import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/a_models/x_utilities/keyboard_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/j_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_controller.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_counter_builder.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

class ImageTile extends StatelessWidget {

  const ImageTile({
    @required this.pic,
    @required this.tileWidth,
    @required this.imageSize,
    @required this.text,
    Key key
  }) : super(key: key);

  final dynamic pic;
  final double tileWidth;
  final Dimensions imageSize;
  final String text;

  @override
  Widget build(BuildContext context) {

    if (pic == null){
      return const SizedBox();
    }

    else {

      final double _picHeight = Dimensions.getHeightByAspectRatio(
        width: tileWidth,
        aspectRatio: imageSize.getAspectRatio(),
      );

      return GestureDetector(
        onTap: () => Nav.goToNewScreen(context: context, screen: SlideFullScreen(image: pic, imageSize: imageSize)),
        child: SizedBox(
          width: tileWidth,
          height: _picHeight,
          child: Stack(
            children: <Widget>[

              SuperImage(
                width: tileWidth,
                height: _picHeight,
                pic: pic,
              ),

              SuperVerse(
                width: tileWidth - 10,
                verse: Verse.plain(text),
                margin: 5,
                labelColor: Colorz.black200,
                maxLines: 3,
                size: 1,
              ),

            ],
          ),
        ),
      );

    }
  }

}
