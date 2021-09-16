import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_bubble.dart';
import 'package:bldrs/views/widgets/keywords/keywords_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/record_bubble.dart';

final PageStorageBucket appBucket = PageStorageBucket();

class InfoPage extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  const InfoPage({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
  });


  @override
  Widget build(BuildContext context) {

    double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);

    double _bubbleWidth = flyerBoxWidth - (Ratioz.appBarPadding * 2);

    // double _peopleBubbleBoxHeight = flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;
    // double _peopleIconSize = flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 0.7;
    // double _peopleNameHeight = _peopleBubbleBoxHeight - _peopleIconSize;

    double _headerHeight = FlyerBox.headerBoxHeight(false, flyerBoxWidth);

    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    // double _cornerSmall = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    // double _cornerBig = (flyerBoxWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;
    BorderRadius _bubbleCorners = Borderers.superBorderAll(context, flyerBoxWidth * Ratioz.xxflyerTopCorners);

    BorderRadius _keywordsBubbleCorners = Borderers.superBorderAll(context, flyerBoxWidth * Ratioz.xxflyerTopCorners);

    FlyerType _flyerType = superFlyer.flyerType == null ? FlyerTypeClass.concludeFlyerType(superFlyer.bz.bzType) : superFlyer.flyerType;

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, superFlyer.flyerZone.countryID);
    String _cityNameRetrieved = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, superFlyer.flyerZone.cityID);
    String _cityName = _cityNameRetrieved == null ? '.....' : _cityNameRetrieved;

    List<TinyUser> _users = TinyUser.dummyTinyUsers();

    bool _editMode = superFlyer.edit.editMode == true;

    String _flyerInfoParagraph =
    _editMode == true && superFlyer.infoController.text.length == 0 ? '...' :
    _editMode == true && superFlyer.infoController.text.length > 0 ? superFlyer.infoController.text :
    _editMode == false ? superFlyer.flyerInfo : superFlyer.flyerInfo;

    bool _flyerInfoExists = _flyerInfoParagraph == null ? false : _flyerInfoParagraph.length == 0 ? false : true;

    final List<FlyerType> _possibleFlyerTypes = FlyerTypeClass.concludePossibleFlyerTypesForBz(bzType: superFlyer.bz.bzType);

    return NeedToSaveScrollPosition(
      superFlyer: superFlyer,
      flyerZoneHeight: _flyerZoneHeight,
      children: <Widget>[

        /// HEADER FOOTPRINT ZONE
        if (_editMode == false)
          Container(
            key: ValueKey<String>('info_page_top_space'),
            width: flyerBoxWidth,
            height: _headerHeight,
          ),

        /// ALL STATS
        if (_editMode == false)
          Bubble(
            key: ValueKey<String>('info_page_stats_bubble'),
            width: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            bubbleOnTap: null,
            columnChildren: <Widget>[

              /// Flyer Type
              StatsLine(
                verse: 'Flyer Type : ${TextGenerator.flyerTypeSingleStringer(context, _flyerType)}',
                icon: Iconizer.flyerTypeIconOff(_flyerType),
                iconSizeFactor: 1,
                verseScaleFactor: 0.85 * 0.7,
                bubbleWidth: _bubbleWidth,
              ),

              /// PUBLISH TIME
              StatsLine(
                verse: 'Published ${Timers.getSuperTimeDifferenceString(from: PublishTime.getPublishTimeFromTimes(times: superFlyer.flyerTimes, state: FlyerState.Published), to: DateTime.now())}',
                icon: Iconz.Calendar,
                bubbleWidth: _bubbleWidth,
              ),

              /// ZONE
              StatsLine(
                verse: 'Targeting : ${_cityName} , ${_countryName}',
                icon: Flagz.getFlagByIso3(superFlyer.flyerZone.countryID),
                bubbleWidth: _bubbleWidth,
              ),

            ],
          ),

        /// Flyer Type
        if (_editMode == true)
          Bubble(
            key: ValueKey<String>('info_page_flyer_type_bubble'),
            width: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            bubbleOnTap: _possibleFlyerTypes.length == 1 ? null : superFlyer.edit.onFlyerTypeTap,
            columnChildren: <Widget>[

              StatsLine(
                verse: 'Flyer Type : ${TextGenerator.flyerTypeSingleStringer(context, _flyerType)}',
                icon: Iconizer.flyerTypeIconOff(_flyerType),
                iconSizeFactor: 1,
                verseScaleFactor: 0.85 * 0.7,
                bubbleWidth: _bubbleWidth,
              ),

            ],
          ),

        /// ZONE
        if (_editMode == true)
          Bubble(
            key: ValueKey<String>('info_page_cone_bubble'),
            width: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            bubbleOnTap: superFlyer.edit.onZoneTap,
            columnChildren: <Widget>[

              StatsLine(
                verse: 'Targeting : ${_cityName} , ${_countryName}',
                icon: Flagz.getFlagByIso3(superFlyer.flyerZone.countryID),
                bubbleWidth: _bubbleWidth,
              ),
            ],
          ),

        /// FLYER INFO
        if (_flyerInfoExists)
          ParagraphBubble(
            key: ValueKey<String>('info_page_flyer_info_bubble'),
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            title: 'More info',
            maxLines: 3,
            centered: false,
            paragraph: _flyerInfoParagraph,
            editMode: superFlyer.edit.editMode,
            onParagraphTap: superFlyer.edit.onEditInfoTap,
          ),

        /// SAVES BUBBLE
        if (_editMode != true)
          RecordBubble(
            key: ValueKey<String>('info_page_saves_bubble'),
            flyerBoxWidth: flyerBoxWidth,
            bubbleTitle: 'Who Saved it',
            bubbleIcon: Iconz.Save,
            users: _users,
          ),

        /// SHARES BUBBLE
        if (_editMode != true)
          RecordBubble(
            key: ValueKey<String>('info_page_shares_bubble'),
            flyerBoxWidth: flyerBoxWidth,
            bubbleTitle: 'Who Shared it',
            bubbleIcon: Iconz.Share,
            users: _users,
          ),

        /// VIEWS BUBBLE
        if (_editMode != true)
          RecordBubble(
            key: ValueKey<String>('info_page_views_bubble'),
            flyerBoxWidth: flyerBoxWidth,
            bubbleTitle: 'Who viewed it',
            bubbleIcon: Iconz.Views,
            users: _users,
          ),

        /// KEYWORDS
        if (superFlyer.keywords != null && superFlyer.keywords.length != 0)
          KeywordsBubble(
            key: ValueKey<String>('info_page_keywords_bubble'),
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _keywordsBubbleCorners,
            title: 'Flyer keywords',
            keywords: superFlyer.keywords,
            selectedWords: null,
            onTap: _editMode == true ? superFlyer.edit.onEditKeywordsTap : null,
            addButtonIsOn: superFlyer.edit.editMode,
          ),


        ReviewBubble(
          key: ValueKey<String>('info_page_review_bubble'),
          flyerBoxWidth: flyerBoxWidth,
          superFlyer: superFlyer,
        ),

        Container(
          width: flyerBoxWidth,
          height: Ratioz.appBarPadding,
        ),

      ],
    );
  }


}


