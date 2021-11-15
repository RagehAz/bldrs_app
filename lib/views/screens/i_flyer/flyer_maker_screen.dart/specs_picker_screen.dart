import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/data_creator.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/spec_picker_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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

  ScrollController _ScrollController;
  AnimationController _animationController;

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
    _ScrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _allSelectedSpecs = <Spec>[];

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
// -----------------------------------------------------------------------------
//   File _file;
// -----------------------------------------------------------------------------
  List<Spec> _statelessAddSpecToAllSelectedSpecs(Spec spec, SpecList specList){

    final bool _alreadySelected = Spec.specsContainThis(specs: _allSelectedSpecs, spec: spec);

    print('_statelessAddSpecToAllSelectedSpecs : value : ${spec.value} : specsListID : ${spec.specsListID} : canPickMany : ${specList.canPickMany} : _alreadySelected : ${_alreadySelected}');

    final List<Spec> _specs = _allSelectedSpecs;

    // ----------------------------------------------
    /// A - WHEN ALREADY SELECTED
    if (_alreadySelected == true){
      // --------------------------------
      /// A1 - WHEN CAN PICK MANY
      if (specList.canPickMany == true){
        _specs.add(spec);
      }
      // --------------------------------
      /// A2 - WHEN CAN NOT PICK MANY
      else {
        final int _specIndex = _allSelectedSpecs.indexWhere((sp) => sp.specsListID == specList.id);
        if (_specIndex != -1){
          _specs.removeAt(_specIndex);
          _specs.insert(_specIndex, spec);
        }
      }
      // --------------------------------
    }
    // ----------------------------------------------
    /// B - WHEN NOT SELECTED
    else {
      // --------------------------------
      /// B1 - WHEN CAN PICK MANY
      if (specList.canPickMany == true){
        _specs.add(spec);
      }
      // --------------------------------
      /// B2 - WHEN CAN NOT PICK MANY
      else {

        final bool _listContainSameListID = Spec.specsContainOfSameListID(
          specs: _specs,
          specsListID: specList.id,
        );

        /// C1 - WHEN LIST CONTAIN SAME LIST ID ALREADY
        if (_listContainSameListID == true){
          final int _specIndex = _allSelectedSpecs.indexWhere((sp) => sp.specsListID == specList.id);
          if (_specIndex != -1){
            _specs.removeAt(_specIndex);
            _specs.insert(_specIndex, spec);
          }
        }

        /// C2 - WHEN LIST DOES NOT CONTAIN ANY OF SAME LIST ID
        else {
          _specs.add(spec);
        }
      }
      // --------------------------------
    }
    // ----------------------------------------------

    return _specs;

  }
