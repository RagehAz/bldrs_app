import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/cropper/cropper_corner.dart';
import 'package:bldrs/b_views/z_components/cropper/cropping_screen.dart';
import 'package:bldrs/b_views/z_components/layouts/keep_alive_page.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class CropperPages extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const CropperPages({
    @required this.pageController,
    @required this.screenHeight,
    @required this.currentImageIndex,
    @required this.originalBytezz,
    @required this.aspectRatio,
    @required this.statuses,
    @required this.croppedImages,
    @required this.controllers,
    @required this.mounted,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final PageController pageController;
  final double screenHeight;
  final ValueNotifier<int> currentImageIndex;
  final List<Uint8List> originalBytezz;
  final double aspectRatio;
  final ValueNotifier<List<CropStatus>> statuses;
  final ValueNotifier<List<Uint8List>> croppedImages;
  final List<CropController> controllers;
  final bool mounted;
  // -----------------------------------------------------------------------------
  ///
  void _updateCropStatus({
    @required int index,
    @required CropStatus status,
    @required bool mounted,
  }){
    if (statuses.value[index] != status){

      final List<CropStatus> _list = <CropStatus>[...statuses.value];
      _list[index] = status;

      setNotifier(
          notifier: statuses,
          mounted: mounted,
          value: _list,
      );

    }
  }
  /// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _imageSpaceHeight = CroppingScreen.getImagesZoneHeight(
      screenHeight: screenHeight,
    );

    return SizedBox(
      width: _screenWidth,
      height: _imageSpaceHeight,
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: originalBytezz.length,
          onPageChanged: (int index){

            setNotifier(
                notifier: currentImageIndex,
                mounted: mounted,
                value: index,
            );

          },
          itemBuilder: (_, int index){

            if (originalBytezz == null || originalBytezz.isEmpty == true){
              return Container(
                width: _screenWidth,
                height: _imageSpaceHeight,
                color: Colorz.black255,
                child: const SuperVerse(
                  verse: Verse(
                    pseudo: 'Image format is inCompatible\nPlease select another Image',
                    text: 'phid_image_format_incompatible',
                    translate: true,
                  ),
                  maxLines: 3,
                ),
              );
            }

            else {
              return KeepAlivePage(
                child: Container(
                  key: PageStorageKey<String>('image_$index'),
                  width: _screenWidth,
                  height: _imageSpaceHeight,
                  color: Colorz.black255,
                  child: Crop(
                    image: originalBytezz[index],
                    controller: controllers[index],
                    onCropped: (dynamic image) async {
                      croppedImages.value[index] = image;
                    },
                    aspectRatio: aspectRatio,
                    // fixArea: false,
                    // withCircleUi: false,
                    // initialSize: 0.5,
                    // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                    // initialAreaBuilder: (rect) => Rect.fromLTRB(
                    //     rect.left + 24, rect.top + 32, rect.right - 24, rect.bottom - 32
                    // ),
                    baseColor: Colorz.black255,
                    maskColor: Colorz.black125,
                    // radius: 0,
                    onMoved: (Rect newRect) {
                      _updateCropStatus(
                        index: index,
                        status: CropStatus.cropping,
                        mounted: mounted,
                      );

                    },
                    onStatusChanged: (CropStatus status) {

                      _updateCropStatus(
                        index: index,
                        status: status,
                        mounted: mounted,
                      );

                    },
                    cornerDotBuilder: (double size, EdgeAlignment edgeAlignment){
                      return const CropperCorner();
                    },
                    // interactive: false,
                    // fixArea: true,
                  ),
                ),
              );
            }

          }
      ),
    );

  }
  /// -----------------------------------------------------------------------------
}
