import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camerawesome/models/orientations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imgUtils;
// import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/models/capture_modes.dart';
import 'dart:math';
import 'package:video_player/video_player.dart';
import 'package:camerawesome/models/flashmodes.dart';
import 'package:flutter/foundation.dart';

// void main() {
//   runApp(MaterialApp(
//     home: AwesomeCameraScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class AwesomeCameraScreen extends StatefulWidget {
  // just for E2E test. if true we create our images names from datetime.
  // Else it's just a name to assert image exists
  final bool randomPhotoName;

  AwesomeCameraScreen({this.randomPhotoName = true});

  @override
  _AwesomeCameraScreenState createState() => _AwesomeCameraScreenState();
}

class _AwesomeCameraScreenState extends State<AwesomeCameraScreen> with TickerProviderStateMixin {
  String _lastPhotoPath, _lastVideoPath;
  bool _focus = false, _fullscreen = false, _isRecordingVideo = false;

  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<double> _zoomNotifier = ValueNotifier(0);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<bool> _enableAudio = ValueNotifier(true);
  ValueNotifier<CameraOrientations> _orientation =
  ValueNotifier(CameraOrientations.PORTRAIT_UP);

  /// use this to call a take picture
  PictureController _pictureController = new PictureController();

  /// use this to record a video
  VideoController _videoController = new VideoController();

  /// list of available sizes
  List<Size> _availableSizes;

  AnimationController _iconsAnimationController, _previewAnimationController;
  Animation<Offset> _previewAnimation;
  Timer _previewDismissTimer;
  // StreamSubscription<Uint8List> previewStreamSub;
  Stream<Uint8List> previewStream;

  @override
  void initState() {
    super.initState();
    _iconsAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _previewAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    _previewAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _previewAnimationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _iconsAnimationController.dispose();
    _previewAnimationController.dispose();
    // previewStreamSub.cancel();
    _photoSize.dispose();
    _captureMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          this._fullscreen ? buildFullscreenCamera() : buildSizedScreenCamera(),
          _buildInterface(),
          (!_isRecordingVideo)
              ? PreviewCardWidget(
            lastPhotoPath: _lastPhotoPath,
            orientation: _orientation,
            previewAnimation: _previewAnimation,
          )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildInterface() {
    return Stack(
      children: <Widget>[
        SafeArea(
          bottom: false,
          child: TopBarWidget(
              isFullscreen: _fullscreen,
              isRecording: _isRecordingVideo,
              enableAudio: _enableAudio,
              photoSize: _photoSize,
              captureMode: _captureMode,
              switchFlash: _switchFlash,
              orientation: _orientation,
              rotationController: _iconsAnimationController,
              onFlashTap: () {
                switch (_switchFlash.value) {
                  case CameraFlashes.NONE:
                    _switchFlash.value = CameraFlashes.ON;
                    break;
                  case CameraFlashes.ON:
                    _switchFlash.value = CameraFlashes.AUTO;
                    break;
                  case CameraFlashes.AUTO:
                    _switchFlash.value = CameraFlashes.ALWAYS;
                    break;
                  case CameraFlashes.ALWAYS:
                    _switchFlash.value = CameraFlashes.NONE;
                    break;
                }
                setState(() {});
              },
              onAudioChange: () {
                this._enableAudio.value = !this._enableAudio.value;
                setState(() {});
              },
              onChangeSensorTap: () {
                this._focus = !_focus;
                if (_sensor.value == Sensors.FRONT) {
                  _sensor.value = Sensors.BACK;
                } else {
                  _sensor.value = Sensors.FRONT;
                }
              },
              onResolutionTap: () => _buildChangeResolutionDialog(),
              onFullscreenTap: () {
                this._fullscreen = !this._fullscreen;
                setState(() {});
              }),
        ),
        BottomBarWidget(
          onZoomInTap: () {
            if (_zoomNotifier.value <= 0.9) {
              _zoomNotifier.value += 0.1;
            }
            setState(() {});
          },
          onZoomOutTap: () {
            if (_zoomNotifier.value >= 0.1) {
              _zoomNotifier.value -= 0.1;
            }
            setState(() {});
          },
          onCaptureModeSwitchChange: () {
            if (_captureMode.value == CaptureModes.PHOTO) {
              _captureMode.value = CaptureModes.VIDEO;
            } else {
              _captureMode.value = CaptureModes.PHOTO;
            }
            setState(() {});
          },
          onCaptureTap: (_captureMode.value == CaptureModes.PHOTO)
              ? _takePhoto
              : _recordVideo,
          rotationController: _iconsAnimationController,
          orientation: _orientation,
          isRecording: _isRecordingVideo,
          captureMode: _captureMode,
        ),
      ],
    );
  }

  _takePhoto() async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
    await Directory('${extDir.path}/test').create(recursive: true);
    final String filePath = widget.randomPhotoName
        ? '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg'
        : '${testDir.path}/photo_test.jpg';
    await _pictureController.takePicture(filePath);
    // lets just make our phone vibrate
    HapticFeedback.mediumImpact();
    _lastPhotoPath = filePath;
    setState(() {});
    if (_previewAnimationController.status == AnimationStatus.completed) {
      _previewAnimationController.reset();
    }
    _previewAnimationController.forward();
    print("----------------------------------");
    print("TAKE PHOTO CALLED");
    final file = File(filePath);
    print("==> hastakePhoto : ${file.exists()} | path : $filePath");
    final img = imgUtils.decodeImage(file.readAsBytesSync());
    print("==> img.width : ${img.width} | img.height : ${img.height}");
    print("----------------------------------");
  }

