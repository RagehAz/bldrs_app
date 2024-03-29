import 'dart:io';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/video_maker/video_maker.dart';
import 'package:basics/mediator/video_maker/video_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

import '../b_screens/h_media_screens/bldrs_video_editor_screen/src/components/panels/super_timeline/super_time_line.dart';

class SuperTimeLineTestScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLineTestScreen({
    super.key
  });

  @override
  State<SuperTimeLineTestScreen> createState() => _SuperTimeLineTestScreenState();
}

class _SuperTimeLineTestScreenState extends State<SuperTimeLineTestScreen> {
  // --------------------------------------------------------------------------
  int _startMs = 0;
  int _endMs = 0;
  int _currentMs = 0;
  // --------------------------------------------------------------------------
  VideoEditorController? _videoEditorController;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _msPixelLength = ValueNotifier(TimelineScale.initialMsPixelLength);
  // --------------------
  @override
  void dispose() {
    _videoEditorController?.dispose();
    _msPixelLength.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  Future<void> _pickVideo() async {

    // final String _fileName = Numeric.createUniqueID().toString();

    final MediaModel? _video = await VideoMaker.pickVideo(
      context: context,
      langCode: 'en',
      onError: (t){},
      onPermissionPermanentlyDenied: (t){},
      ownersIDs: ['x'],
      uploadPathMaker: (String? title){
        return StoragePath.entities_title(title) ?? Numeric.createRandomIndex().toString();
      },
    );

    if (_video != null){

      final File? file = await Filer.createFromMediaModel(
        mediaModel: _video,
      );

      _videoEditorController = await VideoOps.initializeVideoEditorController(
        file: file,
        onError: (String error) async {
          await Dialogs.errorDialog(
            titleVerse: Verse.plain(error),
          );
          // await Nav.goBack(context: context);
        },
      );

      setState(() {});

    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      title: Verse.plain('Super timeline screen'),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          verse: Verse.plain('pick'),
          onTap: _pickVideo,
        ),

      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// SUPER TIMELINE
          SuperTimeLine(
            height: 80,
            totalWidth: Scale.screenWidth(context),
            // limitScrollingBetweenHandles: false,
            videoEditorController: _videoEditorController,
            scrollController: _scrollController,
            msPixelLength: _msPixelLength,
            onTimeChanged: (int currentMs){

              if (_videoEditorController?.isPlaying == false){
                if (mounted){
                  setState(() {
                    _currentMs = currentMs;
                  });
                }
              }
            },
            onHandleChanged: (int startMs, int endMs){
              if (mounted){
                setState(() {
                  _startMs = startMs;
                  _endMs = endMs;
                });
              }
            },
          ),

          /// temp timers
          Builder(
            builder: (context) {

              final String _start = Numeric.formatDoubleWithinDigits(
                value: _startMs / 1000,
                digits: 2,
                addPlus: false,
              )!;

              final String _end = Numeric.formatDoubleWithinDigits(
                value: _endMs / 1000,
                digits: 2,
                addPlus: false,
              )!;

              final String _current = Numeric.formatDoubleWithinDigits(
                value: _currentMs / 1000,
                digits: 2,
                addPlus: false,
              )!;

              return BldrsBox(
                height: 30,
                width: 200,
                verse: Verse.plain('s$_start ---> e$_end'),
                secondLine: Verse.plain('c: $_current'),
                margins: 10,
                color: Colorz.blue80,
                bubble: false,
                icon: Iconz.play,
                verseScaleFactor: 0.7,
                onTap: () async {

                  await TimelineScale.scrollFromTo(
                    controller: _scrollController,
                    msPixelLength: _msPixelLength.value,
                    fromMs: _startMs,
                    toMs: _endMs,
                  );

                },
              );
            }
          ),

          /// REMOVE_ME
          // /// TEMP VIDEO BOXER
          // if (_videoEditorController != null)
          // VideoBoxer(
          //   width: _videoBoxerWidth,
          //   height: 40,
          //   controller: _videoEditorController!,
          // ),

          /// temp video view
          if (_videoEditorController != null)
          SizedBox(
            height: 80,
            child: CropGridViewer.preview(
                controller: _videoEditorController!
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
