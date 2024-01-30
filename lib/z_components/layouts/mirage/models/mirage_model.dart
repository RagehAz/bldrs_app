// ignore_for_file: unused_field, unused_element
part of mirage;

/// => TAMAM
class MirageModel {
  // -----------------------------------------------------------------------------
  const MirageModel({
    required this.position,
    required this.selectedButton,
    required this.index,
    required this.controller,
    this.pyramidIsOn,
  });
  // --------------------
  final ValueNotifier<double> position;
  final ValueNotifier<bool>? pyramidIsOn;
  final ValueNotifier<String?> selectedButton;
  final ItemScrollController controller;
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
  static MirageModel initialize({
    required int index,
    bool controlPyramid = false,
    String? selectedButton,
  }){
    return MirageModel(
      position: ValueNotifier(standardStripHeight * (index + 1)),
      index: index,
      pyramidIsOn: controlPyramid == true ? ValueNotifier(true) : null,
      selectedButton: ValueNotifier(selectedButton),
      controller: ItemScrollController(),
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
      await MirageModel.waitAnimation();
    }

    await onBetweenReShow?.call();

    show(mounted: mounted);
    await MirageModel.waitAnimation();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void hide({
    required bool mounted,
  }){
    setNotifier(
      notifier: position,
      mounted: mounted,
      value: getHeight(),
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
    required int index,
    required bool mounted,
  }) async {

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
      context: getMainContext(),
      listen: false,
    );

    final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
      allMirages: allMirages,
      aboveIndex: index,
    );

    MirageModel.hideMirages(
        models: _miragesAbove,
        mounted: mounted
    );

    await MirageModel.waitAnimation();

  }
  // -----------------------------------------------------------------------------

  /// DRAG LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void onDragUpdate({
    required DragUpdateDetails details,
    required bool mounted,
    required List<MirageModel> miragesAbove,
    Function? onHide,
  }) {

    final double newPosition = (position.value + details.primaryDelta!).clamp(0.0, getHeight());

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
  double getHeight(){
    return standardStripHeight * (index + 1);
  }

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

    if (position.value == getHeight()){
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
    required List<MirageModel> models,
    required bool mounted,
  }){

    if (Lister.checkCanLoop(models) == true){

      for (final MirageModel model in models){
        model.hide(mounted: mounted);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> hideAllAndShowPyramid({
    required List<MirageModel> models,
    required MirageModel mirage0,
    required bool mounted,
  }) async {

    MirageModel.hideMirages(models: models, mounted: mounted);
    mirage0.showPyramid(mounted: mounted);
    await MirageModel.waitAnimation();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void disposeMirages({
    required List<MirageModel> models,
  }){

    if (Lister.checkCanLoop(models) == true){

      for (final MirageModel model in models){
        model.dispose();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SCALES

  // --------------------
  double getClearHeight(){
    return getHeight() - draggerHeight;
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
    required List<MirageModel> mirages,
    required bool mounted,
  }){

    if (Lister.checkCanLoop(mirages) == true){
      for (final MirageModel mirage in mirages){
        mirage.clearButton(mounted: mounted);
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// ANIMATE TO BUTTON

  // --------------------
  Future<void> scrollTo({
    required int buttonIndex,
    required int listLength,
  }) async {

    final double _ratio = _getLeftOffsetRatio(
      listLength: listLength,
      buttonIndex: buttonIndex,
    );

    await controller.scrollTo(
      index: buttonIndex,
      duration: waitDuration,
      curve: Curves.easeOut,
      alignment: _ratio,
      // opacityAnimationWeights: ,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getLeftOffsetRatio({
    required int buttonIndex,
    required int listLength,
  }){

  final double _screenWidth = Scale.screenWidth(getMainContext());
  final bool _isFirst = buttonIndex == 0;
  final bool _isPreLast = buttonIndex + 2 == listLength;
  final bool _isLast = buttonIndex + 1 == listLength;

  /// OFFSET FROM LEFT
  double _offset = 10;

  /// FIRST
  if (_isFirst == true){
    _offset = 10;
  }
  /// LAST
  else if (_isLast == true){
    _offset = _screenWidth - 130;
  }
  /// PRE LAST
  else if (_isPreLast == true){
    _offset = _screenWidth * 0.5;
  }
  /// MIDDLE
  else {
    _offset = _screenWidth * 0.3;
  }

  // blog('_getLeftOffsetRatio : _leftOffset : $_offset : buttonIndex : $buttonIndex');

  /// RATIO
  return _offset / _screenWidth;
}

  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<MirageModel> getMiragesAbove({
    required List<MirageModel> allMirages,
    /// this index is excluded from the output
    required int aboveIndex,
  }){
    final List<MirageModel> _output = [];

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
    required MirageModel mirage,
  }){

    const int value = MirageModel.slidingDurationValue;

    return Duration(
        milliseconds: value + (value * mirage.index * 0.2).toInt(),
    );

  }
  // -----------------------------------------------------------------------------
}