class NeedToSaveScrollPosition extends StatefulWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneHeight;
  final List<Widget> children;

  NeedToSaveScrollPosition({
    @required this.superFlyer,
    @required this.flyerZoneHeight,
    @required this.children,
});

  @override
  _NeedToSaveScrollPositionState createState() => _NeedToSaveScrollPositionState();
}

class _NeedToSaveScrollPositionState extends State<NeedToSaveScrollPosition> with AutomaticKeepAliveClientMixin<NeedToSaveScrollPosition>{
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // widget.superFlyer.nav.infoScrollController.addListener(widget.superFlyer.nav.onSaveInfoScrollOffset);

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    String _flyerID = widget.superFlyer.flyerID;

    double _offsetPixels = widget.superFlyer.nav.infoScrollController?.hasClients != true ? 0 :  widget.superFlyer.nav.infoScrollController.position.pixels;

    Tracer.traceWidgetBuild(widgetName: 'NeedToSaveScrollPosition', varName: 'scrollController.position', varValue: _offsetPixels);
    return NotificationListener<ScrollNotification>(
      key: ValueKey('${_flyerID} scroll_listener'),
      onNotification: (ScrollNotification pos) {
          double _offset = pos.metrics.pixels;

          // if (pos is ScrollEndNotification) {
            widget.superFlyer.nav.onSaveInfoScrollOffset();
            // print(_offset);
          // }

          double _bounceLimit = widget.flyerZoneHeight * 0.2 * (-1);

          bool _canPageUp = _offset < _bounceLimit;

          bool _goingDown = Scrollers.isGoingDown(widget.superFlyer.nav.infoScrollController);

          if(_goingDown == true && _canPageUp == true){
            Sliders.slideToBackFrom(widget.superFlyer.nav.verticalController, 1, curve: Curves.easeOut);
          }


          return true;
        },
        // child: CustomScrollView(
        //   scrollDirection: Axis.vertical,
        //   physics: const BouncingScrollPhysics(),
        //   controller: widget.superFlyer.nav.infoScrollController,
        //   key: ValueKey('${_flyerID} info_page_widgets'),
        //   slivers: <Widget>[
        //
        //     SliverList(
        //       key: ValueKey('$_flyerID info_slivers'),
        //       delegate: SliverChildListDelegate(
        //         widget.children,
        //       ),
        //
        //     ),
        //
        //   ],
        // ),

      ///

      child: ListView(
        key: PageStorageKey<String>('$_flyerID info_slivers'),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        controller: widget.superFlyer.nav.infoScrollController,
        shrinkWrap: false,
        children: widget.children,
      ),

    );

  }
}