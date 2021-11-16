import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/data_creator.dart';
import 'package:bldrs/models/kw/specs/raw_specs.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/spec_picker_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/specs/spec_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SpecSelectorScreen extends StatefulWidget {
  final FlyerType flyerType;

  SpecSelectorScreen({
    @required this.flyerType,
});

  @override
  _SpecSelectorScreenState createState() => _SpecSelectorScreenState();
}

class _SpecSelectorScreenState extends State<SpecSelectorScreen> with SingleTickerProviderStateMixin{

  List<Spec> _allSelectedSpecs;

  ScrollController _scrollController;
  AnimationController _animationController;

  List<SpecList> _sourceSpecsLists = [];
  List<SpecList> _refinedSpecsLists = [];
  List<String> _groupsIDs = [];

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

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

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _sourceSpecsLists = SpecList.propertySpecLists;
    _allSelectedSpecs = <Spec>[];
    _refinedSpecsLists = SpecList.generateRefinedSpecsLists(sourceSpecsLists: _sourceSpecsLists, selectedSpecs: _allSelectedSpecs);
    _groupsIDs = SpecList.getGroupsFromSpecsLists(specsLists: _sourceSpecsLists);

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here


        _triggerLoading(
            function: (){
              /// set new values here
            }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  /// VALUE NOTIFIER
  // ValueNotifier<int> _counter = ValueNotifier(0);
  // void _incrementCounter(){
  //   _counter.value += 3;
  // }

  // void _refineSourceSpecsLists(){
  //
  //   /// WHEN [FOR SALE]
  //   bool _containsNewSale = SpecsValidator.specsContainsNewSale(_allSelectedSpecs);
  //   if (_containsNewSale == true){
  //     int _rentPriceIndex = SpecList.getSpecsListIndexByID(specsLists: _sourceSpecsLists, specsListID: 'propertyRentPrice');
  //
  //     _sourceSpecsLists[_rentPriceIndex].hidden = true;
  //     print('_sourceSpecsLists[_rentPriceIndex].hidden : ${_sourceSpecsLists[_rentPriceIndex].hidden}');
  //   }
  //
  // }
// -----------------------------------------------------------------------------
  Future<void> _onSpecsListTap(SpecList specList) async {

    final dynamic _result = await Nav.goToNewScreen(context,
      SpecPickerScreen(
        specList: specList,
        allSelectedSpecs: _allSelectedSpecs,
      ),
      transitionType: Nav.superHorizontalTransition(context),
    );

    print('result is ${_result}');

    // -------------------------------------------------------------
    if (_result != null){
      // ------------------------------------
      /// A - SONS ARE FROM DATA CREATOR
      if (specList.specChain.sons.runtimeType == DataCreator){

      }
      // ------------------------------------
      /// B - WHEN FROM LIST OF KWs
      if (ObjectChecker.objectIsListOfSpecs(_result)){

        setState(() {
          _allSelectedSpecs = _result;
          Spec.printSpecs(_allSelectedSpecs);
          // _refineSourceSpecsLists();
          _refinedSpecsLists = SpecList.generateRefinedSpecsLists(sourceSpecsLists: _sourceSpecsLists, selectedSpecs: _allSelectedSpecs);
          _groupsIDs = SpecList.getGroupsFromSpecsLists(specsLists: _refinedSpecsLists);
        });

      }
      // ------------------------------------
      /// C - WHEN SOMETHING GOES WRONG
      else {

        print('RED ALERT : result : ${_result}');

      }
      // ------------------------------------
    }
    // -------------------------------------------------------------

  }
// -----------------------------------------------------------------------------
  void _removeSpec(Spec spec){

    setState(() {
      _allSelectedSpecs.remove(spec);
    });

  }
// -----------------------------------------------------------------------------
  // List<String> getGroupsFromRefinedLists(){
  //
  //   List<String> _groups = <String>[];
  //
  //   for (var list in _refinedSpecsLists){
  //
  //     _groups = TextMod.addStringToListIfDoesNotContainIt(
  //       strings: _groups,
  //       stringToAdd: list.groupID,
  //     );
  //
  //   }
  //
  //   return _groups;
  // }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    const double _specTileHeight = 70;
    final double _specTileWidth = _screenWidth - (Ratioz.appBarMargin * 2);
    final BorderRadius _tileBorders = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
// -----------------------------------------------------------------------------

    return MainLayout(
      sky: Sky.Black,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      pageTitle: 'Select Flyer Specifications',

      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: MaxBounceNavigator(
          child: Scroller(
            controller: _scrollController,
            child: ListView.builder(
                itemCount: _groupsIDs.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                itemBuilder: (ctx, index){

                  final String _groupID = _groupsIDs[index];

                  List<SpecList> _listsOfThisGroup = SpecList.getSpecsListsByGroupID(
                    specsLists: _refinedSpecsLists,
                    groupID: _groupID,
                  );


                  return


                      Container(
                        width: _screenHeight,
                        // height: 80 + (_listsOfThisGroup.length * (SpecListTile.height() + 5)),
                        child: Column(
                          children: <Widget>[

                            Container(
                              width: _screenHeight,
                              height: 50,
                              margin: const EdgeInsets.only(top: Ratioz.appBarMargin),
                              // color: Colorz.bloodTest,
                              child: SuperVerse(
                                verse: _groupID.toUpperCase(),
                                weight: VerseWeight.black,
                                centered: false,
                                margin: 10,
                                size: 3,
                                scaleFactor: 0.85,
                                italic: true,
                              ),
                            ),

                            Container(
                              width: _screenHeight,
                              // height: (_listsOfThisGroup.length * (SpecListTile.height() + 5)),

                              child: Column(
                                children: <Widget>[

                                  ...List.generate(
                                      _listsOfThisGroup.length,
                                          (index){

                                        final SpecList _specList = _listsOfThisGroup[index];
                                        final List<Spec> _selectedSpecs = Spec.getSpecsByListID(
                                          specsList: _allSelectedSpecs,
                                          specsListID: _specList.id,
                                        );

                                        return

                                          SpecListTile(
                                            onTap: () => _onSpecsListTap(_specList),
                                            specList: _specList,
                                            sourceSpecsLists: _sourceSpecsLists,
                                            selectedSpecs: _selectedSpecs,
                                            onDeleteSpec: (Spec spec) => _removeSpec(spec),
                                          );


                                      }),

                                ],
                              ),

                            ),

                          ],
                        ),
                      );


                }
            ),
          ),
        ),
      ),
    );
  }


}
