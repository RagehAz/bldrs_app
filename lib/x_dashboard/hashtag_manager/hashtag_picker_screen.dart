import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/hashtag_manager/hashtags_builder_page.dart';
import 'package:flutter/material.dart';

class HashtagPickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HashtagPickerScreen({
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
/// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<HashtagPickerScreen> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  TabController _tabBarController;
  final ScrollController _panelScrollController = ScrollController();
  // --------------------
  List<Chain> _bldrsChains;
  // --------------------
  List<Chain> _chains;
  List<GlobalKey> _chainKeys;
  Chain _currentChain;
  List<NavModel> _navModels = [];
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // ------------------------------
    final List<Chain> _allChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseCityChains: false,
      listen: false,
    );
    // ------------------------------

    // Chain.blogChains(_chain.sons);

    // Stringer.blogStrings(strings: _hashGroups, invoker: 'fu');


    final List<Chain> _chainsByFlyerType = Chain.getChainsFromChainsByIDs(
      allChains: _allChains,
      phids: FlyerTyper.getHashGroupsIDsByFlyerType(FlyerType.property),
    );

    setState(() {
      _bldrsChains = _allChains;
      _chains = _chainsByFlyerType;
      _chainKeys = List.generate(_chains.length, (index) => GlobalKey());
      _currentChain = _chainsByFlyerType.first;
    });

    _tabBarController = TabController(
        vsync: this,
        // initialIndex: 0,
        animationDuration: const Duration(milliseconds: 300),
        length: _chains.length,
    );

    _generateNavModels();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _tabBarController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  ///
  // Future<void> _selectHashModel({
  //   @required Chain chain,
  //   @required int index,
  // }) async {

    // await Sliders.slideToIndex(
    //   pageController: _pageController,
    //   toIndex: index,
    //   duration: const Duration(milliseconds: 400),
    // );
    //
    // setState(() {
    //   _currentChain = chain;
    // });

  // }
  // --------------------
  ///
  // Future<void> _onPageChanged(int index) async {


    // if (_currentChain.id != _chains[index].id) {
    //
    // blog('onPageChanged: $index : ${_chains[index].id}');
    //
    //   Snapper.snapToWidget(
    //     snapKey: _chainKeys[index],
    //   );
    //
    //   setState(() {
    //     _currentChain = _chains[index];
    //   });
    //
    // }

  // }
  // -----------------------------------------------------------------------------
  static const double _panelButtonWidth = 150;
  static const double _panelButtonPadding = 3;

  double _getButtonOffset({
    @required double buttonWidth,
    @required double spacing,
    @required int index,
    @required int numberOfButtons,
  }){

    /// BUTTON SHOULD HAVE SPACING ON RIGHT AND LEFT
    final double _buttonAndSpacing = buttonWidth + (spacing * 2);

    return (index + 1) * _buttonAndSpacing;

  }

  Future<void> _scrollPanelToIndex(int index) async {

    final double _buttonOffset = _getButtonOffset(
      buttonWidth: _panelButtonWidth,
      spacing: _panelButtonPadding * 2,
      index: index,
      numberOfButtons: _chains.length,
    );

    await Sliders.slideToOffset(
      scrollController: _panelScrollController,
      offset: _buttonOffset,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _generateNavModels(){

    final List<NavModel> _output = [];

    for (final Chain _chain in _chains){

      final NavModel _navModel = NavModel(
        id: _chain.id,
        titleVerse: Verse(text: _chain.id, translate: true),
        icon: ChainsProvider.proGetPhidIcon(context: context, son: _chain.id),
        iconSizeFactor: 1,
        screen: HashtagsBuilderPage(
          chain: _chain,
        ),
      );

      _output.add(_navModel);

    }

    setState(() {
      _navModels = _output;
    });

  }


  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    const double _slidesShelfHeight = 120;
    const double _separatorHeight = SeparatorLine.standardThickness + 4.5;
    // --------------------
    final double _hashtagsBoxHeight =
              _screenHeight
            - Stratosphere.getStratosphereValue(context: context, appBarType: AppBarType.search)
            - _separatorHeight
            - _slidesShelfHeight;
    // --------------------
    const double _hashGroupsHeight = 50;
    final double _hashListHeight = _hashtagsBoxHeight - _hashGroupsHeight - SeparatorLine.standardThickness - 10;
    // --------------------

    return ObeliskLayout(
      navModels: _navModels,
      canGoBack: true,
      appBarType: AppBarType.search,
      appBarRowWidgets: [

        const Expander(),

        AppBarButton(
          verse: Verse.plain('blogChains'),
          onTap: (){
            Chain.blogChains(_bldrsChains);
          },
        ),

      ],
      initiallyExpanded: true,
    );

    // return MainLayout(
    //   pageTitleVerse: const Verse(
    //     text: 'phid_pick_hashtags',
    //     translate: true,
    //   ),
    //   appBarType: AppBarType.search,
    //   skyType: SkyType.black,
    //   appBarRowWidgets: [
    //
    //     const Expander(),
    //
    //     AppBarButton(
    //       verse: Verse.plain('blogChains'),
    //       onTap: (){
    //         Chain.blogChains(_bldrsChains);
    //       },
    //     ),
    //
    //   ],
    //   layoutWidget: Column(
    //     children: <Widget>[
    //
    //       const Stratosphere(bigAppBar: true),
    //
    //       /// SLIDES
    //       FlyerSlidesShelf(
    //         flyerModel: widget.flyerModel,
    //       ),
    //
    //       /// SEPARATOR
    //       Padding(
    //         padding: const EdgeInsets.only(top: 4.5),
    //         child: SeparatorLine(
    //           width: BldrsAppBar.width(context),
    //         ),
    //       ),
    //
    //       /// HASHTAGS SELECTOR
    //       SizedBox(
    //         width: _screenWidth,
    //         height: _hashtagsBoxHeight,
    //         child: Column(
    //           children: <Widget>[
    //
    //             /// PAGES
    //             SizedBox(
    //               width: _screenWidth,
    //               height: _hashListHeight,
    //               child: PageView.builder(
    //                   physics: const BouncingScrollPhysics(),
    //                   itemCount: _chains.length,
    //                   // controller: _pageController,
    //                   onPageChanged: _onPageChanged,
    //                   itemBuilder: (_, index){
    //
    //                     final Chain _chain = _chains[index];
    //
    //                     return PageBubble(
    //                       screenHeightWithoutSafeArea: _hashtagsBoxHeight,
    //                       appBarType: AppBarType.non,
    //                       color: Colorz.white10,
    //                       child: ListView.builder(
    //                         physics: const BouncingScrollPhysics(),
    //                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //                         itemCount: _chain.sons.length,
    //                         itemBuilder: (BuildContext context, int index) {
    //
    //                           final dynamic _son = _chain.sons[index];
    //
    //                           return ChainSplitter(
    //                             width: PageBubble.clearWidth(context),
    //                             chainOrChainsOrSonOrSons: _son,
    //                             initiallyExpanded: true,
    //                             secondLinesType: ChainSecondLinesType.non,
    //                             onPhidTap: (String path, String phid){
    //                               blog('onPhidTap : path: $path, phid: $phid');
    //                               },
    //                             onPhidLongTap: (String path, String phid){
    //                               blog('onPhidLongTap : path: $path, phid: $phid');
    //                               },
    //                             onPhidDoubleTap: (String path, String phid){
    //                               blog('onPhidDoubleTap : path: $path, phid: $phid');
    //                               },
    //                             selectedPhids: const [],
    //                             searchText: null,
    //                             onExportSpecs: null,
    //                             zone: null,
    //                             onlyUseCityChains: false,
    //                             isMultipleSelectionMode: false,
    //                             isCollapsable: false,
    //                           );
    //                           },
    //                       ),
    //                     );
    //
    //                   }),
    //             ),
    //
    //             /// SEPARATOR LINE
    //             Padding(
    //               padding: const EdgeInsets.only(top: 10),
    //               child: SeparatorLine(
    //                 width: BldrsAppBar.width(context),
    //                 // withMargins: true,
    //               ),
    //             ),
    //
    //             /// CONTROL BAR
    //             SingleChildScrollView(
    //               physics: const BouncingScrollPhysics(),
    //               scrollDirection: Axis.horizontal,
    //               controller: _panelScrollController,
    //               child: Container(
    //                 constraints: BoxConstraints(
    //                   minWidth: _screenWidth + 10,
    //                 ),
    //                 height: _hashGroupsHeight,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //
    //                     ...List.generate(_chains.length, (index){
    //
    //                       final Chain _chain = _chains[index];
    //                       final String _icon = ChainsProvider.proGetPhidIcon(
    //                         context: context,
    //                         son: _chain.id,
    //                       );
    //
    //                       // final String _trans = PhraseProvider.
    //
    //                       final bool _isSelected = _chain.id == _currentChain.id;
    //
    //                       return DreamBox(
    //                         key: _chainKeys[index],
    //                         height: 40,
    //                         width: _panelButtonWidth,
    //                         verseMaxLines: 2,
    //                         verseCentered: false,
    //
    //                         verse: Verse(
    //                             text: _chain.id,
    //                             translate: true,
    //                         ),
    //                         icon: _icon,
    //                         iconSizeFactor: 0.7,
    //                         verseWeight: VerseWeight.black,
    //                         verseScaleFactor: 0.8,
    //                         color: _isSelected ? Colorz.yellow255 : Colorz.nothing,
    //                         verseColor: _isSelected ? Colorz.black255 : Colorz.white255,
    //                         margins: const EdgeInsets.symmetric(horizontal: _panelButtonPadding),
    //                         onTap: () => _selectHashModel(
    //                           chain: _chain,
    //                           index: index,
    //                         ),
    //                       );
    //
    //                     }),
    //
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //
    //     ],
    //   ),
    // );    // --------------------

  }
// -----------------------------------------------------------------------------
}
