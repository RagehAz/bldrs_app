import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:super_image/super_image.dart';
import 'package:bldrs/b_views/z_components/poster/poster_display.dart';
import 'package:bldrs/b_views/z_components/poster/structure/poster_switcher.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

/*

    setNotifier(
        notifier: notifier,
        mounted: mounted,
        value: value
    );

 */

class FlyerPosterCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerPosterCreatorBubble({
    @required this.draft,
    @required this.onSwitch,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyer draft;
  final ValueChanged<bool> onSwitch;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleHeaderVM: const BubbleHeaderVM(
          headlineVerse: Verse(
            text: 'phid_flyer_url_poster',
            translate: true,
          ),
          // switchValue: true,//draft.showsAuthor,
          // hasSwitch: true,
          // onSwitchTap: (bool value) => testPoster(
          //   context: context,
          //   draft: draft,
          // ),
      ),
      width: Bubble.bubbleWidth(context),
      columnChildren: <Widget>[

        Screenshot(
          controller: draft.posterController,
          child: PosterSwitcher(
            posterType: PosterType.flyer,
            width: Bubble.clearWidth(context),
            model: draft,
            modelHelper: draft.bzModel,
          ),
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}

Future<void> testPoster({
  @required BuildContext context,
  @required DraftFlyer draft,
}) async {

  final Uint8List _bytes = await PosterDisplay.capturePoster(
    posterType: PosterType.flyer,
    model: draft,
    helperModel: draft.bzModel,
    // finalDesiredPicWidth: Standards.posterDimensions.width,
  );

  final PicModel _posterPicModel = PicModel(
    bytes: _bytes,
    path: Storage.generateFlyerPosterPath(draft.id),
    meta: PicMetaModel(
        dimensions: await Dimensions.superDimensions(_bytes),
        ownersIDs: await FlyerModel.generateFlyerOwners(
          context: context,
          bzID: draft.bzID,
        )
    ),
  );

  final double _mega = Filers.calculateSize(_bytes.length, FileSizeUnit.megaByte);
  final double _kilo = Filers.calculateSize(_bytes.length, FileSizeUnit.kiloByte);

  _posterPicModel.blogPic(invoker: 'createFlyerPoster : is done');

  await BottomDialog.showBottomDialog(
    context: context,
    draggable: true,
    height: _posterPicModel.meta.dimensions.height + 50,
    child: Column(
      children: <Widget>[

        SuperVerse.verseInfo(
          verse: Verse(
            text: '$_kilo Kb : $_mega Mb',
            translate: false,
          ),
        ),

        /// POSTER
        SuperImage(
          pic: _bytes,
          height: _posterPicModel.meta.dimensions.height,
          width: _posterPicModel.meta.dimensions.width,
          corners: BldrsAppBar.corners,
        ),

      ],
    ),

  );

}
