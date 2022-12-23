import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class PagesLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PagesLayout({
    @required this.pageBubbles,
    this.pyramidButtons,
    this.appBarRowWidgets,
    this.title,
    this.progressBarModel,
    this.confirmButtonModel,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final List<Widget> pageBubbles;
  final List<Widget> pyramidButtons;
  final List<Widget> appBarRowWidgets;
  final Verse title;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final ConfirmButtonModel confirmButtonModel;
  // --------------------------------------------------------------------------
  @override
  _PagesLayoutState createState() => _PagesLayoutState();
  // --------------------------------------------------------------------------
}

class _PagesLayoutState extends State<PagesLayout> {
  // -----------------------------------------------------------------------------
  ValueNotifier<ProgressBarModel> _progressBarModel;
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

    if (widget.progressBarModel == null){
      _progressBarModel.dispose();
    }
    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant PagesLayout oldWidget) {
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
      _progressBarModel = widget.progressBarModel;
    }

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
      confirmButtonModel: widget.confirmButtonModel,
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
            mounted: mounted,
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
