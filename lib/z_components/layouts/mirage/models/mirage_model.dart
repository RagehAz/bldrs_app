// ignore_for_file: unused_field
part of mirage;

/// => TAMAM
class _MirageModel {
  // -----------------------------------------------------------------------------
  const _MirageModel({
    required this.position,
    required this.stripHeight,
    required this.selectedButton,
    required this.index,
    this.pyramidIsOn,
  });
  // --------------------
  final ValueNotifier<double> position;
  final double stripHeight;
  final ValueNotifier<bool>? pyramidIsOn;
  final ValueNotifier<String?> selectedButton;
  final int index;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const double standardStripHeight = Pyramids.khafreHeight;
  static const double stripExitLimit = standardStripHeight * 0.3;
  static const double draggerHeight = 2;
  // --------------------
  static const double draggerCornerValue = draggerHeight/2;
  static const BorderRadius draggerCorners = BorderRadius.all(Radius.circular(draggerCornerValue));
  // --------------------
  static const Color draggerColor = Colorz.white20;
  static const Color buttonColor = Colorz.black200;
  static const Color selectedButtonColor = Colorz.yellow125;
  static const Color textColor = Colorz.white255;
  static const Color selectedTextColor = Colorz.black255;
// --------------------
  static const int slidingDurationValue = 150;
  static const Duration slidingDuration = Duration(milliseconds: slidingDurationValue);
  static const Duration waitDuration = Duration(milliseconds: 250);
  // -----------------------------------------------------------------------------

  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static _MirageModel initialize({
    required double height,
    required int index,
    bool controlPyramid = false,
    String? selectedButton,
  }){
    return _MirageModel(
      position: ValueNotifier(height),
      index: index,
      stripHeight: height,
      pyramidIsOn: controlPyramid == true ? ValueNotifier(true) : null,
      selectedButton: ValueNotifier(selectedButton),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    position.dispose();
    pyramidIsOn?.dispose();
    selectedButton.dispose();
  }
  // -----------------------------------------------------------------------------

  /// SHOW & HIDE

  // --------------------
  /// TESTED : WORKS PERFECT
  void show({
    required bool mounted,
  }){
    setNotifier(
      notifier: position,
      mounted: mounted,
      value: 0.0,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> reShow({
    required bool mounted,
    Function? onBetweenReShow,
  }) async {

    if (checkIsOpened() == true){
      hide(mounted: mounted);
      await _MirageModel.waitAnimation();
    }

    await onBetweenReShow?.call();

    show(mounted: mounted);
    await _MirageModel.waitAnimation();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void hide({
    required bool mounted,
  }){
    setNotifier(
      notifier: position,
      mounted: mounted,
      value: stripHeight,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> waitAnimation() async {
    await Future.delayed(waitDuration);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> hideMiragesAbove({
    required List<_MirageModel> allMirages,
    required _MirageModel aboveThisMirage,
    required bool mounted,
  }) async {

    final List<_MirageModel> _miragesAbove = _MirageModel.getMiragesAbove(
      allMirages: allMirages,
      aboveIndex: aboveThisMirage.index,
    );

    _MirageModel.hideMirages(
        models: _miragesAbove,
        mounted: mounted
    );

    await _MirageModel.waitAnimation();

  }
  // -----------------------------------------------------------------------------

  /// DRAG LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void onDragUpdate({
    required DragUpdateDetails details,
    required bool mounted,
    required List<_MirageModel> miragesAbove,
    Function? onHide,
  }) {

    final double newPosition = (position.value + details.primaryDelta!).clamp(0.0, stripHeight);

    setNotifier(
      notifier: position,
      mounted: mounted,
      value: newPosition,
    );

    if (newPosition > stripExitLimit) {

      /// SHOW PYRAMID
      showPyramid(mounted: mounted);

      /// HIDE ALL ABOVE STRIPS
      hideMirages(mounted: mounted, models: miragesAbove);

      onHide?.call();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onDragEnd({
    required DragEndDetails details,
    required bool mounted,
    Function? onShow,
    Function? onHide,
  }) {
    if (checkIsInShowingRange() == true) {
      show(mounted: mounted);
      onShow?.call();
      hidePyramid(mounted: mounted);
    }
    else {
      hide(mounted: mounted);
      onHide?.call();
      showPyramid(mounted: mounted);

    }
  }
  // -----------------------------------------------------------------------------

  /// PYRAMID CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  void showPyramid({
    required bool mounted,
  }){
    if (pyramidIsOn != null){
      setNotifier(notifier: pyramidIsOn, mounted: mounted, value: true);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void hidePyramid({
    required bool mounted,
  }){
    if (pyramidIsOn != null){
      setNotifier(notifier: pyramidIsOn, mounted: mounted, value: false);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onPyramidTap({
    required bool mounted,
  }){

    if (pyramidIsOn != null){

      if (pyramidIsOn!.value == true){

        /// HIDE PYRAMID
        hidePyramid(mounted: mounted);

        /// SHOW STRIP
        show(mounted: mounted);

      }

      /// THIS WILL NEVER HAPPEN : BUT ANYWAYS IT SHOULD DO THIS
      // else {
      //
      //   /// SHOW PYRAMID
      //   showPyramid(mounted: mounted);
      //
      //   /// HIDE ALL STRIPS
      //   MirageModel.hideMirages(
      //     mounted: mounted,
      //     models: [_mirage1, _mirage2, _mirage3, _mirage4, _mirage5],
      //   );
      //
      // }

    }

  }
  // -----------------------------------------------------------------------------

  /// POSITION CHECKERS

  // --------------------
  bool checkIsOpened(){

    if (position.value == 0){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  bool checkIsClosed(){

    if (position.value == stripHeight){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  bool checkIsInShowingRange(){
    if (position.value <= stripExitLimit){
      return true;
    }
    else {
      return false;
    }
  }
  // -----------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void hideMirages({
    required List<_MirageModel> models,
    required bool mounted,
  }){

    if (Lister.checkCanLoop(models) == true){

      for (final _MirageModel model in models){
        model.hide(mounted: mounted);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> hideAllAndShowPyramid({
    required List<_MirageModel> models,
    required _MirageModel mirage0,
    required bool mounted,
  }) async {

    _MirageModel.hideMirages(models: models, mounted: mounted);
    mirage0.showPyramid(mounted: mounted);
    await _MirageModel.waitAnimation();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void disposeMirages({
    required List<_MirageModel> models,
  }){

    if (Lister.checkCanLoop(models) == true){

      for (final _MirageModel model in models){
        model.dispose();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SCALES

  // --------------------
  double getClearHeight(){
    return stripHeight - draggerHeight;
  }
  // --------------------
  double getWidth(){
    return Scale.screenWidth(getMainContext());
  }
  // -----------------------------------------------------------------------------

  /// SELECTED BUTTON

  // --------------------
  /// TESTED : WORKS PERFECT
  void selectButton({
    required String? button,
    required bool mounted,
  }){

    setNotifier(
        notifier: selectedButton,
        mounted: mounted,
        value: button
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearButton({
    required bool mounted
  }){
    selectButton(button: null,mounted: mounted);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void clearAllMirageButtons({
    required List<_MirageModel> mirages,
    required bool mounted,
  }){

    if (Lister.checkCanLoop(mirages) == true){
      for (final _MirageModel mirage in mirages){
        mirage.clearButton(mounted: mounted);
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<_MirageModel> getMiragesAbove({
    required List<_MirageModel> allMirages,
    /// this index is excluded from the output
    required int aboveIndex,
  }){
    final List<_MirageModel> _output = [];

    for (int i = 0; i < allMirages.length; i++){

      if (i < aboveIndex){
        // blog('removed mirage $i');
      }
      else if (i == aboveIndex){
        // blog('removed mirage $i');
      }
      else {
        _output.add(allMirages[i]);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Duration getMirageDuration({
    required _MirageModel mirage,
  }){

    const int value = _MirageModel.slidingDurationValue;

    return Duration(
        milliseconds: value + (value * mirage.index * 0.2).toInt(),
    );

  }
  // -----------------------------------------------------------------------------
}
