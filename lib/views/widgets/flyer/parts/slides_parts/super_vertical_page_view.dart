import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SuperVerticalPageView extends StatefulWidget {
  final PageController verticalController;
  final Widget firstPageWidget;
  final List<Widget> secondPageListViewWidgets;
  final Function onVerticalPageChange;
  final double flyerZoneHeight;

  SuperVerticalPageView({
    @required this.verticalController,
    @required this.firstPageWidget,
    @required this.secondPageListViewWidgets,
    @required this.onVerticalPageChange,
    @required this.flyerZoneHeight,
  });

  @override
  _SuperVerticalPageViewState createState() => _SuperVerticalPageViewState();
}

class _SuperVerticalPageViewState extends State<SuperVerticalPageView> {

  PageController _pageController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _pageController = widget.verticalController;

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (i) => widget.onVerticalPageChange(i),
      children: <Widget>[

        widget.firstPageWidget,

        DraggableListView(
          pageStorageKeyValue: '${Numberers.createUniqueIntFrom(existingValues: [1, 2])}', //Should be unique for each widget.
          listViewChildren: widget.secondPageListViewWidgets,
          verticalController: _pageController,
          flyerZoneHeight: widget.flyerZoneHeight,
        ),

      ],
    );
  }

}


class DraggableListView extends StatefulWidget {
  final List<Widget> listViewChildren;
  final String pageStorageKeyValue;
  final PageController verticalController;
  final double flyerZoneHeight;

  const DraggableListView({
    @required this.listViewChildren,
    @required this.pageStorageKeyValue,
    @required this.verticalController,
    @required this.flyerZoneHeight,
    Key key,
  })  :
        assert(pageStorageKeyValue != null),
        super(key: key);


  @override
  _DraggableListViewState createState() => _DraggableListViewState();
}

class _DraggableListViewState extends State<DraggableListView> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController(keepScrollOffset: true,);

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return NotificationListener(
      onNotification: (ScrollUpdateNotification details){

        double _offset = details.metrics.pixels;

        double _bounceLimit = widget.flyerZoneHeight * 0.15 * (-1);

        bool _canPageUp = _offset < _bounceLimit;

        bool _goingDown = Scrollers.isGoingDown(_scrollController);

        if(_goingDown && _canPageUp){
          Sliders.slideToBackFrom(widget.verticalController, 1);
        }

        return true;
      },
      child: ListView(
        key: PageStorageKey<String>(widget.pageStorageKeyValue),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        controller: _scrollController,
        children: <Widget>[

          ...widget.listViewChildren,

        ],
      ),
    );
  }
}

