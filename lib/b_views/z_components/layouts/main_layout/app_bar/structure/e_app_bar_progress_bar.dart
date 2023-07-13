part of bldrs_app_bar;

class AppBarProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarProgressBar({
    required this.loading,
    required this.progressBarModel,
    required this.appBarType,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final AppBarType? appBarType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _abWidth = BldrsAppBar.width();
    // --------------------
    final double _appBarHeight = BldrsAppBar.collapsedHeight(context, appBarType);
    // --------------------
    final EdgeInsets _margins = EdgeInsets.only(
        top: _appBarHeight - FlyerDim.progressStripThickness(_abWidth)
    );
    // --------------------
    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (_, bool isLoading, Widget? child){

        if (isLoading == true){
          return StaticProgressBar(
            index: 0,
            numberOfSlides: 1,
            opacity: 0.4,
            swipeDirection: SwipeDirection.freeze,
            flyerBoxWidth: _abWidth,
            margins: _margins,
            stripThicknessFactor: 0.4,
          );
        }

        else if (progressBarModel != null){
          return ValueListenableBuilder(
              valueListenable: progressBarModel!,
              builder: (_, ProgressBarModel? progressBarModel, Widget? childB){

                // blog('progressBarModel?.stripsColors : ${progressBarModel?.stripsColors}');
                // blog('progressBarModel?.index : ${progressBarModel?.index}');
                // blog('progressBarModel?.numberOfStrips : ${progressBarModel?.numberOfStrips}');

                return StaticProgressBar(
                  index: progressBarModel?.index ?? 0,
                  numberOfSlides: progressBarModel?.numberOfStrips ?? 1,
                  opacity: 1,
                  swipeDirection: progressBarModel?.swipeDirection ?? SwipeDirection.freeze,
                  loading: isLoading,
                  flyerBoxWidth: _abWidth,
                  margins: _margins,
                  stripThicknessFactor: 0.4,
                  stripsColors: progressBarModel?.stripsColors,// ?? const [Colorz.white10],
                );

              }
          );
        }

        else {
          return const SizedBox();
        }

      },
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
