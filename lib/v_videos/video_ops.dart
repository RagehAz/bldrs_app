import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_session.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_min/return_code.dart';
import 'package:ffmpeg_kit_flutter_min/statistics.dart';

class VideoOps {
  // --------------------------------------------------------------------------

  const VideoOps();

  // --------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  /// TAKEN METHOD
  static Future<void> disposeFFmpegKit() async {
    final List<FFmpegSession> executions = await FFmpegKit.listSessions();
    if (executions.isNotEmpty) {
      await FFmpegKit.cancel();
    }
  }
  // --------------------------------------------------------------------------

  /// EXECUTION

  // --------------------
  /// TAKEN METHOD
  static Future<FFmpegSession> runFFmpegCommand({
    required FFmpegVideoEditorExecute execute,
    required void Function(File file) onCompleted,
    void Function(Object, StackTrace)? onError,
    void Function(Statistics)? onProgress,
  }) {

    blog('FFmpeg start process with command = ${execute.command}');

    return FFmpegKit.executeAsync(
      execute.command,
          (session) async {

        final String state = FFmpegKitConfig.sessionStateToString(await session.getState());
        final ReturnCode? code = await session.getReturnCode();

        if (ReturnCode.isSuccess(code)) {
          onCompleted(File(execute.outputPath));
        }

        else {
          if (onError != null) {
            onError(Exception('FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}'),
              StackTrace.current,
            );
          }
          return;
        }
      },
      null,
      onProgress,
    );

  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions? getVideoDimensions({
    required VideoEditorController? controller,
  }){
   if (controller == null){
     return null;
   }
   else {
     return Dimensions(
         width: controller.videoWidth,
         height: controller.videoHeight,
     );
   }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getFileSize({
    required VideoEditorController? controller,
    required FileSizeUnit unit,
  }){

    if (controller == null){
      return null;
    }

    else {
      final File? _file = controller.file;
      return Filers.getFileSizeWithUnit(
          file: _file,
          unit: unit,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getSizeMbString({
    required File? file,
  }){

    final double _size = Filers.getFileSizeWithUnit(
        file: file,
        unit: FileSizeUnit.megaByte
      ) ?? 0;

    return '$_size MB';
  }
  // --------------------------------------------------------------------------

  /// STYLING

  // --------------------
  static CoverSelectionStyle getCoverStyle = const CoverSelectionStyle(
      borderRadius: 0,
      borderWidth: 1,
      selectedBorderColor: Colorz.yellow255,
    );
  // --------------------
  static CropGridStyle getCropStyle = const CropGridStyle(
    // background: Colorz.black255,
    croppingBackground: Colorz.black150,
    /// CORNERS
    boundariesColor: Colorz.white200,
    selectedBoundariesColor: Colorz.yellow255,
    boundariesLength: 10, /// CORNER LINE LENGTH
    boundariesWidth: 2, /// CORNER LINE THICKNESS
    ///GRID
    // gridSize: 3, /// NUMBER OF GRID SECTIONS
    // gridLineWidth: 1, /// GRID LINE THICKNESS
    gridLineColor: Colorz.white125,
  );
  // --------------------
  static TrimSliderStyle getTrimStyle = const TrimSliderStyle(
    background: Colorz.black125,
    borderRadius: 20,
    /// SIDE EDGE
    edgesSize: 25,
    // edgesType: TrimSliderEdgesType.bar, /// THE SIDE EDGE STYLE : A DOT OR VERTICAL BAR
    /// LINE
    lineWidth: 1, /// TOP AND BOTTOM LINE THICKNESS
    lineColor: Colorz.white255,
    onTrimmedColor: Colorz.white255, /// WHEN TRIMMED
    onTrimmingColor: Colorz.white255, /// WHILE TRIMMING
    /// POSITION LINE
    positionLineColor: Colorz.yellow255,
    positionLineWidth: 15,
    /// ICON
    // iconColor: Colorz.black255,
    iconSize: 25,
    leftIcon: Icons.arrow_left,
    rightIcon: Icons.arrow_right,
  );
  // --------------------------------------------------------------------------

  /// FORMATTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String formatDuration(Duration duration){
    return [
      duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
      duration.inSeconds.remainder(60).toString().padLeft(2, '0')
    ].join(':');
  }
  // --------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogVideoEditorController({
    required VideoEditorController? controller,
  }){

    if (controller == null){
      blog('controller is null');
    }

    else {

      blog('controller.file : ${controller.file}');
      blog('controller.video : ${controller.video}');
      blog('controller.initialized : ${controller.initialized}');
      blog('controller.isPlaying : ${controller.isPlaying}');
      blog('controller.cacheMaxCrop : ${controller.cacheMaxCrop}');
      blog('controller.cacheMinCrop : ${controller.cacheMinCrop}');
      blog('controller.croppedArea : ${controller.croppedArea}');
      blog('controller.cropStyle.background : ${controller.cropStyle.background}');
      blog('controller.cropStyle.boundariesColor : ${controller.cropStyle.boundariesColor}');
      blog('controller.cropStyle.boundariesLength : ${controller.cropStyle.boundariesLength}');
      blog('controller.cropStyle.boundariesWidth : ${controller.cropStyle.boundariesWidth}');
      blog('controller.cropStyle.croppingBackground : ${controller.cropStyle.croppingBackground}');
      blog('controller.cropStyle.gridLineColor : ${controller.cropStyle.gridLineColor}');
      blog('controller.cropStyle.gridLineWidth : ${controller.cropStyle.gridLineWidth}');
      blog('controller.cropStyle.boundariesColor : ${controller.cropStyle.boundariesColor}');
      blog('controller.cropStyle.gridSize : ${controller.cropStyle.gridSize}');
      blog('controller.cropStyle.selectedBoundariesColor : ${controller.cropStyle.selectedBoundariesColor}');
      blog('controller.isCropping : ${controller.isCropping}');
      blog('controller.maxCrop : ${controller.maxCrop}');
      blog('controller.minCrop : ${controller.minCrop}');
      blog('controller.cacheRotation : ${controller.cacheRotation}');
      blog('controller.isRotated : ${controller.isRotated}');
      blog('controller.rotation : ${controller.rotation}');
      blog('controller.coverStyle.borderRadius : ${controller.coverStyle.borderRadius}');
      blog('controller.coverStyle.borderWidth : ${controller.coverStyle.borderWidth}');
      blog('controller.coverStyle.selectedBorderColor : ${controller.coverStyle.selectedBorderColor}');
      blog('controller.coverThumbnailsQuality : ${controller.coverThumbnailsQuality}');
      blog('controller.selectedCoverNotifier.timeMs : ${controller.selectedCoverNotifier.value?.timeMs}');
      blog('controller.selectedCoverNotifier.thumbData : ${controller.selectedCoverNotifier.value?.thumbData}');
      blog('controller.selectedCoverVal.thumbData : ${controller.selectedCoverVal?.thumbData}');
      blog('controller.selectedCoverVal.timeMs : ${controller.selectedCoverVal?.timeMs}');
      blog('controller.isTrimmed : ${controller.isTrimmed}');
      blog('controller.minTrim : ${controller.minTrim}');
      blog('controller.maxTrim : ${controller.maxTrim}');
      blog('controller.endTrim : ${controller.endTrim}');
      blog('controller.startTrim : ${controller.startTrim}');
      blog('controller.trimmedDuration : ${controller.trimmedDuration}');
      blog('controller.trimPosition : ${controller.trimPosition}');
      blog('controller.trimStyle.borderRadius : ${controller.trimStyle.borderRadius}');
      blog('controller.trimStyle.background : ${controller.trimStyle.background}');
      blog('controller.trimStyle.iconColor : ${controller.trimStyle.iconColor}');
      blog('controller.trimStyle.edgesSize : ${controller.trimStyle.edgesSize}');
      blog('controller.trimStyle.edgesType : ${controller.trimStyle.edgesType}');
      blog('controller.trimStyle.edgeWidth : ${controller.trimStyle.edgeWidth}');
      blog('controller.trimStyle.iconSize : ${controller.trimStyle.iconSize}');
      blog('controller.trimStyle.leftIcon : ${controller.trimStyle.leftIcon}');
      blog('controller.trimStyle.lineColor : ${controller.trimStyle.lineColor}');
      blog('controller.trimStyle.lineWidth : ${controller.trimStyle.lineWidth}');
      blog('controller.trimStyle.onTrimmedColor : ${controller.trimStyle.onTrimmedColor}');
      blog('controller.trimStyle.onTrimmingColor : ${controller.trimStyle.onTrimmingColor}');
      blog('controller.trimStyle.positionLineColor : ${controller.trimStyle.positionLineColor}');
      blog('controller.trimStyle.positionLineWidth : ${controller.trimStyle.positionLineWidth}');
      blog('controller.trimStyle.rightIcon : ${controller.trimStyle.rightIcon}');
      blog('controller.trimThumbnailsQuality : ${controller.trimThumbnailsQuality}');
      blog('controller.minDuration : ${controller.minDuration}');
      blog('controller.maxDuration : ${controller.maxDuration}');
      blog('controller.videoDuration : ${controller.videoDuration}');
      blog('controller.videoDimension : ${controller.videoDimension}');
      blog('controller.videoWidth : ${controller.videoWidth}');
      blog('controller.videoHeight : ${controller.videoHeight}');
      blog('controller.videoPosition : ${controller.videoPosition}');

    }

  }
  // --------------------------------------------------------------------------
}
