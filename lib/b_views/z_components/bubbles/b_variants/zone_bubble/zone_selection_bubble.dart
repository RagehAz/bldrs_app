import 'dart:async';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_button.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class ZoneSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionBubble({
    @required this.currentZone,
    @required this.onZoneChanged,
    @required this.zoneViewingEvent,
    @required this.depth,
    this.titleVerse,
    this.bulletPoints,
    this.translateBullets = true,
    this.validator,
    this.autoValidate = true,
    // this.selectCountryAndCityOnly = true,
    // this.selectCountryIDOnly = false,
    this.isRequired = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel currentZone;
  final ValueChanged<ZoneModel> onZoneChanged;
  final Verse titleVerse;
  final List<Verse> bulletPoints;
  final bool translateBullets;
  final String Function() validator;
  final bool autoValidate;
  final ZoneDepth depth;
  // final bool selectCountryAndCityOnly;
  // final bool selectCountryIDOnly;
  final bool isRequired;
  final ViewingEvent zoneViewingEvent;
  /// --------------------------------------------------------------------------
  @override
  _ZoneSelectionBubbleState createState() => _ZoneSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _ZoneSelectionBubbleState extends State<ZoneSelectionBubble> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ZoneModel> _selectedZone = ValueNotifier<ZoneModel>(null);
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

    final ZoneModel _initialZone = widget.currentZone ?? ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    setNotifier(
        notifier: _selectedZone,
        mounted: mounted,
        value: _initialZone,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // --------------------
        final ZoneModel _zone = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _selectedZone.value,
        );
        // --------------------
        setNotifier(
            notifier: _selectedZone,
            mounted: mounted,
            value: _zone,
        );
        // --------------------
        await _triggerLoading(setTo: false);
        // --------------------
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose(){
    _loading.dispose();
    _selectedZone.dispose();
    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ZoneSelectionBubble oldWidget) {

    final bool _zonesIdsAreIdentical = ZoneModel.checkZonesIDsAreIdentical(
      zone1: oldWidget.currentZone,
      zone2: widget.currentZone,
    );

    if (_zonesIdsAreIdentical == false){

      // widget.currentZone.blogZone(invoker: 'didUpdateWidget');

      setNotifier(
          notifier: _selectedZone,
          mounted: mounted,
          value: widget.currentZone,
      );

    }

    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCountryButtonTap({
    @required BuildContext context
  }) async {

    Keyboard.closeKeyboard(context);

    final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: CountriesScreen(
        zoneViewingEvent: widget.zoneViewingEvent,
        depth: widget.depth,
        // selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
        // selectCountryIDOnly: widget.selectCountryIDOnly,
      ),
    );

    if (_zone == null){

    }
    else {

      _zone.blogZone(invoker: 'received zone');

      final ZoneModel _completedZone = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: _zone,
      );

      setNotifier(
          notifier: _selectedZone,
          mounted: mounted,
          value: _completedZone,
      );

      widget.onZoneChanged(_selectedZone.value);

      // await _onCityButtonTap(context: context);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCityButtonTap({
    @required BuildContext context
  }) async {

    Keyboard.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
          context: context,
          screen: CitiesScreen(
            zoneViewingEvent: widget.zoneViewingEvent,
            depth: widget.depth,
            countryID: _selectedZone.value.countryID,
            // country: _selectedZone.value.countryModel,
            // selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
          )
      );

      /// WHEN NO CITY GOT SELECTED
      if (_zone == null){

      }

      /// WHEN SELECTED A CITY
      else {

        final ZoneModel _completedZone = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _zone,
        );

        setNotifier(
            notifier: _selectedZone,
            mounted: mounted,
            value: _completedZone,
        );

        widget.onZoneChanged(_selectedZone.value);

      }

    }

  }
  // -----------------------------------------------------------------------------
  String _validator(){
    if (widget.validator == null){
      return null;
    }
    else {
      return widget.validator();
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget child){

          return ValueListenableBuilder(
            valueListenable: _selectedZone,
            builder: (_, ZoneModel zone, Widget bulletPoints){

              return Bubble(
                  bubbleColor: Formers.validatorBubbleColor(
                    validator: _validator,
                  ),
                  bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                    context: context,
                    headlineVerse: widget.titleVerse ?? const Verse(
                      id: 'phid_location',
                      translate: true,
                    ),
                    redDot: widget.isRequired,
                  ),
                  columnChildren: <Widget>[

                    if (Mapper.checkCanLoopList(widget.bulletPoints))
                      bulletPoints,

                    /// COUNTRY BUTTON
                    ZoneSelectionButton(
                      title: const Verse(
                        id: 'phid_country',
                        translate: true,
                      ),
                      verse: Verse(
                        id: zone?.countryName,
                        translate: false,
                      ),
                      icon: zone?.icon ?? Iconz.circleDot,
                      onTap: () => _onCountryButtonTap(context: context),
                      loading: loading,
                    ),

                    /// City BUTTON
                    if (widget.depth == ZoneDepth.city)
                    ZoneSelectionButton(
                      title: const Verse(
                        id: 'phid_city',
                        translate: true,
                      ),
                      verse: Verse(
                        id: zone?.cityName,
                        translate: false,
                      ),
                      onTap: () => _onCityButtonTap(context: context),
                      loading: loading,
                    ),

                    if (widget.validator != null)
                    BldrsValidator(
                      width: Bubble.clearWidth(context: context) - 20,
                      validator: _validator,
                      autoValidate: widget.autoValidate,
                    ),

                  ]
              );

            },
            child: BldrsBulletPoints(
              bulletPoints: widget.bulletPoints,
            ),

          );

        });

  }
  // -----------------------------------------------------------------------------
}