// -----------------------------------------------------------------------------
  Future<void> _onSpecsListTap(SpecList specList) async {

    List<Spec> _finalSpecsList;

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
        });

        // /// B1 - WHEN CAN PICK MANY
        // if (specList.canPickMany == true){
        //
        //   setState(() {
        //     _allSelectedSpecs = Spec.putSpecsInSpecs(
        //       parentSpecs: _allSelectedSpecs,
        //       childrenSpecs: _result,
        //     );
        //   });
        //
        // }
        //
        // /// B2 - WHEN CAN ONLY PICK ONE
        // else {
        //
        //   int _specIndex = _allSelectedSpecs.indexWhere((spec) => spec.specsListID == specList.id);
        //
        //   /// if first spec of this list
        //   if (_specIndex == -1){
        //     setState(() {
        //       _allSelectedSpecs.addAll(_result);
        //     });
        //   }
        //
        //   /// if a spec of this list exists
        //   else {
        //     setState(() {
        //       _allSelectedSpecs.removeAt(_specIndex);
        //       _allSelectedSpecs.addAll(_result);
        //     });
        //   }
        //
        // }

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
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    final List<SpecList> propertySpecLists = SpecList.propertySpecLists;

    const double _specTileHeight = 70;
    final double _specTileWidth = _screenWidth - (Ratioz.appBarMargin * 2);
    final BorderRadius _tileBorders = Borderers.superBorderAll(context, Ratioz.appBarCorner);

    final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },
      appBarRowWidgets: const<Widget>[],

      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: MaxBounceNavigator(
          child: ListView.builder(
              itemCount: propertySpecLists.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
              itemBuilder: (ctx, index){

                final SpecList _specList = propertySpecLists[index];
                final Chain _chain = _specList.specChain;

                final List<Spec> _selectedSpecs = Spec.getSpecsByListID(
                  specsList: _allSelectedSpecs,
                  specsListID: _specList.id,
                );

                return
                  GestureDetector(
                    onTap: () => _onSpecsListTap(_specList),
                    child: Center(
                      child: Container(
                        width: _specTileWidth,
                        // height: _specTileHeight,
                        margin: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                        decoration: BoxDecoration(
                          color: Colorz.white10,
                          borderRadius: _tileBorders,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            /// SPECS LIST ROW
                            Container(
                              width: _specTileWidth,
                              child: Row(
                                children: <Widget>[

                                  /// - ICON
                                  DreamBox(
                                    width: _specTileHeight,
                                    height: _specTileHeight,
                                    color: Colorz.white10,
                                    corners: _tileBorders,
                                    bubble: false,
                                  ),

                                  /// - LIST NAME
                                  Expanded(
                                    child: Container(
                                      height: _specTileHeight,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Container(
                                            width: _specNameBoxWidth,
                                            child: SuperVerse(
                                              verse: Name.getNameByCurrentLingoFromNames(context, _chain.names),
                                              centered: false,
                                              margin: 10,
                                              maxLines: 2,
                                            ),
                                          ),

                                          // SuperVerse(
                                          //   verse: Name.getNameByCurrentLingoFromNames(context, _chain.names),
                                          //   centered: false,
                                          // ),

                                        ],
                                      ),

                                    ),
                                  ),

                                  /// - ARROW
                                  DreamBox(
                                    width: _specTileHeight,
                                    height: _specTileHeight,
                                    corners: _tileBorders,
                                    icon: Iconizer.superArrowENRight(context),
                                    iconSizeFactor: 0.3,
                                    bubble: false,
                                  ),

                                ],
                              ),
                            ),

                            /// SELECTED SPECS ROW
                            if (_selectedSpecs.length != 0)
                            Container(
                              width: _specTileWidth,
                              child: Row(
                                children: <Widget>[

                                  /// FAKE SPACE UNDER ICON
                                  Container(
                                    width: _specTileHeight,
                                    height: 10,
                                  ),

                                   /// SELECTED SPECS BOX
                                   Container(
                                     width: _specTileWidth - _specTileHeight,
                                     padding: const EdgeInsets.all(Ratioz.appBarMargin),
                                     child: Wrap(
                                       spacing: Ratioz.appBarPadding,
                                       children: <Widget>[

                                         ...List<Widget>.generate(
                                             _selectedSpecs.length,
                                                 (index){

                                               final Spec _spec = _selectedSpecs[index];
                                               // final String _specID = _spec.specsListID;
                                               // final dynamic _value = _spec.value;

                                               final String _specName = Spec.getSpecNameFromSpecsLists(
                                                 context: context,
                                                 spec: _spec,
                                                 specsLists: propertySpecLists,
                                               );

                                               return
                                                 DreamBox(
                                                     height: 30,
                                                     icon: Iconz.XLarge,
                                                     margins: const EdgeInsets.symmetric(vertical: 2.5),
                                                     verse: _specName,
                                                     verseColor: Colorz.white255,
                                                     verseWeight: VerseWeight.thin,
                                                     verseItalic: true,
                                                     verseScaleFactor: 1.5,
                                                     verseShadow: false,
                                                     iconSizeFactor: 0.4,
                                                     color: Colorz.black255,
                                                     bubble: false,
                                                     onTap: () => _removeSpec(_spec),
                                                 );

                                             }
                                         ),

                                       ],
                                     ),
                                   ),

                                ],

                              ),
                            ),

                          ],


                        ),
                      ),
                    ),
                  );



                // ChainExpander(
                  //   chain: _chain,
                  //   width: _screenWidth * 0.9,
                  //   margin: const EdgeInsets.only(top: Ratioz.appBarPadding, bottom: Ratioz.appBarPadding),
                  //   onTap: (bool isExpanded) => _onSpecsListTap(isExpanded),
                  //   icon: _chain.icon,
                  //   firstHeadline: Name.getNameByCurrentLingoFromNames(context, _chain.names),
                  //   secondHeadline: null,
                  // );

              }
          ),
        ),
      ),
    );
  }


}
