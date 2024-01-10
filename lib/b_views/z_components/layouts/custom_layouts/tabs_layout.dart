import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:basics/helpers/widgets/layers/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class TabsLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TabsLayout({
    required this.views,
    required this.title,
    required this.canSwipeBack,
    this.appBarRowWidgets,
    this.onBack,
    this.loading,
    super.key
  });
  /// -----------------------
  final List<NavModel> views;
  final Verse? title;
  final List<Widget>? appBarRowWidgets;
  final Function? onBack;
  final ValueNotifier<bool>? loading;
  final bool canSwipeBack;
  /// --------------------------------------------------------------------------
  @override
  _TabsLayoutState createState() => _TabsLayoutState();
  /// --------------------------------------------------------------------------
  static double getPageHeight(){
    final double _screenHeight = Scale.screenHeight(getMainContext());
    // final double _stratosphere = Stratosphere.stratosphereSandwich.top;
    // const double _footerHeight = 50;
    // final double _pageHeight = _screenHeight - _stratosphere - _footerHeight;
    return _screenHeight;
  }
  /// --------------------------------------------------------------------------
  static const double footerHeight = 50;
  /// --------------------------------------------------------------------------
}

class _TabsLayoutState extends State<TabsLayout> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  late ValueNotifier<ProgressBarModel?> _progressBarModel;
  late PageController _pageController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _progressBarModel = ValueNotifier(ProgressBarModel.initialModel(
      numberOfStrips: widget.views.length,
    ));
    _pageController = PageController();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {
        
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _pageController.dispose();
    _progressBarModel.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onSwipeTo({
    required int index
  }) async {

    Sliders.snapTo(
        pageController: _pageController,
        toIndex: index,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _pageHeight = TabsLayout.getPageHeight();
    final double _footerButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: widget.views.length,
      boxWidth: _screenWidth,
      considerMargins: false,
      spacing: 0,
    );
    const double _footerButtonHeight = TabsLayout.footerHeight - 10;
    // --------------------
    return MainLayout(
      canSwipeBack: widget.canSwipeBack,
      title: widget.title,
      progressBarModel: _progressBarModel,
      loading: widget.loading ?? _loading,
      appBarRowWidgets: widget.appBarRowWidgets,
      onBack: widget.onBack,
      child: Stack(
        children: <Widget>[

          /// PAGES
          PagerBuilder(
            height: _pageHeight,
            progressBarModel: _progressBarModel,
            pageController: _pageController,
            pageBubbles: <Widget>[

              ...List.generate(widget.views.length, (index){
                
                final Widget _view = widget.views[index].screen;
                
                return _view;
                
              }),

            ],
          ),

          /// FOOTER
          Positioned(
            bottom: 0,
            child: BlurLayer(
              width: _screenWidth,
              height: TabsLayout.footerHeight,
              color: Colorz.black50,
              blurIsOn: true,
              child: ValueListenableBuilder(
                  valueListenable: _progressBarModel,
                  builder: (context, ProgressBarModel? model, Widget? child) {
                    return Row(
                      children: <Widget>[

                        ...List.generate(widget.views.length, (index){

                          final NavModel _view = widget.views[index];

                          return BldrsBox(
                            height: _footerButtonHeight,
                            width: _footerButtonWidth,
                            icon: _view.icon,
                            iconSizeFactor: 0.6,
                            verse: Verse.plain(_view.titleVerse?.id ?? ''),
                            color: model?.index == index ? Colorz.yellow255 : Colorz.white10,
                            verseColor: model?.index == index ? Colorz.black255 : Colorz.white255,
                            iconColor: model?.index == index ? Colorz.black255 : Colorz.white255,
                            verseCentered: false,
                            onTap: () => _onSwipeTo(index: index),
                          );

                        }),
                      ],
                    );
                  }
                  ),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
