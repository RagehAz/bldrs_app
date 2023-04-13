import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/poster/poster_display.dart';
import 'package:bldrs/b_views/z_components/poster/structure/poster_switcher.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths_generators.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
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
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_flyer_url_poster',
          translate: true,
        ),
        // switchValue: true,//draft.showsAuthor,
        // hasSwitch: true,
        // onSwitchTap: (bool value) => testPoster(
        //   context: context,
        //   draft: draft,
        // ),
      ),
      width: Bubble.bubbleWidth(context: context),
      columnChildren: <Widget>[

        Screenshot(
          controller: draft.posterController,
          child: PosterSwitcher(
            posterType: PosterType.flyer,
            width: Bubble.clearWidth(context: context),
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
    context: context,
    posterType: PosterType.flyer,
    model: draft,
    helperModel: draft.bzModel,
    // finalDesiredPicWidth: Standards.posterDimensions.width,
  );

  final Dimensions _dims = await Dimensions.superDimensions(_bytes);

  final PicModel _posterPicModel = PicModel(
    bytes: _bytes,
    path: BldrStorage.generateFlyerPosterPath(draft.id),
    meta: PicMetaModel(
        width: _dims?.width,
        height: _dims?.height,
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
    height: _posterPicModel.meta.height + 50,
    child: Column(
      children: <Widget>[

        BldrsText.verseInfo(
          verse: Verse(
            id: '$_kilo Kb : $_mega Mb',
            translate: false,
          ),
        ),

        /// POSTER
        BldrsImage(
          pic: _bytes,
          height: _posterPicModel.meta.height,
          width: _posterPicModel.meta.width,
          corners: BldrsAppBar.corners,
        ),

      ],
    ),

  );

}
