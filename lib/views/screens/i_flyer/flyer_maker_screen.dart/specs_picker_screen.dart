import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/spec_picker_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SpecSelectorScreen extends StatefulWidget {
  final FlyerType flyerType;

  SpecSelectorScreen({
    @required this.flyerType,
});

  @override
  _SpecSelectorScreenState createState() => _SpecSelectorScreenState();
}

class _SpecSelectorScreenState extends State<SpecSelectorScreen> with SingleTickerProviderStateMixin{

  List<Spec> _allSelectedSpecs = [];

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

  Future<void> _onSpecsListTap(SpecList specList) async {

    await Nav.goToNewScreen(context, SpecPickerScreen(
      specList: specList,
      allSelectedSpecs: _allSelectedSpecs,
    ));

  }

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    List<SpecList> propertySpecLists = SpecList.propertySpecLists;

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
                final List<Spec> _selectedSpecs = Spec.dummySpecs();

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

                            Container(
                              width: _specTileWidth,
                              child: Row(
                                children: <Widget>[

                                  /// - icon
                                  DreamBox(
                                    width: _specTileHeight,
                                    height: _specTileHeight,
                                    color: Colorz.white10,
                                    corners: _tileBorders,
                                    bubble: false,
                                  ),

                                  /// - list name
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

                                  /// - arrow
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

                            Container(
                              width: _specTileWidth,
                              padding: const EdgeInsets.all(Ratioz.appBarMargin),
                              child:  Wrap(
                                spacing: Ratioz.appBarPadding,
                                children: <Widget>[

                                  ...List<Widget>.generate(
                                      _selectedSpecs.length,
                                          (index){

                                        final Spec _spec = _selectedSpecs[index];
                                        final String _specID = _spec.specID;
                                        final dynamic _value = _spec.value;

                                        return
                                          DreamBox(
                                              height: 30,
                                              icon: null, //Iconizer.superContactIcon(_contactsWithStrings[index].contactType),
                                              // margins: const EdgeInsets.only(left: Ratioz.appBarPadding),
                                              verse: _value.toString(),
                                              verseColor: Colorz.white255,
                                              verseWeight: VerseWeight.thin,
                                              verseItalic: true,
                                              iconSizeFactor: 0.6,
                                              color: Colorz.bloodTest,
                                              onTap: (){}
                                          );
                                      }
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
