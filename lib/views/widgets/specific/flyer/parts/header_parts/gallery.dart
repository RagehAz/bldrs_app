import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/author_bubble/author_bubble.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/gallery_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Gallery extends StatefulWidget {
  final SuperFlyer superFlyer;
  final double galleryBoxWidth;
  final bool showFlyers; // why ?
  final bool addAuthorButtonIsOn;
  // final List<TinyFlyer> tinyFlyers;

  const Gallery({
    @required this.superFlyer,
    @required this.galleryBoxWidth,
    @required this.showFlyers,
    this.addAuthorButtonIsOn = true,
    // @required this.tinyFlyers,
    Key key,
  }) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<bool> _flyersVisibilities;
  // List<bool> _authorsVisibilities;
  String _selectedAuthorID;
  List<String> _bzTeamIDs;
  BzModel _bzModel;
  CountryModel _bzCountry;
  CityModel _bzCity;
  List<FlyerModel> _flyers = <FlyerModel>[];
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();

    print('starting gallery init');
    _bzModel = widget.superFlyer.bz;

    _flyers = <FlyerModel>[];

    print('flyersIDs are ${_bzModel.flyersIDs}');

    _bzTeamIDs = BzModel.getBzTeamIDs(_bzModel);
    setFlyersVisibility();
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0

        final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
        final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

        await _flyersProvider.getsetActiveBzFlyers(context: context, bzID: _bzModel.id);

        final List<FlyerModel> _flyersFromProvider = _flyersProvider.myActiveBzFlyer;
        final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _bzModel.zone.countryID);
        final CityModel _city = await _zoneProvider.fetchCityByID(context: context, cityID: _bzModel.zone.cityID);

        print('active bz flyers are : $_flyersFromProvider');

        setState(() {
          _flyers = _flyersFromProvider;
          _bzCountry = _country;
          _bzCity = _city;
          _loading = false;
        });

        /// ---------------------------------------------------------0
      });

    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  List<bool> _createVisibilities({bool fillingValue}){
    final List<bool> _visibilities = <bool>[];

    for (int i = 0; i< _flyers.length; i++){
      _visibilities.add(fillingValue);
    }

    return _visibilities;
  }
// -----------------------------------------------------------------------------
  void setFlyersVisibility () {
    final List<bool> _visibilities = _createVisibilities(fillingValue: true);

    setState(() {
      _flyersVisibilities = _visibilities;
      _selectedAuthorID = _bzTeamIDs.length == 1 ? _bzTeamIDs[0] : '';
    });
  }
// -----------------------------------------------------------------------------
  void _onAuthorLabelTap(String authorID){
    setState(() {

      _flyersVisibilities = _createVisibilities(fillingValue: false);

      if(_selectedAuthorID != authorID){
        _selectedAuthorID = '';
        _flyersVisibilities = _createVisibilities(fillingValue: true);
      }

      _flyers.asMap().forEach((int index, FlyerModel flyer) {
        if(_flyers[index].authorID == _selectedAuthorID){
          _flyersVisibilities[index] = true;
        }
      });

    });
  }
// -----------------------------------------------------------------------------
  void _addPublishedFlyerToGallery(FlyerModel flyerModel){

    // TASK : of the tasks
    // _prof.updateTinyFlyerInLocalBzTinyFlyers(tinyFlyer);

    print('starting _addPublishedFlyerToGallery white tiny flyers were ${_flyers.length} flyers WHILE flyer visibilities were ${_flyersVisibilities.length} visibilities');

    print('tiny flyer is ${flyerModel.id}');

      _flyers.add(flyerModel);
    print('_tinyFlyers are now  ${_flyers.length} flyers');
      _flyersVisibilities.add(true);
    print('_flyersVisibilities are now  ${_flyersVisibilities.length} visibilities');

      _onAuthorLabelTap(flyerModel.authorID);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // bool _thisIsMyBz = _bzTeamIDs.contains(superUserID());


    return Container(
      width: widget.galleryBoxWidth,
      margin: EdgeInsets.only(top: widget.galleryBoxWidth * 0.005),
      color: widget.addAuthorButtonIsOn == false ? Colorz.bzPageBGColor : null,
      child:
      widget.showFlyers == false ?
      Container()
          :
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// GRID TITLE
            Container(
              width: widget.galleryBoxWidth,
              // height: ,
              alignment: Aligners.superCenterAlignment(context),
              padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child:
              widget.superFlyer.bz.showsTeam == false ?
              SuperVerse(
                verse: '${Wordz.flyersPublishedBy(context)} ${widget.superFlyer.bz.name}',
                size: 2,
                italic: true,
                margin: widget.galleryBoxWidth * Ratioz.xxflyersGridSpacing,
                maxLines: 3,
                centered: false,
                shadow: true,
                leadingDot: true,
              )
                  :
              SuperVerse(
                verse: _bzTeamIDs.length == 1 ? '${Wordz.flyersPublishedBy(context)} ${widget.superFlyer.bz.authors[0].name}' :
                '${widget.superFlyer.bz.name} ${Wordz.authorsTeam(context)}',
                size: 2,
                italic: true,
                margin: widget.galleryBoxWidth * Ratioz.xxflyersGridSpacing,
                maxLines: 3,
                centered: false,
                shadow: true,
                leadingDot: true,
              )
                ,
            ),

            /// AUTHORS BUBBLE
            if (widget.superFlyer.bz.showsTeam != false)
              AuthorBubble(
                flyerBoxWidth: widget.galleryBoxWidth,
                addAuthorButtonIsOn: widget.addAuthorButtonIsOn,
                bzAuthors: widget.superFlyer.bz.authors,
                showFlyers: widget.showFlyers,
                bzModel: widget.superFlyer.bz,
                onAuthorLabelTap: (String id) => _onAuthorLabelTap(id),
                selectedAuthorID: _selectedAuthorID,
                bzFlyers: _flyers,
              ),

            /// FLYERS
            // if (widget.galleryBoxWidth != null)
              GalleryGrid(
                gridZoneWidth: widget.galleryBoxWidth,
                bzID: widget.superFlyer.bz.authors == null || widget.superFlyer.bz.authors == <AuthorModel>[] || widget.superFlyer.bz.authors.isEmpty ?  '': widget.superFlyer.bz.id,
                flyersVisibilities: _flyersVisibilities,
                galleryFlyers: _flyers,
                bzAuthors: widget.superFlyer.bz.authors,
                bz: _bzModel, /// TASK : maybe should remove this as long as super flyer is here
                // flyerOnTap: widget.flyerOnTap,
                addPublishedFlyerToGallery: (FlyerModel flyerModel) => _addPublishedFlyerToGallery(flyerModel),
                addButtonIsOn: widget.addAuthorButtonIsOn,
                bzCountry: _bzCountry,
                bzCity: _bzCity,
              ),

          ]
      ),
    );
  }
}
