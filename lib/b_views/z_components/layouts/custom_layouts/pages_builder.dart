import 'package:basics/animators/helpers/app_scroll_behavior.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

class PagerBuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PagerBuilder({
    required this.pageBubbles,
    this.progressBarModel,
    this.pageController,
    this.width,
    this.height,
    super.key
  });
  // --------------------------------------------------------------------------
  final List<Widget> pageBubbles;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final PageController? pageController;
  final double? width;
  final double? height;
  // --------------------------------------------------------------------------
  @override
  _PagerBuilderState createState() => _PagerBuilderState();
  // --------------------------------------------------------------------------
}

class _PagerBuilderState extends State<PagerBuilder> {
  // -----------------------------------------------------------------------------
  late ValueNotifier<ProgressBarModel?> _progressBarModel;
  late PageController _pageController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initializeProgressBarModel();

    _pageController = widget.pageController ?? PageController();

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();

    if (widget.pageController == null){
      _pageController.dispose();
    }

    if (widget.progressBarModel == null){
      _progressBarModel.dispose();
    }

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant PagerBuilder oldWidget) {
    if (widget.pageBubbles.length != oldWidget.pageBubbles.length) {
      setState(() {});
      _initializeProgressBarModel();
    }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  void _initializeProgressBarModel() {

    if (widget.progressBarModel == null){

      _progressBarModel = ValueNotifier(ProgressBarModel.initialModel(
          numberOfStrips: widget.pageBubbles.length,
      ));

    }

    else {
      _progressBarModel = widget.progressBarModel!;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width ?? Scale.screenWidth(context),
      height: widget.height ?? Scale.screenHeight(context),
      child: PageView(
        physics: const BouncingScrollPhysics(),
        scrollBehavior: const AppScrollBehavior(),
        controller: _pageController,
        onPageChanged: (int index) => ProgressBarModel.onSwipe(
          context: context,
          newIndex: index,
          progressBarModel: _progressBarModel,
          mounted: mounted,
        ),
        children: <Widget>[

          ...List.generate(widget.pageBubbles.length, (index){

            return widget.pageBubbles[index];

          }),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
