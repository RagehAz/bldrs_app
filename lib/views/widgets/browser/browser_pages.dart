import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keys_set.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/browser/filters_page.dart';
import 'package:bldrs/views/widgets/browser/groups_page.dart';
import 'package:bldrs/views/widgets/browser/keywords_page.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BrowserPages extends StatefulWidget {
  final double browserZoneHeight;
  final bool browserIsOn;
  final Function closeBrowser;
  final List<KeysSet> filtersModels;
  final Function onKeywordTap;
  final List<Keyword> selectedKeywords;

  BrowserPages({
    @required this.browserZoneHeight,
    @required this.browserIsOn,
    @required this.closeBrowser,
    @required this.filtersModels,
    @required this.onKeywordTap,
    @required this.selectedKeywords,
});


  @override
  _BrowserPagesState createState() => _BrowserPagesState();
}

class _BrowserPagesState extends State<BrowserPages> {
  // int _numberOfPages = 1;
  int _currentPage = 0;

  // List<FilterModel> _filtersModels;
  KeysSet _currentFilter;
  List<String> _groups = new List();
  String _currentGroupID;
  List<Keyword> _keywords = new List();
  // List<KeywordModel> _selectedKeywords = new List();

  // List<Widget> _pages = new List();

  PageController _pageController;
  ItemScrollController _scrollController;
  ItemPositionsListener _itemPositionListener;

