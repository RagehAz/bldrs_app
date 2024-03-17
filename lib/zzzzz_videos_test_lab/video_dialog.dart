import 'dart:io';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:basics/mediator/video_maker/video_ops.dart';
import 'package:bldrs/zzzzz_videos_test_lab/zebala/video_result.dart';
import 'package:flutter/material.dart';
import 'package:basics/mediator/super_video_player/super_video_player.dart';

class VideoDialog extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoDialog({
    required this.video,
    super.key,
  });
  // --------------------
  final File video;
  // --------------------------------------------------------------------------
  @override
  State<VideoDialog> createState() => _VideoDialogState();
  // --------------------------------------------------------------------------
  static Future<void> push({
    required File? file,
  }) async {

    if (file != null){
      await showDialog(
        context: getMainContext(),
        builder: (_) => VideoDialog(video: file),
      );
    }

  }
  // --------------------------------------------------------------------------
}

class _VideoDialogState extends State<VideoDialog> {
  // --------------------------------------------------------------------------
  VideoPlayerController? _controller;
  Dimensions _dimensions = Dimensions.zero;
  bool _isGif = false;
  late String _fileMbSize;
  // --------------------
  @override
  void initState() {
    super.initState();

    _isGif = ObjectCheck.objectIsGIF(widget.video);


    if (_isGif) {
      _getSetDimensions();
    }

    else {

      _controller = VideoPlayerController.file(widget.video);

      _controller?.initialize().then((_) {

        _dimensions = Dimensions.fromSize(_controller?.value.size);

        setState(() {});
        _controller?.play();
        _controller?.setLooping(true);

      });
    }

    _fileMbSize = VideoOps.getSizeMbString(
      file: widget.video,
    );

  }
  // --------------------
  @override
  void dispose() {

    if (_isGif == false) {
      _controller?.pause();
      _controller?.dispose();
    }

    super.dispose();
  }
  // --------------------------------------------------------------------------
  Future<void> _getSetDimensions() async {

    final Dimensions? _dims = await DimensionsGetter.getFileDims(
      file: widget.video,
    );

    if (_dims != null){

      setState(() {
        _dimensions = _dims;
      });

    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _aspectRatio = _dimensions.getAspectRatio();

    if (_aspectRatio <= 0){
      return const SizedBox();
    }

    else {

      return WidgetFader(
        fadeType: FadeType.fadeIn,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: ClipRRect(
              borderRadius: Borderers.constantCornersAll20,
              child: Stack(
                children: <Widget>[

                  /// GRAPHIC
                  if (_aspectRatio > 0)
                  AspectRatio(
                    aspectRatio: _aspectRatio,
                    child: _isGif ? Image.file(widget.video) : VideoPlayer(_controller!),
                  ),

                  /// DATA
                    Positioned(
                      bottom: 0,
                      child: FileDescription(
                        description: {
                          'Video path': widget.video.path,
                          if (!_isGif)
                            'Video duration': '${((_controller?.value.duration.inMilliseconds ?? 0) / 1000).toStringAsFixed(2)}s',
                          // 'Video ratio': Fraction.fromDouble(_aspectRatio).reduce().toString(),
                          'Video dimension': _dimensions.toString(),
                          'Video size': _fileMbSize,
                        },
                      ),
                    ),

                  /// EXIT BUTTON
                  SuperPositioned(
                    appIsLTR: UiProvider.checkAppIsLeftToRight(),
                    enAlignment: Alignment.topLeft,
                    horizontalOffset: 5,
                    verticalOffset: 5,
                    child: SuperBox(
                      height: 30,
                      width: 30,
                      corners: 15,
                      color: Colorz.black80,
                      icon: Iconz.xLarge,
                      iconSizeFactor: 0.5,
                      onTap: () => Nav.goBack(context: context),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );

    }



  }
  // --------------------------------------------------------------------------
}
