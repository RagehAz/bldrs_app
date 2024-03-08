part of slide_video_editor;

class VideoEditorPanelSwitcher extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorPanelSwitcher({
    required this.videoEditorController,
    required this.selectedButton,
    required this.onConfirmCrop,
    super.key
  });
  // --------------------
  final VideoEditorController? videoEditorController;
  final String? selectedButton;
  final Function onConfirmCrop;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
  // --------------------
    final bool _isInitialized = Mapper.boolIsTrue(videoEditorController?.initialized);
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const double _panelHeight = VideoEditorScales.editorPanelHeight;
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _panelHeight,
      child: Builder(
        builder: (_){

          /// TRIM BAR
          if (_isInitialized == true && selectedButton == VideoEditorScales.trimButtonID){
            return VideoEditorTrimPanel(
                controller: videoEditorController!,
            );
          }

          /// CROP BAR
          else if (_isInitialized == true && selectedButton == VideoEditorScales.cropButtonID){
            return FloatingList(
              width: _screenWidth,
              height: _panelHeight,
              boxColor: Colorz.bloodTest,
              scrollDirection: Axis.horizontal,
              columnChildren: [

                /// FREE
                BldrsBox(
                  height: _panelHeight - 10,
                  width: 100,
                  verse: Verse.plain('Free'),
                  onTap: (){
                    videoEditorController?.cropAspectRatio(null);
                  },
                ),

                /// 1 / 1
                BldrsBox(
                  height: _panelHeight - 10,
                  width: 100,
                  verse: Verse.plain('1/1'),
                  onTap: (){
                    videoEditorController?.cropAspectRatio(1);
                  },
                ),

                /// 16 / 9
                BldrsBox(
                  height: _panelHeight - 10,
                  width: 100,
                  verse: Verse.plain('16/9'),
                  // bubble: true,
                  onTap: (){
                    videoEditorController?.cropAspectRatio(16/9);
                  },
                ),

                /// CONFIRM CROP
                BldrsBox(
                  height: _panelHeight - 10,
                  width: 100,
                  verse: Verse.plain('Crop'),
                  // bubble: true,
                  onTap: onConfirmCrop,
                ),

              ],
            );
          }

          /// COVERS SELECTION BAR
          else if (_isInitialized == true && selectedButton == VideoEditorScales.coverButtonID){
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