  Keyword _highlightedKeyword;

// -----------------------------------------------------------------------------
  @override
  void initState() {
    // _filtersModels = widget.filtersModels;
    //
    // print('_filtersModels : $_filtersModels');
    // print('widget.filtersModels : ${widget.filtersModels}');

    _pageController = new PageController();
    _scrollController = ItemScrollController();
    _itemPositionListener = ItemPositionsListener.create();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<Widget> generatePages(List<KeysSet> filters){

    return
        <Widget>[

          FiltersPage(
            filtersModels: filters,
            onTap: (filterModel) => _onFilterTap(filterModel),
            selectedFilter: _currentFilter,
          ),

          if (_groups.isNotEmpty)
          GroupsPage(
            groups: _groups,
            onTap: (group) => _onGroupTap(group),
            selectedGroup: _currentGroupID,
          ),

          if (_keywords.isNotEmpty)
          KeywordsPage(
            keywords: _keywords,
            onTap: (keywordModel) => _onKeywordTap(keywordModel),
            selectedKeywords: widget.selectedKeywords,
          ),

    ];

  }
// -----------------------------------------------------------------------------
  void _onFilterTap(KeysSet filterModel){
    print('tapping filter : ${filterModel.titleID}');

    setState(() {
      _currentFilter = filterModel;
      _groups = Keyword.getGroupsIDsFromFilterModel(filterModel);
      _currentGroupID = null;
      _keywords = new List();
    });

    if(_groups.isEmpty){
      setState(() {
        _keywords = filterModel.keywords;
      });
    }
    // resetPages();
    _goToNextPage();
  }
// -----------------------------------------------------------------------------
  void _onGroupTap(String groupID){
    setState(() {
      _currentGroupID = groupID;
      _keywords = Keyword.getKeywordsByGroupIDAndFilterModel(filterModel: _currentFilter, groupID: _currentGroupID);
    });
    // resetPages();
    _goToNextPage();
  }
// -----------------------------------------------------------------------------
  void _onKeywordTap(Keyword keywordModel){

    widget.onKeywordTap(keywordModel);

    // setState(() {
    //   _selectedKeywords.add(keywordModel);
    // });
    // resetPages();
    print(keywordModel.keywordID);
  }
// -----------------------------------------------------------------------------
  void _goToNextPage(){
    _pageController.nextPage(
        duration: Ratioz.slidingDuration,
        curve: Curves.easeInOut,
    );
  }
// -----------------------------------------------------------------------------
  String _generatePathString(){

    String _path =
    _currentFilter == null ?
        ''
        :
    _currentGroupID == null ?
    '${_currentFilter.titleID}'
        :
    '${_currentFilter.titleID} / $_currentGroupID';

    return _path;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    List<KeysSet> _filtersBySection = _flyersProvider.getSectionFilters;

    List<Widget> _pages = generatePages(_filtersBySection);
    int _numberOfPages = _pages.length;

    print('rebuilding browser pages with ${widget.filtersModels.length} filters');

    double _clearWidth = widget.browserIsOn == true ? Scale.superScreenWidth(context) - Ratioz.appBarMargin * 2 - Ratioz.appBarPadding * 2 : 0;
    double _clearHeight = widget.browserZoneHeight - Ratioz.appBarPadding * 2;
    double _titleZoneHeight = widget.browserIsOn == true ? Ratioz.keywordsBarHeight : 0;
    double _progressBarHeight = _clearWidth * Ratioz.xxProgressBarHeightRatio;
    double _pagesZoneHeight = widget.browserIsOn == true ? _clearHeight - _titleZoneHeight - _progressBarHeight : 0;

    double _titleIconSize = 40;

    return Center(
      child: AnimatedContainer(
        duration: Ratioz.slidingTransitionDuration,
        width: _clearWidth,
        height: _clearHeight,
        decoration: BoxDecoration(
          borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner - Ratioz.appBarPadding),
          // color: Colorz.BloodRed,
        ),
        alignment: Alignment.center,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[

            /// TITLE ZONE
            Container(
                // duration: Ratioz.slidingTransitionDuration,
                width: _clearWidth,
                height: _titleZoneHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    Container(
                      width: _titleIconSize,
                      height: _titleIconSize,
                      child: DreamBox(
                        height: _titleIconSize,
                        width: _titleIconSize,
                        icon: Iconz.FlyerGrid,
                        iconSizeFactor: 0.8,
                        bubble: true,
                        // color: Colorz.LinkedIn
                      ),
                    ),

                    Flexible(
                      flex: 12,
                      child: Container(
                        // color: Colorz.BabyBlue,
                        margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                        // constraints: BoxConstraints(minWidth: 0, maxWidth: _clearWidth - Ratioz.appBarPadding * 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            /// TITLE
                            SuperVerse(
                              verse: 'Browse & Add keywords to your search',
                              centered: false,
                            ),

                            /// FILTER KEYWORD PATH
                            SuperVerse(
                              verse: _generatePathString(),
                              size: 2,
                              italic: true,
                              color: Colorz.Yellow,
                              centered: false,
                            ),

                          ],
                        ),
                      ),
                    ),

                    /// SPACER
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),

                    /// EXIT
                    Flexible(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: _titleIconSize,
                          height: _titleIconSize,
                          // color: Colorz.BloodTest,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              DreamBox(
                                height: _titleIconSize,
                                width: _titleIconSize,
                                icon: Iconz.XLarge,
                                iconSizeFactor: 0.5,
                                boxFunction: (){
                                  widget.closeBrowser();
                                  print('exit browser');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
            ),

            /// PROGRESS BAR
            ProgressBar(
              flyerZoneWidth: _clearWidth,
              numberOfSlides: _numberOfPages,
              barIsOn: true,
              currentSlide: _currentPage,
              margins: const EdgeInsets.all(0),
            ),

            /// Lists
            Container(
              // duration: Ratioz.slidingTransitionDuration,
              width: _clearWidth,
              height: _pagesZoneHeight,
              decoration: BoxDecoration(
                borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner - Ratioz.appBarPadding),
                // color: Colorz.YellowGlass,
              ),
              child: widget.browserIsOn == true ?
              ClipRRect(
                borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner - Ratioz.appBarPadding),
                child: PageView.builder(
                    itemCount: _numberOfPages,
                    controller: _pageController,
                    onPageChanged: (pageIndex){
                      setState(() {
                        _currentPage = pageIndex;
                      });
                    },
                    itemBuilder: (context, pageIndex){


                      return
                        _pages[pageIndex];
                    }
                ),
              ) : null,
            ),

          ],
        ),
      ),
    );
  }
}

