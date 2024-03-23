import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/poster/structure/poster_switcher.dart';
import 'package:bldrs/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
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
  final Function(MediaModel? pic) onPosterCreated;

  @override
  State<FlyerPosterCreatorBubble> createState() => _FlyerPosterCreatorBubbleState();
}

class _FlyerPosterCreatorBubbleState extends State<FlyerPosterCreatorBubble> {
  // -----------------------------------------------------------------------------
  final ScreenshotController _cont = ScreenshotController();
  bool _loading = true;
  MediaModel? _poster;
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
  /// TESTED : WORKS PERFECT
  Future<void> _loadPoster() async {

    if (widget.draft?.id != null){

      final String? _uploadPath = StoragePath.flyers_flyerID_poster(widget.draft!.id);

      if (_uploadPath != null){

        MediaModel? _pic;

        if (_loading == false){
          setState(() {
            _poster = null;
            _loading = true;
          });
        }

        Uint8List? _bytes;

        await tryAndCatch(
          invoker: 'Load poster',
          functions: () async {

            await Future.delayed(Duration(
                milliseconds: (widget.draft?.draftSlides?.length ?? 1) * 800,
            )
            );

            _bytes = await _cont.capture(
              /// this fixes white lines issue
              pixelRatio: MediaQuery.of(context).devicePixelRatio,
              delay: const Duration(milliseconds: 1000),
            );

            _pic = await MediaModelCreator.fromBytes(
              bytes: _bytes,
              mediaOrigin: MediaOrigin.generated,
              uploadPath: _uploadPath,
              fileName: '${widget.draft!.id}_posterX',
              ownersIDs: await FlyerModel.generateFlyerOwners(
                bzID: widget.draft!.bzID,
              ),
            );

            },
        );

        if (_pic != null){

          _pic = await PicMaker.resizePic(
              mediaModel: _pic,
              resizeToWidth: Standards.posterDimensions.width
          );

          _pic = await PicMaker.compressPic(
            mediaModel: _pic,
            quality: Standards.slideMediumQuality,
          );

          widget.onPosterCreated(_pic);

        }

        if (mounted == true){
          setState(() {
            _poster = _pic;
            _loading = false;
          });
        }

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _reloadPoster() async {

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
        // onLeadingIconTap: () async {
        //
        //   final MediaModel? _x = await MediaModelCreator.fromLocalAsset(localAsset: Iconz.redAlert);
        //
        //   setState(() {
        //     _poster = _poster == null ? _x : null;
        //   });
        // }
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
          alignment: Alignment.center,
          children: <Widget>[

            /// SHOT POSTER
            BldrsImage(
              width: _clearWidth,
              height: _posterHeight,
              pic: _poster,
              loading: _loading,
              fit: BoxFit.fitWidth,
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
                  translate: true,
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
                alignment: Alignment.center,
                children: <Widget>[

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
  // --------------------------------------------------------------------------
}

/// POSTER TEST
/*
Future<void> testPoster({
  required BuildContext context,
  required DraftFlyer? draft,
  Uint8List? bytes,
}) async {

  final Uint8List? _bytes = bytes ?? await PosterDisplay.capturePoster(
    context: context,
    posterType: PosterType.flyer,
    model: draft,
    helperModel: draft?.bzModel,
    // finalDesiredPicWidth: Standards.posterDimensions.width,
  );

  final PicModel? _posterPicModel = await PicModel.combinePicModel(
      bytes: bytes,
      picMakerType: MediaSource.generated,
      compressionQuality: 80,
      assignPath: StoragePath.flyers_flyerID_poster(draft?.id)!,
      ownersIDs: await FlyerModel.generateFlyerOwners(
          bzID: draft?.bzID,
        ),
      name: 'poster_test',
  );

  final double? _mega = Filers.calculateSize(_bytes?.length, FileSizeUnit.megaByte);
  final double? _kilo = Filers.calculateSize(_bytes?.length, FileSizeUnit.kiloByte);


  await BottomDialog.showBottomDialog(
    height: (_posterPicModel?.meta?.height ?? 0) + 50,
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
          height: _posterPicModel?.meta?.height,
          width: _posterPicModel?.meta?.width,
          corners: BldrsAppBar.corners,
        ),

      ],
    ),

  );

}
*/
