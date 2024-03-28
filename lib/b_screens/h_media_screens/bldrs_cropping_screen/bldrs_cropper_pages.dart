import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/handlers/keep_alive_page.dart';
import 'package:basics/mediator/pic_maker/cropping_screen/cropper_corner.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class BldrsCropperPages extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BldrsCropperPages({
    required this.pageController,
    required this.currentImageIndex,
    required this.originalBytezz,
    required this.aspectRatio,
    required this.statuses,
    required this.croppedImages,
    required this.controllers,
    required this.mounted,
    required this.panelIsOn,
    super.key
  });
  // -----------------------------------------------------------------------------
  final PageController pageController;
  final ValueNotifier<int> currentImageIndex;
  final List<Uint8List>? originalBytezz;
  final double aspectRatio;
  final ValueNotifier<List<CropStatus>> statuses;
  final ValueNotifier<List<Uint8List>?> croppedImages;
  final List<CropController> controllers;
  final bool mounted;
  final bool panelIsOn;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _updateCropStatus({
    required int index,
    required CropStatus status,
    required bool mounted,
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _imageSpaceHeight = EditorScale.mediaZoneHeight(
      panelIsOn: panelIsOn,
    );

    return SizedBox(
      width: _screenWidth,
      height: _imageSpaceHeight,
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          scrollBehavior: const AppScrollBehavior(),
          itemCount: originalBytezz?.length,
          onPageChanged: (int index){
            setNotifier(
              notifier: currentImageIndex,
              mounted: mounted,
              value: index,
            );
          },
          itemBuilder: (_, int index){

            if (Lister.checkCanLoop(originalBytezz) == false){
              return Container(
                width: _screenWidth,
                height: _imageSpaceHeight,
                color: Colorz.black255,
                child: const SuperText(
                  text: 'phid_image_format_incompatible',
                  maxLines: 3,
                ),
              );
            }

            else {

              /// the_smart_crop_work_around
              return KeepAlivePage(
                child: Container(
                  key: PageStorageKey<String>('image_$index'),
                  width: _screenWidth,
                  height: _imageSpaceHeight,
                  alignment: Alignment.center,
                  child: Crop(
                    image: originalBytezz![index],
                    controller: controllers[index],
                    onCropped: (dynamic image) async {
                      croppedImages.value![index] = image;
                    },
                    aspectRatio: aspectRatio,
                    // fixArea: false,
                    // withCircleUi: true,
                    initialSize: 0.95,
                    // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                    // initialAreaBuilder: (rect) => Rect.fromLTRB(
                    //     rect.left + 24, rect.top + 32, rect.right - 24, rect.bottom - 32
                    // ),
                    baseColor: Colorz.black255,
                    maskColor: Colorz.black150,
                    // radius: 30, // crop area corners
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
  // -----------------------------------------------------------------------------
}
