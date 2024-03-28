import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoCropZone extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoCropZone({
    required this.controller,
    required this.currentMs,
    super.key
  });
  // --------------------
  final VideoEditorController controller;
  final ValueNotifier<int> currentMs;
  // --------------------
  @override
  _VideoCropZoneState createState() => _VideoCropZoneState();
// --------------------------------------------------------------------------
}

class _VideoCropZoneState extends State<VideoCropZone> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  MediaModel? _cover;
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

        await _createCover();
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CREATE IMAGE

  // --------------------
  Future<void> _createCover() async {

    await _triggerLoading(setTo: true);

    final String? _filePath = widget.controller.file.path;

    if (_filePath != null){

      final Uint8List? _bytes = await VideoThumbnail.thumbnailData(
        imageFormat: ImageFormat.JPEG,
        video: _filePath,
        timeMs: widget.currentMs.value,
        quality: 100, // for same quality image
      );

      final MediaModel? _model = await MediaModelCreator.fromBytes(
        bytes: _bytes,
        uploadPath: StoragePath.entities_title(widget.controller.file.fileNameWithoutExtension)!,
        mediaOrigin: MediaOrigin.generated,
      );

      setState(() {
        _cover = _model;
      });

    }

    await _triggerLoading(setTo: false);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _videoZoneHeight =  EditorScale.mediaZoneHeight(panelIsOn: true);
    final double _videoHeight = EditorScale.mediaHeight(panelIsOn: true);
    // --------------------
    return Container(
      width: _screenWidth,
      height: _videoZoneHeight,
      color: Colorz.yellow125,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          // if (_cover == null)
          SizedBox(
            height: _videoHeight,
            child: CropGridViewer.preview(
                controller: widget.controller,
            ),
          ),

          /// the_smart_crop_work_around
          if (_cover != null)
            BldrsImage(
              width: _videoHeight * _cover!.getDimensions()!.getAspectRatio(),
              height: _videoHeight,
              pic: _cover,
            ),


        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
