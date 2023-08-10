import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/poster/structure/poster_switcher.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class FlyerPosterCreatorBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerPosterCreatorBubble({
    required this.draft,
    required this.onSwitch,
    required this.bzModel,
    required this.onPosterCreated,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final ValueChanged<bool> onSwitch;
  final BzModel? bzModel;
  final Function(PicModel? pic) onPosterCreated;

  @override
  State<FlyerPosterCreatorBubble> createState() => _FlyerPosterCreatorBubbleState();
}

class _FlyerPosterCreatorBubbleState extends State<FlyerPosterCreatorBubble> {
  // -----------------------------------------------------------------------------
  final ScreenshotController _cont = ScreenshotController();
  bool _loading = true;
  PicModel? _poster;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _loadPoster();

      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose(){
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _loadPoster() async {

    if (widget.draft?.id != null){

      if (_loading == false){
        setState(() {
          _loading = true;
        });
      }

      final double _screenWidth = Scale.screenWidth(context);
      final double _finalDesiredWidth = Standards.posterDimensions.width!;

      Uint8List? _bytes = await _cont.capture(
        pixelRatio: _finalDesiredWidth / _screenWidth,
        delay: const Duration(milliseconds: 1000),
      );

      final String? _path = StoragePath.flyers_flyerID_poster(widget.draft!.id);

      if (_bytes != null && _path != null){

        _bytes = await PicMaker.compressPic(
          bytes: _bytes,
          compressToWidth: Standards.posterDimensions.width,
          quality: Standards.slideSmallQuality,
        );

        final PicModel? _pic = await PicModel.combinePicModel(
          bytes: _bytes,
          picMakerType: PicMakerType.generated,
          compressionQuality: Standards.slideSmallQuality,
          assignPath: _path,
          name: '${widget.draft!.id}_poster',
          ownersIDs: await FlyerModel.generateFlyerOwners(
            bzID: widget.draft!.bzID,
          ),
        );

        widget.onPosterCreated(_pic);

        setState(() {
          _poster = _pic;
          _loading = false;
        });

      }

    }


  }
  // --------------------
  Future<void> _reloadPoster() async {

    setState(() {
      _poster = null;
    });

    await _loadPoster();

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context: context);
    final double _posterHeight = NotePosterBox.getBoxHeight(_clearWidth);

    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_flyer_url_poster',
          translate: true,
        ),
        leadingIcon: Iconz.check,
        leadingIconSizeFactor: 0.6,
        loading: _poster == null,
        // switchValue: true,//draft.showsAuthor,
        // hasSwitch: true,
        // onSwitchTap: (bool value) => testPoster(
        //   context: context,
        //   draft: widget.draft,
        // ),
      ),
      width: Bubble.bubbleWidth(context: context),
      columnChildren: <Widget>[

        const BldrsBulletPoints(
          showBottomLine: false,
          bulletPoints: <Verse>[

            Verse(
              id: 'phid_poster_for_url',
              translate: true,
            ),

            Verse(
              id: 'phid_flyer_look_on_social_media',
              translate: true,
            ),

          ],
        ),

        /// POSTER
        if (_poster != null)
        Stack(
          children: [

            /// SHOT POSTER
            BldrsImage(
              width: _clearWidth,
              height: _posterHeight,
              pic: _poster,
              loading: _loading,
              corners: Bubble.clearBorders(),
            ),

            /// REFRESH POSTER BUTTON
            Positioned(
              bottom: _posterHeight * 0.05,
              left: _posterHeight * 0.05,
              child: BldrsBox(
                height: _posterHeight * 0.12,
                icon: Iconz.reload,
                iconSizeFactor: 0.6,
                verseScaleFactor: 0.9 / 0.6,
                verse: const Verse(
                  id: 'phid_refresh',
                  translate: false,
                  casing: Casing.capitalizeFirstChar,
                ),
                verseCentered: false,
                color: Colorz.white10,
                onTap: _reloadPoster,
                verseWeight: VerseWeight.thin,
              ),
            ),

          ],
        ),

        /// SCREEN SHOOTER
        if (_poster == null)
        ClipRRect(
          borderRadius: Bubble.clearBorders(),
          child: Screenshot(
            controller: _cont,
            child: Container(
              width: _clearWidth,
              height: _posterHeight,
              color: Colorz.black255,
              child: Stack(
                children: [

                  /// POSTER
                  PosterSwitcher(
                    posterType: PosterType.flyer,
                    width: _clearWidth,
                    model: widget.draft,
                    modelHelper: widget.draft?.bzModel,
                  ),

                  /// PYRAMIDS
                  Positioned(
                    bottom: _clearWidth * -0.01,
                    right: 17 * _clearWidth * 0.0015,
                    child: BldrsImage(
                      width: 256 * _clearWidth * 0.0015,
                      height: 80 * _clearWidth * 0.0015,
                      pic: Iconz.pyramidzYellow,
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  /// LOGO
                  Positioned(
                    bottom: _clearWidth * 0.06,
                    right: _clearWidth * 0.055,
                    child: BldrsImage(
                      width: _posterHeight * 0.25,
                      height: _posterHeight * 0.25,
                      pic: Iconz.bldrsNameSquare,
                      // backgroundColor: Colorz.bloodTest,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),

      ],
    );

  }
}

// Future<void> testPoster({
//   required BuildContext context,
//   required DraftFlyer? draft,
//   Uint8List? bytes,
// }) async {
//
//   final Uint8List? _bytes = bytes ?? await PosterDisplay.capturePoster(
//     context: context,
//     posterType: PosterType.flyer,
//     model: draft,
//     helperModel: draft?.bzModel,
//     // finalDesiredPicWidth: Standards.posterDimensions.width,
//   );
//
//   final PicModel? _posterPicModel = await PicModel.combinePicModel(
//       bytes: bytes,
//       picMakerType: PicMakerType.generated,
//       compressionQuality: 80,
//       assignPath: StoragePath.flyers_flyerID_poster(draft?.id)!,
//       ownersIDs: await FlyerModel.generateFlyerOwners(
//           bzID: draft?.bzID,
//         ),
//       name: 'poster_test',
//   );
//
//   final double? _mega = Filers.calculateSize(_bytes?.length, FileSizeUnit.megaByte);
//   final double? _kilo = Filers.calculateSize(_bytes?.length, FileSizeUnit.kiloByte);
//
//
//   await BottomDialog.showBottomDialog(
//     height: (_posterPicModel?.meta?.height ?? 0) + 50,
//     child: Column(
//       children: <Widget>[
//
//         BldrsText.verseInfo(
//           verse: Verse(
//             id: '$_kilo Kb : $_mega Mb',
//             translate: false,
//           ),
//         ),
//
//         /// POSTER
//         BldrsImage(
//           pic: _bytes,
//           height: _posterPicModel?.meta?.height,
//           width: _posterPicModel?.meta?.width,
//           corners: BldrsAppBar.corners,
//         ),
//
//       ],
//     ),
//
//   );
//
// }
