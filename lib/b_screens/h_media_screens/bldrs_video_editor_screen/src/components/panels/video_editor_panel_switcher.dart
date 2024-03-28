part of bldrs_video_editor;

class VideoEditorPanelSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorPanelSwitcher({
    required this.videoEditorController,
    required this.scrollController,
    required this.msPixelLength,
    required this.selectedButton,
    required this.onConfirmCrop,
    required this.onTimeChanged,
    required this.onHandleChanged,
    required this.onSetAspectRatio,
    super.key
  });
  // --------------------
  final VideoEditorController? videoEditorController;
  final ScrollController scrollController;
  final ValueNotifier<double> msPixelLength;
  final String? selectedButton;
  final Function onConfirmCrop;
  final Function(double? aspectRatio) onSetAspectRatio;
  final Function(int currentMs) onTimeChanged;
  final Function(int minMs, int maxMs) onHandleChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
  // --------------------
    final bool _isInitialized = Mapper.boolIsTrue(videoEditorController?.initialized);
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _panelHeight = EditorScale.panelZoneHeight(isOn: true);
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _panelHeight,
      child: Builder(
        builder: (_){

          /// TRIM BAR
          if (_isInitialized == true && selectedButton == VideoEditorNavBar.trimButtonID){
            return SuperTimeLine(
              videoEditorController: videoEditorController!,
              scrollController: scrollController,
              totalWidth: _screenWidth,
              height: _panelHeight,
              // limitScrollingBetweenHandles: false,
              msPixelLength: msPixelLength,
              onTimeChanged: onTimeChanged,
              onHandleChanged: onHandleChanged,
            );
          }

          /// CROP BAR
          else if (_isInitialized == true && selectedButton == VideoEditorNavBar.cropButtonID){
            return VideoCropPanel(
              onConfirmCrop: onConfirmCrop,
              onSetAspectRatio: onSetAspectRatio,
            );
          }

          /// COVERS SELECTION BAR
          else if (_isInitialized == true && selectedButton == VideoEditorNavBar.coverButtonID){
            return FloatingList(
              width: _screenWidth,
              height: _panelHeight,
              boxColor: Colorz.black255,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              columnChildren: <Widget>[

                CoverSelection(
                  controller: videoEditorController!,
                  // size: _editorBarHeight - 20,
                  quantity: 12,
                  wrap: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    textDirection: UiProvider.getAppTextDir(),
                  ),
                  selectedCoverBuilder: (cover, size) {

                    return RedDotBadge(
                      redDotIsOn: true,
                      shrinkChild: true,
                      approxChildWidth: size.width,
                      isNano: true,
                      color: Colorz.yellow255,
                      child: cover,
                    );

                  },
                ),

              ],
            );
          }

          /// NOTHING
          else {
            return const SizedBox();
          }

        },
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