  _recordVideo() async {
    // lets just make our phone vibrate
    HapticFeedback.mediumImpact();

    if (this._isRecordingVideo) {
      await _videoController.stopRecordingVideo();

      _isRecordingVideo = false;
      setState(() {});

      final file = File(_lastVideoPath);
      print("----------------------------------");
      print("VIDEO RECORDED");
      print(
          "==> has been recorded : ${file.exists()} | path : $_lastVideoPath");
      print("----------------------------------");

      await Future.delayed(Duration(milliseconds: 300));
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreview(
            videoPath: _lastVideoPath,
          ),
        ),
      );
    } else {
      final Directory extDir = await getTemporaryDirectory();
      final testDir =
      await Directory('${extDir.path}/test').create(recursive: true);
      final String filePath = widget.randomPhotoName
          ? '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4'
          : '${testDir.path}/video_test.mp4';
      await _videoController.recordVideo(filePath);
      _isRecordingVideo = true;
      _lastVideoPath = filePath;
      setState(() {});
    }
  }

  _buildChangeResolutionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => ListTile(
          key: ValueKey("resOption"),
          onTap: () {
            this._photoSize.value = _availableSizes[index];
            setState(() {});
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.aspect_ratio),
          title: Text(
              "${_availableSizes[index].width}/${_availableSizes[index].height}"),
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: _availableSizes.length,
      ),
    );
  }

  _onOrientationChange(CameraOrientations newOrientation) {
    _orientation.value = newOrientation;
    if (_previewDismissTimer != null) {
      _previewDismissTimer.cancel();
    }
  }

  _onPermissionsResult(bool granted) {
    if (!granted) {
      AlertDialog alert = AlertDialog(
        title: Text('Error'),
        content: Text(
            'It seems you didn\'t authorize some permissions. Please check your settings and try again.'),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      setState(() {});
      print("granted");
    }
  }

  // /// this is just to preview images from stream
  // /// This use a bufferTime to take an image each 1500 ms
  // /// you cannot show every frame as flutter cannot draw them fast enough
  // /// [THIS IS JUST FOR DEMO PURPOSE]
  // Widget _buildPreviewStream() {
  //   if (previewStream == null) return Container();
  //   return Positioned(
  //     left: 32,
  //     bottom: 120,
  //     child: StreamBuilder(
  //       stream: previewStream.bufferTime(Duration(milliseconds: 1500)),
  //       builder: (context, snapshot) {
  //         print(snapshot);
  //         if (!snapshot.hasData || snapshot.data == null) return Container();
  //         List<Uint8List> data = snapshot.data;
  //         print(
  //             "...${DateTime.now()} new image received... ${data.last.lengthInBytes} bytes");
  //         return Image.memory(
  //           data.last,
  //           width: 120,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget buildFullscreenCamera() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Center(
        child: CameraAwesome(
          onPermissionsResult: _onPermissionsResult,
          selectDefaultSize: (availableSizes) {
            this._availableSizes = availableSizes;
            return availableSizes[0];
          },
          captureMode: _captureMode,
          photoSize: _photoSize,
          sensor: _sensor,
          enableAudio: _enableAudio,
          switchFlashMode: _switchFlash,
          zoom: _zoomNotifier,
          onOrientationChanged: _onOrientationChange,
          // imagesStreamBuilder: (imageStream) {
          //   /// listen for images preview stream
          //   /// you can use it to process AI recognition or anything else...
          //   print("-- init CamerAwesome images stream");
          //   setState(() {
          //     previewStream = imageStream;
          //   });

          //   imageStream.listen((Uint8List imageData) {
          //     print(
          //         "...${DateTime.now()} new image received... ${imageData.lengthInBytes} bytes");
          //   });
          // },
          onCameraStarted: () {
            // camera started here -- do your after start stuff
          },
        ),
      ),
    );
  }

  Widget buildSizedScreenCamera() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: CameraAwesome(
              onPermissionsResult: _onPermissionsResult,
              selectDefaultSize: (availableSizes) {
                this._availableSizes = availableSizes;
                return availableSizes[0];
              },
              captureMode: _captureMode,
              photoSize: _photoSize,
              sensor: _sensor,
              fitted: true,
              switchFlashMode: _switchFlash,
              zoom: _zoomNotifier,
              onOrientationChanged: _onOrientationChange,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarWidget extends StatelessWidget {
  final AnimationController rotationController;
  final ValueNotifier<CameraOrientations> orientation;
  final ValueNotifier<CaptureModes> captureMode;
  final bool isRecording;
  final Function onZoomInTap;
  final Function onZoomOutTap;
  final Function onCaptureTap;
  final Function onCaptureModeSwitchChange;

  const BottomBarWidget({
    Key key,
    @required this.rotationController,
    @required this.orientation,
    @required this.isRecording,
    @required this.captureMode,
    @required this.onZoomOutTap,
    @required this.onZoomInTap,
    @required this.onCaptureTap,
    @required this.onCaptureModeSwitchChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Container(
              color: Colors.black12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    OptionButton(
                      icon: Icons.zoom_out,
                      rotationController: rotationController,
                      orientation: orientation,
                      onTapCallback: () => onZoomOutTap?.call(),
                    ),
                    CameraButton(
                      key: ValueKey('cameraButton'),
                      captureMode: captureMode.value,
                      isRecording: isRecording,
                      onTap: () => onCaptureTap?.call(),
                    ),
                    OptionButton(
                      icon: Icons.zoom_in,
                      rotationController: rotationController,
                      orientation: orientation,
                      onTapCallback: () => onZoomInTap?.call(),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                    ),
                    Switch(
                      key: ValueKey('captureModeSwitch'),
                      value: (captureMode.value == CaptureModes.VIDEO),
                      activeColor: Color(0xFF4F6AFF),
                      onChanged: !isRecording
                          ? (value) {
                        HapticFeedback.heavyImpact();
                        onCaptureModeSwitchChange?.call();
                      }
                          : null,
                    ),
                    Icon(
                      Icons.videocam,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatefulWidget {
  final IconData icon;
  final Function onTapCallback;
  final AnimationController rotationController;
  final ValueNotifier<CameraOrientations> orientation;
  final bool isEnabled;
  const OptionButton({
    Key key,
    this.icon,
    this.onTapCallback,
    this.rotationController,
    this.orientation,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {
  double _angle = 0.0;
  CameraOrientations _oldOrientation = CameraOrientations.PORTRAIT_UP;

  @override
  void initState() {
    super.initState();

    Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(widget.rotationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _oldOrientation =
              OrientationUtils.convertRadianToOrientation(_angle);
        }
      });

    widget.orientation.addListener(() {
      _angle =
          OrientationUtils.convertOrientationToRadian(widget.orientation.value);

      if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
        widget.rotationController.reverse();
      } else if (_oldOrientation == CameraOrientations.LANDSCAPE_LEFT ||
          _oldOrientation == CameraOrientations.LANDSCAPE_RIGHT) {
        widget.rotationController.reset();

        if ((widget.orientation.value == CameraOrientations.LANDSCAPE_LEFT ||
            widget.orientation.value == CameraOrientations.LANDSCAPE_RIGHT)) {
          widget.rotationController.forward();
        } else if ((widget.orientation.value ==
            CameraOrientations.PORTRAIT_DOWN)) {
          if (_oldOrientation == CameraOrientations.LANDSCAPE_RIGHT) {
            widget.rotationController.forward(from: 0.5);
          } else {
            widget.rotationController.reverse(from: 0.5);
          }
        }
      } else if (widget.orientation.value == CameraOrientations.PORTRAIT_DOWN) {
        widget.rotationController.reverse(from: 0.5);
      } else {
        widget.rotationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.rotationController,
      builder: (context, child) {
        double newAngle;

        if (_oldOrientation == CameraOrientations.LANDSCAPE_LEFT) {
          if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
            newAngle = -widget.rotationController.value;
          }
        }

        if (_oldOrientation == CameraOrientations.LANDSCAPE_RIGHT) {
          if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
            newAngle = widget.rotationController.value;
          }
        }

        if (_oldOrientation == CameraOrientations.PORTRAIT_DOWN) {
          if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
            newAngle = widget.rotationController.value * -pi;
          }
        }

        return IgnorePointer(
          ignoring: !widget.isEnabled,
          child: Opacity(
            opacity: widget.isEnabled ? 1.0 : 0.3,
            child: Transform.rotate(
              angle: newAngle ?? widget.rotationController.value * _angle,
              child: ClipOval(
                child: Material(
                  color: Color(0xFF4F6AFF),
                  child: InkWell(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                    onTap: () {
                      if (widget.onTapCallback != null) {
                        // Trigger short vibration
                        HapticFeedback.selectionClick();

                        widget.onTapCallback();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CameraPreview extends StatefulWidget {
  final String videoPath;

  CameraPreview({
    Key key,
    @required this.videoPath,
  }) : super(key: key);

  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video preview'),
      ),
      body: Center(
        child: _videoPlayerController.value.initialized
            ? AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        },
        child: Icon(
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}

class PreviewCardWidget extends StatelessWidget {
  final String lastPhotoPath;
  final Animation<Offset> previewAnimation;
  final ValueNotifier<CameraOrientations> orientation;

  const PreviewCardWidget({
    Key key,
    @required this.lastPhotoPath,
    @required this.previewAnimation,
    @required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    bool mirror;
    switch (orientation.value) {
      case CameraOrientations.PORTRAIT_UP:
      case CameraOrientations.PORTRAIT_DOWN:
        alignment = orientation.value == CameraOrientations.PORTRAIT_UP
            ? Alignment.bottomLeft
            : Alignment.topLeft;
        mirror = orientation.value == CameraOrientations.PORTRAIT_DOWN;
        break;
      case CameraOrientations.LANDSCAPE_LEFT:
      case CameraOrientations.LANDSCAPE_RIGHT:
        alignment = Alignment.topLeft;
        mirror = orientation.value == CameraOrientations.LANDSCAPE_LEFT;
        break;
    }

    return Align(
      alignment: alignment,
      child: Padding(
        padding: OrientationUtils.isOnPortraitMode(orientation.value)
            ? EdgeInsets.symmetric(horizontal: 35.0, vertical: 140)
            : EdgeInsets.symmetric(vertical: 65.0),
        child: Transform.rotate(
          angle: OrientationUtils.convertOrientationToRadian(
            orientation.value,
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(mirror ? pi : 0.0),
            child: Dismissible(
              onDismissed: (direction) {},
              key: UniqueKey(),
              child: SlideTransition(
                position: previewAnimation,
                child: _buildPreviewPicture(reverseImage: mirror),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewPicture({bool reverseImage = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(2, 2),
            blurRadius: 25,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13.0),
          child: lastPhotoPath != null
              ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(reverseImage ? pi : 0.0),
            child: Image.file(
              new File(lastPhotoPath),
              width: OrientationUtils.isOnPortraitMode(orientation.value)
                  ? 128
                  : 256,
            ),
          )
              : Container(
            width: OrientationUtils.isOnPortraitMode(orientation.value)
                ? 128
                : 256,
            height: 228,
            decoration: BoxDecoration(
              color: Colors.black38,
            ),
            child: Center(
              child: Icon(
                Icons.photo,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraButton extends StatefulWidget {
  final CaptureModes captureMode;
  final bool isRecording;
  final Function onTap;

  CameraButton({
    Key key,
    this.captureMode,
    this.isRecording,
    this.onTap,
  }) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _scale;
  Duration _duration = Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        key: ValueKey('cameraButton' +
            (widget.captureMode == CaptureModes.PHOTO ? 'Photo' : 'Video')),
        height: 80,
        width: 80,
        child: Transform.scale(
          scale: _scale,
          child: CustomPaint(
            painter: CameraButtonPainter(
              widget.captureMode ?? CaptureModes.PHOTO,
              isRecording: widget.isRecording,
            ),
          ),
        ),
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  _onTapUp(TapUpDetails details) {
    Future.delayed(_duration, () {
      _animationController.reverse();
    });

    this.widget.onTap?.call();
  }

  _onTapCancel() {
    _animationController.reverse();
  }
}

class CameraButtonPainter extends CustomPainter {
  final CaptureModes captureMode;
  final bool isRecording;

  CameraButtonPainter(
      this.captureMode, {
        this.isRecording = false,
      });

  @override
  void paint(Canvas canvas, Size size) {
    var bgPainter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    var radius = size.width / 2;
    var center = Offset(size.width / 2, size.height / 2);
    bgPainter.color = Colors.white.withOpacity(.5);
    canvas.drawCircle(center, radius, bgPainter);

    if (this.captureMode == CaptureModes.VIDEO && this.isRecording) {
      bgPainter.color = Colors.red;
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(
                17,
                17,
                size.width - (17 * 2),
                size.height - (17 * 2),
              ),
              Radius.circular(12.0)),
          bgPainter);
    } else {
      bgPainter.color =
      captureMode == CaptureModes.PHOTO ? Colors.white : Colors.red;
      canvas.drawCircle(center, radius - 8, bgPainter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TopBarWidget extends StatelessWidget {
  final bool isFullscreen;
  final bool isRecording;
  final ValueNotifier<Size> photoSize;
  final AnimationController rotationController;
  final ValueNotifier<CameraOrientations> orientation;
  final ValueNotifier<CaptureModes> captureMode;
  final ValueNotifier<bool> enableAudio;
  final ValueNotifier<CameraFlashes> switchFlash;
  final Function onFullscreenTap;
  final Function onResolutionTap;
  final Function onChangeSensorTap;
  final Function onFlashTap;
  final Function onAudioChange;

  const TopBarWidget({
    Key key,
    @required this.isFullscreen,
    @required this.isRecording,
    @required this.captureMode,
    @required this.enableAudio,
    @required this.photoSize,
    @required this.orientation,
    @required this.rotationController,
    @required this.switchFlash,
    @required this.onFullscreenTap,
    @required this.onAudioChange,
    @required this.onFlashTap,
    @required this.onChangeSensorTap,
    @required this.onResolutionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Opacity(
                  opacity: isRecording ? 0.3 : 1.0,
                  child: IconButton(
                    icon: Icon(
                      isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                      color: Colors.white,
                    ),
                    onPressed:
                    isRecording ? null : () => onFullscreenTap?.call(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IgnorePointer(
                      ignoring: isRecording,
                      child: Opacity(
                        opacity: isRecording ? 0.3 : 1.0,
                        child: ValueListenableBuilder(
                          valueListenable: photoSize,
                          builder: (context, value, child) => FlatButton(
                            key: ValueKey("resolutionButton"),
                            onPressed: () {
                              HapticFeedback.selectionClick();

                              onResolutionTap?.call();
                            },
                            child: Text(
                              '${value?.width?.toInt()} / ${value?.height?.toInt()}',
                              key: ValueKey("resolutionTxt"),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              OptionButton(
                icon: Icons.switch_camera,
                rotationController: rotationController,
                orientation: orientation,
                onTapCallback: () => onChangeSensorTap?.call(),
              ),
              SizedBox(width: 20.0),
              OptionButton(
                rotationController: rotationController,
                icon: _getFlashIcon(),
                orientation: orientation,
                onTapCallback: () => onFlashTap?.call(),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              captureMode.value == CaptureModes.VIDEO
                  ? OptionButton(
                icon: enableAudio.value ? Icons.mic : Icons.mic_off,
                rotationController: rotationController,
                orientation: orientation,
                isEnabled: !isRecording,
                onTapCallback: () => onAudioChange?.call(),
              )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getFlashIcon() {
    switch (switchFlash.value) {
      case CameraFlashes.NONE:
        return Icons.flash_off;
      case CameraFlashes.ON:
        return Icons.flash_on;
      case CameraFlashes.AUTO:
        return Icons.flash_auto;
      case CameraFlashes.ALWAYS:
        return Icons.highlight;
      default:
        return Icons.flash_off;
    }
  }
}

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
  GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
    ];
  }

  LocaleListResolutionCallback listResolution(
      {Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution(
      {Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        default:
        // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported,
      bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry &&
            (supportedLocale.countryCode == null ||
                supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
    ? null
    : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();

class OrientationUtils {
  static CameraOrientations convertRadianToOrientation(double radians) {
    CameraOrientations orientation;
    if (radians == -pi / 2) {
      orientation = CameraOrientations.LANDSCAPE_LEFT;
    } else if (radians == pi / 2) {
      orientation = CameraOrientations.LANDSCAPE_RIGHT;
    } else if (radians == 0.0) {
      orientation = CameraOrientations.PORTRAIT_UP;
    } else if (radians == pi) {
      orientation = CameraOrientations.PORTRAIT_DOWN;
    }
    return orientation;
  }

  static double convertOrientationToRadian(CameraOrientations orientation) {
    double radians;
    switch (orientation) {
      case CameraOrientations.LANDSCAPE_LEFT:
        radians = -pi / 2;
        break;
      case CameraOrientations.LANDSCAPE_RIGHT:
        radians = pi / 2;
        break;
      case CameraOrientations.PORTRAIT_UP:
        radians = 0.0;
        break;
      case CameraOrientations.PORTRAIT_DOWN:
        radians = pi;
        break;
      default:
    }
    return radians;
  }

  static bool isOnPortraitMode(CameraOrientations orientation) {
    return (orientation == CameraOrientations.PORTRAIT_DOWN ||
        orientation == CameraOrientations.PORTRAIT_UP);
  }
}

// void main() {
//   runApp(AwesomeCameraScreen());
// }
//
// var globalCameraKey = GlobalKey();
// var globalCameraKey2 = GlobalKey();
//
// class AwesomeCameraScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       routes: {
//         '/': (context) => MyHomePage(title: 'CameraAwesome'),
//         '/full': (context) => Scaffold(
//           body: Hero(
//             tag: 'camera',
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Scaffold(
//                 appBar: AppBar(),
//                 body: CameraView(fit: false),
//               ),
//             ),
//           ),
//         ),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Hero(
//         tag: 'camera',
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushNamed('/full');
//           },
//           child: Center(
//             child: Container(height: 400, child: CameraView()),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CameraView extends StatelessWidget {
//   final _switchFlash = ValueNotifier(CameraFlashes.NONE);
//   final _sensor = ValueNotifier(Sensors.BACK);
//   final _photoSize = ValueNotifier<Size>(null);
//   final _captureMode = ValueNotifier(CaptureModes.PHOTO);
//   final cameraKey = ValueKey("camera");
//   final bool fit;
//
//   CameraView({Key key, this.fit = true}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CameraAwesome(
//       key: cameraKey,
//       testMode: false,
//       captureMode: _captureMode,
//       onPermissionsResult: (result) {},
//       selectDefaultSize: (availableSizes) => availableSizes.first,
//       onCameraStarted: () {},
//       onOrientationChanged: (newOrientation) {},
//       sensor: _sensor,
//       photoSize: _photoSize,
//       switchFlashMode: _switchFlash,
//       orientation: DeviceOrientation.portraitUp,
//       fitted: fit,
//     );
//   }
// }