import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_bubble.dart';
import 'package:bldrs/views/widgets/keywords/keywords_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/record_bubble.dart';

class InfoPage extends StatefulWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  const InfoPage({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
  });

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin<InfoPage>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, widget.flyerZoneWidth);

    double _bubbleWidth = widget.flyerZoneWidth - (Ratioz.appBarPadding * 2);

    double _peopleBubbleBoxHeight = widget.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;
    double _peopleIconSize = widget.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 0.7;
    double _peopleNameHeight = _peopleBubbleBoxHeight - _peopleIconSize;

    double _headerHeight = Scale.superHeaderHeight(false, widget.flyerZoneWidth);

    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    double _cornerSmall = widget.flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _cornerBig = (widget.flyerZoneWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;
    BorderRadius _bubbleCorners = Borderers.superBorderAll(context, widget.flyerZoneWidth * Ratioz.xxflyerTopCorners);

    BorderRadius _keywordsBubbleCorners = Borderers.superBorderAll(context, widget.flyerZoneWidth * Ratioz.xxflyerTopCorners);

    FlyerType _flyerType = widget.superFlyer.flyerType == null ? FlyerTypeClass.concludeFlyerType(widget.superFlyer.bz.bzType) : widget.superFlyer.flyerType;

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, widget.superFlyer.flyerZone.countryID);
    String _cityNameRetrieved = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, widget.superFlyer.flyerZone.cityID);
    String _cityName = _cityNameRetrieved == null ? '.....' : _cityNameRetrieved;

    List<TinyUser> _users = TinyUser.dummyTinyUsers();

    bool _editMode = widget.superFlyer.edit.editMode == true;

    String _flyerInfoParagraph =
    _editMode == true && widget.superFlyer.infoController.text.length == 0 ? '...' :
    _editMode == true && widget.superFlyer.infoController.text.length > 0 ? widget.superFlyer.infoController.text :
    _editMode == false ? widget.superFlyer.flyerInfo : widget.superFlyer.flyerInfo;

    bool _flyerInfoExists = _flyerInfoParagraph == null ? false : _flyerInfoParagraph.length == 0 ? false : true;

    final List<FlyerType> _possibleFlyerTypes = FlyerTypeClass.concludePossibleFlyerTypesForBz(bzType: widget.superFlyer.bz.bzType);

    // Tracer.traceWidgetBuild(widgetName: 'InfoPage', varName: 'widget.superFlyer.nav.infoScrollController.offset', varValue: fire an error as info scroll controller has not yet been attached to a widget);
    return NotificationListener(
      onNotification: (ScrollUpdateNotification details){

        double _offset = details.metrics.pixels;

        double _bounceLimit = _flyerZoneHeight * 0.2 * (-1);

        bool _canPageUp = _offset < _bounceLimit;

        bool _goingDown = Scrollers.isGoingDown(widget.superFlyer.nav.infoScrollController);

        if(_goingDown == true && _canPageUp == true){
          Sliders.slideToBackFrom(widget.superFlyer.nav.verticalController, 1, curve: Curves.easeOut);
        }


        return true;
      },
      child: ListView(
        key: PageStorageKey<String>('${widget.superFlyer.flyerID}_2'),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        controller: widget.superFlyer.nav.infoScrollController,
        children: <Widget>[

          /// HEADER FOOTPRINT ZONE
          Container(
            width: widget.flyerZoneWidth,
            height: _headerHeight,
          ),

          /// ALL STATS
          if (_editMode == false)
            InPyramidsBubble(
              bubbleWidth: _bubbleWidth,
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
                  verse: 'Published on Saturday 17 July 2021',
                  icon: Iconz.Calendar,
                  bubbleWidth: _bubbleWidth,
                ),

                /// ZONE
                StatsLine(
                  verse: 'Targeting : ${_cityName} , ${_countryName}',
                  icon: Flagz.getFlagByIso3(widget.superFlyer.flyerZone.countryID),
                  bubbleWidth: _bubbleWidth,
                ),

              ],
            ),

          /// Flyer Type
          if (_editMode == true)
            InPyramidsBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _bubbleCorners,
              bubbleOnTap: _possibleFlyerTypes.length == 1 ? null : widget.superFlyer.edit.onFlyerTypeTap,
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
            InPyramidsBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _bubbleCorners,
              bubbleOnTap: widget.superFlyer.edit.onZoneTap,
              columnChildren: <Widget>[

                StatsLine(
                  verse: 'Targeting : ${_cityName} , ${_countryName}',
                  icon: Flagz.getFlagByIso3(widget.superFlyer.flyerZone.countryID),
                  bubbleWidth: _bubbleWidth,
                ),
              ],
            ),

          /// FLYER INFO
          if (_flyerInfoExists)
            ParagraphBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _bubbleCorners,
              title: 'More info',
              maxLines: 3,
              centered: false,
              paragraph: _flyerInfoParagraph,
              editMode: widget.superFlyer.edit.editMode,
              onParagraphTap: widget.superFlyer.edit.onEditInfoTap,
            ),

          /// SAVES BUBBLE
          if (_editMode != true)
            RecordBubble(
              flyerZoneWidth: widget.flyerZoneWidth,
              bubbleTitle: 'Who Saved it',
              bubbleIcon: Iconz.Save,
              users: _users,
            ),

          /// SHARES BUBBLE
          if (_editMode != true)
            RecordBubble(
              flyerZoneWidth: widget.flyerZoneWidth,
              bubbleTitle: 'Who Shared it',
              bubbleIcon: Iconz.Share,
              users: _users,
            ),

          /// VIEWS BUBBLE
          if (_editMode != true)
            RecordBubble(
              flyerZoneWidth: widget.flyerZoneWidth,
              bubbleTitle: 'Who viewed it',
              bubbleIcon: Iconz.Views,
              users: _users,
            ),

          /// KEYWORDS
          if (widget.superFlyer.keywords != null && widget.superFlyer.keywords.length != 0)
            KeywordsBubble(
              bubbleWidth: _bubbleWidth,
              margins: _bubbleMargins,
              corners: _keywordsBubbleCorners,
              title: 'Flyer keywords',
              keywords: widget.superFlyer.keywords,
              selectedWords: null,
              onTap: _editMode == true ? widget.superFlyer.edit.onEditKeywordsTap : null,
              addButtonIsOn: widget.superFlyer.edit.editMode,
            ),


          ReviewBubble(
            flyerZoneWidth: widget.flyerZoneWidth,
            superFlyer: widget.superFlyer,
          ),

          SizedBox(
            height: Ratioz.appBarPadding,
          ),

        ],
      ),
    );
  }
}
