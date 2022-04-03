import 'dart:async';

import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/kw/specs/data_creator.dart';
import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/specs/price_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/spec_list_tile.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/spec_picker_screen.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsListsPickersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecsListsPickersScreen({
    @required this.flyerType,
    @required this.selectedSpecs,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final FlyerTypeClass.FlyerType flyerType;
  final List<SpecModel> selectedSpecs;

  /// --------------------------------------------------------------------------
  @override
  _SpecsListsPickersScreenState createState() =>
      _SpecsListsPickersScreenState();

  /// --------------------------------------------------------------------------
}

class _SpecsListsPickersScreenState extends State<SpecsListsPickersScreen> with SingleTickerProviderStateMixin {
  List<SpecModel> _allSelectedSpecs;

  ScrollController _scrollController;
  // AnimationController _animationController;

  List<SpecList> _sourceSpecsLists = <SpecList>[];
  List<SpecList> _refinedSpecsLists = <SpecList>[];
  List<String> _groupsIDs = <String>[];

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    // _animationController = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // );

    _sourceSpecsLists = SpecList.getSpecsListsByFlyerType(widget.flyerType);
    _allSelectedSpecs = widget.selectedSpecs;
    _refinedSpecsLists = SpecList.generateRefinedSpecsLists(
        sourceSpecsLists: _sourceSpecsLists, selectedSpecs: _allSelectedSpecs);
    _groupsIDs =
        SpecList.getGroupsFromSpecsLists(specsLists: _sourceSpecsLists);

    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {
        /// do Futures here

        unawaited(_triggerLoading(function: () {
          /// set new values here
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

// -----------------------------------------------------------------------------
  Future<void> _onSpecsListTap(SpecList specList) async {
    blog('fi eh ${specList.specChain.sons}');

    if (specList.specChain.sons.runtimeType != DataCreator) {
      await _goToSpecPickerScreen(specList);
    }

    else if (specList.specChain.sons == DataCreator.price) {
      await _goToSpecPickerScreen(specList);
    }

    else if (specList.specChain.sons == DataCreator.currency) {
      await _runCurrencyDialog(specList);
    }

    else if (specList.specChain.sons == DataCreator.integerIncrementer) {
      blog('aho');
      await _goToSpecPickerScreen(specList);
    }

    else if (specList.specChain.sons == DataCreator.doubleCreator) {
      blog('aho');
      await _goToSpecPickerScreen(specList);
    }

  }

// -----------------------------------------------------------------------------
  Future<void> _goToSpecPickerScreen(SpecList specList) async {
    final List<SpecModel> _result = await Nav.goToNewScreen(
      context,
      SpecPickerScreen(
        specList: specList,
        allSelectedSpecs: _allSelectedSpecs,
      ),
      transitionType: Nav.superHorizontalTransition(context),
    );

    SpecModel.printSpecs(_result);

    _updateSpecsListsAndGroups(
      specList: specList,
      specPickerResult: _result,
    );
  }

// -----------------------------------------------------------------------------
  Future<void> _runCurrencyDialog(SpecList specList) async {
    await PriceDataCreator.showCurrencyDialog(
      context: context,
      onSelectCurrency: (CurrencyModel currency) async {
        final SpecModel _currencySpec = SpecModel(
          specsListID: specList.id,
          value: currency.code,
        );

        final List<SpecModel> _result = SpecModel.putSpecsInSpecs(
          parentSpecs: _allSelectedSpecs,
          inputSpecs: <SpecModel>[_currencySpec],
          canPickMany: specList.canPickMany,
        );

        _updateSpecsListsAndGroups(
          specList: specList,
          specPickerResult: _result,
        );

        Nav.goBack(context);
        // await null;
      },
    );
  }

// -----------------------------------------------------------------------------
  void _updateSpecsListsAndGroups(
      {@required dynamic specPickerResult, @required SpecList specList}) {
    // -------------------------------------------------------------
    if (specPickerResult != null) {
      // ------------------------------------
      /// A - SONS ARE FROM DATA CREATOR
      if (specList.specChain.sons.runtimeType == DataCreator) {}
      // ------------------------------------
      /// B - WHEN FROM LIST OF KWs
      if (ObjectChecker.objectIsListOfSpecs(specPickerResult)) {
        // Spec.printSpecs(_allSelectedSpecs);

        setState(() {
          _allSelectedSpecs = specPickerResult;
          _refinedSpecsLists = SpecList.generateRefinedSpecsLists(
              sourceSpecsLists: _sourceSpecsLists,
              selectedSpecs: _allSelectedSpecs);
          _groupsIDs =
              SpecList.getGroupsFromSpecsLists(specsLists: _refinedSpecsLists);
        });
      }
      // ------------------------------------
      /// C - WHEN SOMETHING GOES WRONG
      else {
        blog('RED ALERT : result : ${specPickerResult.toString()}');
      }
      // ------------------------------------
    }
    // -------------------------------------------------------------
  }

// -----------------------------------------------------------------------------
  void _removeSpec(SpecModel spec) {
    setState(() {
      _allSelectedSpecs.remove(spec);
    });
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
//     const double _specTileHeight = 70;
//     final double _specTileWidth = _screenWidth - (Ratioz.appBarMargin * 2);
    // final BorderRadius _tileBorders = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    // final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
// -----------------------------------------------------------------------------

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      pageTitle: 'Select Flyer Specifications',
      layoutWidget: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: OldMaxBounceNavigator(
          child: Scroller(
            controller: _scrollController,
            child: ListView.builder(
                itemCount: _groupsIDs.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                itemBuilder: (BuildContext ctx, int index) {
                  final String _groupID = _groupsIDs[index];

                  final List<SpecList> _listsOfThisGroup =
                      SpecList.getSpecsListsByGroupID(
                    specsLists: _refinedSpecsLists,
                    groupID: _groupID,
                  );

                  return SizedBox(
                    width: _screenHeight,
                    // height: 80 + (_listsOfThisGroup.length * (SpecListTile.height() + 5)),
                    child: Column(
                      children: <Widget>[
                        /// GROUP TITLE
                        Container(
                          width: _screenHeight,
                          height: 50,
                          margin:
                              const EdgeInsets.only(top: Ratioz.appBarMargin),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          // color: Colorz.bloodTest,
                          child: SuperVerse(
                            verse: _groupID.toUpperCase(),
                            weight: VerseWeight.black,
                            centered: false,
                            margin: 10,
                            size: 3,
                            scaleFactor: 0.85,
                            italic: true,
                            color: Colorz.yellow125,
                          ),
                        ),

                        /// GROUP SPECS LISTS
                        SizedBox(
                          width: _screenHeight,
                          // height: (_listsOfThisGroup.length * (SpecListTile.height() + 5)),

                          child: Column(
                            children: <Widget>[
                              ...List<Widget>.generate(_listsOfThisGroup.length,
                                  (int index) {
                                final SpecList _specList =
                                    _listsOfThisGroup[index];
                                final List<SpecModel> _selectedSpecs =
                                    SpecModel.getSpecsByListID(
                                  specs: _allSelectedSpecs,
                                  specsListID: _specList.id,
                                );

                                return SpecListTile(
                                  onTap: () => _onSpecsListTap(_specList),
                                  specList: _specList,
                                  sourceSpecsLists: _sourceSpecsLists,
                                  selectedSpecs: _selectedSpecs,
                                  onDeleteSpec: (SpecModel spec) =>
                                      _removeSpec(spec),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
