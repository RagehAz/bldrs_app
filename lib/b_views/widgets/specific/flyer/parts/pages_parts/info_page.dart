import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart'
    as FlyerTypeClass;
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/paragraph_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_bubble.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/specs_bubble.dart';
import 'package:bldrs/b_views/widgets/specific/keywords/keywords_bubble.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart' as Tracer;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final PageStorageBucket appBucket = PageStorageBucket();

class OldInfoPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldInfoPage({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  /// --------------------------------------------------------------------------
  bool _flyerInfoExistsCheck(String flyerInfoParagraph) {
    bool _exists;

    if (flyerInfoParagraph == null || flyerInfoParagraph.isEmpty) {
      _exists = false;
    } else {
      _exists = true;
    }

    return _exists;
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _flyerZoneHeight = OldFlyerBox.height(context, flyerBoxWidth);

    final double _bubbleWidth = flyerBoxWidth - (Ratioz.appBarPadding * 2);

    // double _peopleBubbleBoxHeight = flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;
    // double _peopleIconSize = flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 0.7;
    // double _peopleNameHeight = _peopleBubbleBoxHeight - _peopleIconSize;

    final double _headerHeight = OldFlyerBox.headerBoxHeight(
      bzPageIsOn: false,
      flyerBoxWidth: flyerBoxWidth,
    );

    const EdgeInsets _bubbleMargins = EdgeInsets.only(
        top: Ratioz.appBarPadding,
        left: Ratioz.appBarPadding,
        right: Ratioz.appBarPadding);
    // double _cornerSmall = flyerBoxWidth * Ratioz.xxflyerTopCorners;
    // double _cornerBig = (flyerBoxWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;
    final BorderRadius _bubbleCorners = Borderers.superBorderAll(
        context, flyerBoxWidth * Ratioz.xxflyerTopCorners);

    final BorderRadius _keywordsBubbleCorners = Borderers.superBorderAll(
        context, flyerBoxWidth * Ratioz.xxflyerTopCorners);

    final FlyerTypeClass.FlyerType _flyerType = superFlyer.flyerType ??
        FlyerTypeClass.concludeFlyerType(superFlyer.bz.bzType);

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    final CountryModel _currentCountry = _zoneProvider.currentCountry;
    final CityModel _currentCity = _zoneProvider.currentCity;
    // final Zone _currentZone = _zoneProvider.currentZone;

    final String _countryName = CountryModel.getTranslatedCountryNameByID(
        context: context,
        countryID: _currentCountry.id,
    );

    final String _cityName = CityModel.getTranslatedCityNameFromCity(
        context: context,
        city: _currentCity,
    );

    // List<TinyUser> _users = TinyUser.dummyTinyUsers();

    final bool _editMode = superFlyer.edit.editMode == true;

    final String _flyerInfoParagraph = _editMode == true && superFlyer.infoController.text.isEmpty ?
    '...'
        :
    _editMode == true && superFlyer.infoController.text.isNotEmpty ? superFlyer.infoController.text
        :
    _editMode == false ? superFlyer.flyerInfo
        :
    superFlyer.flyerInfo;

    final bool _flyerInfoExists = _flyerInfoExistsCheck(_flyerInfoParagraph);

    final List<FlyerTypeClass.FlyerType> _possibleFlyerTypes = FlyerTypeClass.concludePossibleFlyerTypesForBz(
            bzType: superFlyer.bz?.bzType
        );

    return NeedToSaveScrollPosition(
      superFlyer: superFlyer,
      flyerZoneHeight: _flyerZoneHeight,
      children: <Widget>[

        /// HEADER FOOTPRINT ZONE
        // if (_editMode == false)
        SizedBox(
          key: const ValueKey<String>('info_page_top_space'),
          width: flyerBoxWidth,
          height: _headerHeight,
        ),

        /// ALL STATS
        if (_editMode == false)
          Bubble(
            key: const ValueKey<String>('info_page_stats_bubble'),
            width: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            columnChildren: <Widget>[

              /// Flyer Type
              StatsLine(
                verse:
                    'Flyer Type : ${TextGen.flyerTypeSingleStringer(context, _flyerType)}',
                icon: Iconizer.flyerTypeIconOff(_flyerType),
                iconSizeFactor: 1,
                verseScaleFactor: 0.85 * 0.7,
                bubbleWidth: _bubbleWidth,
              ),

              /// PUBLISH TIME
              StatsLine(
                verse:
                    'Published ${Timers.getSuperTimeDifferenceString(from: PublishTime.getPublishTimeFromTimes(times: superFlyer.times, state: FlyerState.published), to: DateTime.now())}',
                icon: Iconz.calendar,
                bubbleWidth: _bubbleWidth,
              ),

              /// ZONE
              StatsLine(
                verse: 'Targeting : $_cityName , $_countryName',
                icon: Flag.getFlagIconByCountryID(superFlyer.zone.countryID),
                bubbleWidth: _bubbleWidth,
              ),

            ],
          ),

        /// Flyer Type
        if (_editMode == true)
          Bubble(
            key: const ValueKey<String>('info_page_flyer_type_bubble'),
            width: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            bubbleOnTap: _possibleFlyerTypes.length == 1
                ? null
                : superFlyer.edit.onFlyerTypeTap,
            columnChildren: <Widget>[
              StatsLine(
                verse:
                    'Flyer Type : ${TextGen.flyerTypeSingleStringer(context, _flyerType)}',
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
            key: const ValueKey<String>('info_page_cone_bubble'),
            width: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            bubbleOnTap: superFlyer.edit.onZoneTap,
            columnChildren: <Widget>[
              StatsLine(
                verse: 'Targeting : $_cityName , $_countryName',
                icon: Flag.getFlagIconByCountryID(superFlyer.zone.countryID),
                bubbleWidth: _bubbleWidth,
              ),
            ],
          ),

        /// FLYER INFO
        if (_flyerInfoExists)
          ParagraphBubble(
            key: const ValueKey<String>('info_page_flyer_info_bubble'),
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            title: 'More info',
            maxLines: 3,
            paragraph: _flyerInfoParagraph,
            editMode: superFlyer.edit.editMode,
            onParagraphTap: superFlyer.edit.onEditInfoTap,
          ),

        // /// SAVES BUBBLE
        // if (_editMode != true)
        //   RecordBubble(
        //     key: ValueKey<String>('info_page_saves_bubble'),
        //     flyerBoxWidth: flyerBoxWidth,
        //     bubbleTitle: 'Who Saved it',
        //     bubbleIcon: Iconz.Save,
        //     users: _users,
        //   ),
        //
        // /// SHARES BUBBLE
        // if (_editMode != true)
        //   RecordBubble(
        //     key: ValueKey<String>('info_page_shares_bubble'),
        //     flyerBoxWidth: flyerBoxWidth,
        //     bubbleTitle: 'Who Shared it',
        //     bubbleIcon: Iconz.Share,
        //     users: _users,
        //   ),
        //
        // /// VIEWS BUBBLE
        // if (_editMode != true)
        //   RecordBubble(
        //     key: ValueKey<String>('info_page_views_bubble'),
        //     flyerBoxWidth: flyerBoxWidth,
        //     bubbleTitle: 'Who viewed it',
        //     bubbleIcon: Iconz.Views,
        //     users: _users,
        //   ),

        /// SPECS
        if ((Mapper.canLoopList(superFlyer.specs)) || _editMode == true)
          SpecsBubble(
            key: const ValueKey<String>('info_page_keywords_bubble'),
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _keywordsBubbleCorners,
            title: 'Flyer Specifications',
            specs: superFlyer.specs,
            selectedWords: null,
            onTap: _editMode == true ? superFlyer.edit.onEditSpecsTap : null,
            addButtonIsOn: superFlyer.edit.editMode,
          ),

        /// KEYWORDS
        if ((Mapper.canLoopList(superFlyer.keywords)) || _editMode == true)
          KeywordsBubble(
            key: const ValueKey<String>('info_page_keywords_bubble'),
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _keywordsBubbleCorners,
            title: 'Flyer keywords',
            keywords: superFlyer.keywords,
            selectedWords: null,
            onTap: _editMode == true ? superFlyer.edit.onEditKeywordsTap : null,
            onKeywordTap: (KW kw) {
              kw.blogKeyword();
            },
            addButtonIsOn: superFlyer.edit.editMode,
          ),

        ReviewBubble(
          key: const ValueKey<String>('info_page_review_bubble'),
          flyerBoxWidth: flyerBoxWidth,
          superFlyer: superFlyer,
        ),

        SizedBox(
          width: flyerBoxWidth,
          height: Ratioz.appBarPadding,
        ),
      ],
    );
  }
}

class NeedToSaveScrollPosition extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NeedToSaveScrollPosition({
    @required this.superFlyer,
    @required this.flyerZoneHeight,
    @required this.children,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerZoneHeight;
  final List<Widget> children;

  /// --------------------------------------------------------------------------
  @override
  _NeedToSaveScrollPositionState createState() =>
      _NeedToSaveScrollPositionState();

  /// --------------------------------------------------------------------------
}

class _NeedToSaveScrollPositionState extends State<NeedToSaveScrollPosition>
    with AutomaticKeepAliveClientMixin<NeedToSaveScrollPosition> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // widget.superFlyer.nav.infoScrollController.addListener(widget.superFlyer.nav.onSaveInfoScrollOffset);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final String _flyerID = widget.superFlyer.flyerID;

    final double _offsetPixels =
        widget.superFlyer.nav.infoScrollController?.hasClients != true
            ? 0
            : widget.superFlyer.nav.infoScrollController.position.pixels;

    Tracer.traceWidgetBuild(
        widgetName: 'NeedToSaveScrollPosition',
        varName: 'scrollController.position',
        varValue: _offsetPixels);
    return NotificationListener<ScrollNotification>(
      key: ValueKey<String>('$_flyerID scroll_listener'),
      onNotification: (ScrollNotification pos) {
        final double _offset = pos.metrics.pixels;

        // if (pos is ScrollEndNotification) {
        widget.superFlyer.nav.onSaveInfoScrollOffset();
        // print(_offset);
        // }

        final double _bounceLimit = widget.flyerZoneHeight * 0.2 * (-1);

        final bool _canPageUp = _offset < _bounceLimit;

        final bool _goingDown =
            Scrollers.isGoingDown(widget.superFlyer.nav.infoScrollController);

        if (_goingDown == true && _canPageUp == true) {
          Sliders.slideToBackFrom(widget.superFlyer.nav.verticalController, 1,
              curve: Curves.easeOut);
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
        controller: widget.superFlyer.nav.infoScrollController,
        children: widget.children,
      ),
    );
  }
}
