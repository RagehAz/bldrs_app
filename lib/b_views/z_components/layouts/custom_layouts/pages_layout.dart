import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';

class PagesLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PagesLayout({
    @required this.pageBubbles,
    this.pyramidButtons,
    this.appBarRowWidgets,
    this.title,
    Key key
  }) : super(key: key);

  final List<Widget> pageBubbles;
  final List<Widget> pyramidButtons;
  final List<Widget> appBarRowWidgets;
  final Verse title;
  /// --------------------------------------------------------------------------
  @override
  _PagesLayoutState createState() => _PagesLayoutState();
  /// --------------------------------------------------------------------------
}

class _PagesLayoutState extends State<PagesLayout> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
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

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _pageController.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant PagesLayout oldWidget) {
    if (widget.pageBubbles != oldWidget.pageBubbles) {
      setState(() {});
      _initializeProgressBarModel();
    }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  void _initializeProgressBarModel() {
    _progressBarModel.value = ProgressBarModel(
      swipeDirection: SwipeDirection.freeze,
      index: 0,
      numberOfStrips: widget.pageBubbles.length,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      pageTitleVerse: widget.title,
      skyType: SkyType.black,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      pyramidButtons: widget.pyramidButtons,
      appBarRowWidgets: widget.appBarRowWidgets,
      layoutWidget: SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int index) => ProgressBarModel.onSwipe(
            context: context,
            newIndex: index,
            progressBarModel: _progressBarModel,
          ),
          children: <Widget>[

            ...List.generate(widget.pageBubbles.length, (index){

              return widget.pageBubbles[index];

            }),

          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
