import 'dart:io';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/test_widgets/is_connected_button.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/test_widgets/is_signed_in_button.dart';
import 'package:bldrs/xxxxx_specialized_labs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TestLab({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TestLabState createState() => _TestLabState();
  /// --------------------------------------------------------------------------
}
/// --------------------------------------------------------------------------
class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  ZoneProvider _zoneProvider;
  PhraseProvider _phraseProvider;
  ScrollController _scrollController;
  AnimationController _animationController;
  UiProvider _uiProvider;
  ChainsProvider  _chainsProvider;
  String _fuckingText;
  // FlyersProvider _flyersProvider;
  BzzProvider _bzzProvider;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _fuckingText = 'Lorum Ipsum Gypsum board\n'
        'This is a test paragraph that includes design '
        'and Designs with projects of designs and properties '
        'with a touch of trades and several other cool '
        'awesome stuff bitch';


    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    // _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    _scrollController = ScrollController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _uiProvider = Provider.of<UiProvider>(context, listen: false);

    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

    _hashVerse = ValueNotifier(_original);

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _textController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _highlightedText.dispose();
    _thePic.dispose();
    _hashVerse.dispose();
    _showHash.dispose();
    _theFiles.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      // _triggerLoading().then((_) async {
      //   /// do Futures here
      //   unawaited(_triggerLoading(function: () {
      //     /// set new values here
      //   }));
      // });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /*
  /// DIALOG THAT LISTENS TO PROVIDER CHANGES
  Future<void> _showDialog(Function onTap) async {

    final double _height = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.5);

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BottomDialog.dialogCorners(context),
      ),
      backgroundColor: Colorz.blackSemi255,
      barrierColor: Colorz.black150,
      enableDrag: true,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context){

        return SizedBox(
            height: _height,
            width: Scale.superScreenWidth(context),
            child: Scaffold(
              backgroundColor: Colorz.nothing,
              resizeToAvoidBottomInset: false,
              body: BottomDialog(
                height: _height,
                title: 'WAT DA FAK',
                child: StatefulBuilder(

                  builder: (_, state){

                    /// this provider can listen properly to variable changes inside this dialog
                    final UiProvider _ui = Provider.of<UiProvider>(context, listen: true);

                    final bool _isLoading = _ui.isLoading;

                    return Column(
                      children: <Widget>[

                        SuperVerse(
                          verse: '$_isLoading',
                          size: 4,
                        ),

                        DreamBox(
                          height: 50,
                          width: 50,
                          icon: Iconz.reload,
                          iconSizeFactor: 0.6,
                          onTap: () async {

                            if (onTap == null){

                              // await _showDialog((){
                                // blog('trying to trigger loading');
                                // _ui.triggerLoading();

                                await Nav.goToNewScreen(
                                    context: context,
                                    screen: const BldrsDashBoard(),
                                );

                              // });

                            }

                            else {
                              onTap();
                            }


                          },
                        )

                      ],
                    );

                  },

                ),
              ),
            ));

      },
    );

  }*/
// -----------------------------------------------------------------------------
  final TextEditingController _textController = TextEditingController(); /// tamam disposed
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// -----------------------------------------------------------------------------
  final ValueNotifier<String> _highlightedText = ValueNotifier<String>(null); /// tamam disposed
  void _onTextFieldChanged(String text){
    blog('received text : $text');

    _highlightedText.value = text;
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<dynamic> _thePic = ValueNotifier(null);
// -----------------------------------------------------------------------------
  /*
  Future<void> _scrollOnKeyboard() async {

    if (Keyboarders.keyboardIsOn(context) == true){
      blog(' + keyboard got on and should scroll +');
      await Scrollers.scrollTo(
        controller: _scrollController,
        offset: _scrollController.position.pixels + 100,
      );
    }
    else {
      blog(' - keyboard got on and should scroll -');
      await Scrollers.scrollTo(
        controller: _scrollController,
        offset: _scrollController.position.pixels - 100,
      );
    }

  }
*/
// -----------------------------------------------------------------------------
  void blogEverything(){
    final ZoneModel _currentZone = _zoneProvider.currentZone;
    _currentZone.blogZone();
    final bool _isLoading = _uiProvider.isLoading;
    blogLoading(loading: _isLoading, callerName: 'TestScreen');
    final List<Phrase> _phrases = _phraseProvider.basicPhrases;
    Phrase.blogPhrases(_phrases);
    final BzModel _myActiveBz = _bzzProvider.myActiveBz;
    _myActiveBz.blogBz();
    final String _wallPhid = _chainsProvider.wallPhid;
    blog('wall phid : $_wallPhid');
  }
// -----------------------------------------------------------------------------
  final String _original = 'Fuck you ${TextMod.userNameVarTag1} you fuck '
      'ya ${TextMod.userNameVarTag1}, ya bitch fuck you company ${TextMod.bzNameVarTag1} and your co founder ${TextMod.authorNameVarTag1} '
      'after that, lets have a beer at ${TextMod.bzNameVarTag2} at night because i need to eat two chickens';
// -----------------------------------------------------------------------------
  ValueNotifier<String> _hashVerse;
  final ValueNotifier<bool> _showHash = ValueNotifier(false);
  void replaceHash(){

    final String _output = TextMod.replaceVarTag(
      input: _original,
      userName1: 'Ahmed tharwat',
      bzName1: 'الشركة',
      bzName2: 'جونيز بومبون',
      authorName1: 'A7mad Fat7y 3ab el 3al فلوكس',
    );

    _hashVerse.value = _showHash.value == true ? _output : _original;
    _showHash.value = !_showHash.value;

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<List<File>> _theFiles = ValueNotifier(<File>[]);
// -----------------------------------------------------------------------------

  /// xxx

  Future<void> _fastTest(BuildContext context) async {

    final Chain chainS = ChainsProvider.proGetBigChainS(
        context: context,
        // onlyUseCityChains: false,
        listen: false
    );

    final List<String> _paths = ChainPathConverter.generateChainsPaths(
        parentID: 'chainS',
        chains: chainS.sons,
    );

    blog('chainS paths are : ${_paths.length} paths');

    Map<String, dynamic> _map = {};
    final List<String> _keys = <String>[];

    for (int i = 0; i < _paths.length; i++){

      final String _path = _paths[i];
      final String _key = ChainPathConverter.generateChainSPathKeyForFirebase(path: _path);
      _keys.add(_key);

      if (_map[_key] == null){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: _key,
          value: _path,
        );
      }

      else {

        final String _phid = ChainPathConverter.getLastPathNode(_path);
        final bool _continue = await CenterDialog.showCenterDialog(
            context: context,
            height: 600,
            boolDialog: true,
            title: 'obbaaa',
            body: 'phid : $_phid'
                '\n.\n has duplicate key already there'
                '\n.\nmap[phid]\n${_map[_phid]}'
                '\n.\npath\n$_path',
            confirmButtonText: 'continue ?',
          );

          if (_continue == false){
            break;
          }
      }

    }

    // Stringer.blogStrings(strings: _paths);
    //
    // final List<String> _mapKeys = _map.keys.toList();
    // // blog('map has ${_keys.length} keys : while list has ${_paths.length} paths');
    //
    // Stringer.blogStringsListsDifferences(
    //   strings1: _mapKeys,
    //   strings2: _keys,
    // );

    Mapper.blogMap(_map);

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Upload ?',
      body: 'Finished iterations,, wanna upload ?',
      boolDialog: true,
    );

    if (_continue == true){

      await Real.createDocInPath(
        context: context,
        pathWithoutDocName: 'chains',
        addDocIDToOutput: false,
        docName: 'bigChainS',
        map: _map,
      );

    }


    // Mapper.blogMap(_map);

  }

  /*

  /phid_k_flyer_type_product/phid_k_group_prd_appliances/phid_k_sub_prd_app_wasteDisposal/phid_k_prd_app_waste_compactor/

duplicate
phid_k_pt_studio

   */

  /// xxx

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // blog('SCREEN WIDTH : ($_screenWidth) <=> SCREEN HEIGHT ($_screenHeight)');
// -----------------------------------------------------------------------------

    /// TAMAM THANK YOU ALLAH
    const int numberOfLines = 1;
    const int _textSize = 2;
    const double _sizeFactor = 1; // 1.5429 max factor before box starts expanding
    final double _concludedHeight = SuperTextField.getFieldHeight(
        context: context,
        minLines: numberOfLines,
        textSize: _textSize,
        scaleFactor: _sizeFactor,
        withBottomMargin: true,
        withCounter: true,
    );
    final double _fieldWidth = BldrsAppBar.width(context) - 50;

    return MainLayout(
      key: const ValueKey('test_lab'),
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      // navBarIsOn: false,
      sectionButtonIsOn: false,
      appBarRowWidgets: <Widget>[

        const IsSignedInButton(),

        const SizedBox(
          width: 10,
          height: 10,
        ),

        const IsConnectedButton(),

        /// IMAGE
        ValueListenableBuilder(
            valueListenable: _thePic,
            builder: (_, dynamic pic, Widget child){
              return SuperImage(
                width: 40,
                height: 40,
                // scale: 1,
                boxFit: BoxFit.fitWidth,
                pic: pic ?? Iconz.dumUniverse,
                iconColor: Colorz.blue255,
                // loading: false,
                // backgroundColor: Colorz.black255,
                corners: 10,
                // greyscale: false,
              );
            }
        ),

        const Expander(),

        /// DO SOMETHING
        AppBarButton(
            verse: 'chainS',
            onTap: () async {

              final Chain _proChainS = ChainsProvider.proGetBigChainS(
                  context: context,
                  // onlyUseCityChains: false,
                  listen: false,
              );

              Map<String, dynamic> _map = await Real.readDocOnce(
                context: context,
                collName: 'chains',
                docName: 'bigChainS',
              );

              _map = Mapper.removePair(map: _map, fieldKey: 'id');

              final List<String> _paths = <String>[];

              final List<String> _keys = _map.keys.toList();
              blog('chain map has ${_keys.length} keys');
              for (final String key in _keys){
                final String path = _map[key];
                _paths.add(path);
              }

              final List<Chain> _chainKSons = ChainPathConverter.createChainsFromPaths(
                paths: _paths,
              );

              final Chain chain = Chain(
                id: 'chainS',
                sons: _chainKSons,
              );

              final bool _chainsIdentical = Chain.checkChainsAreIdentical(
                chain1: chain,
                chain2: _proChainS,
              );

              blog('identical : $_chainsIdentical');

              final List<String> _originalPaths = ChainPathConverter.generateChainsPaths(
                  parentID: 'chainS',
                  chains: _proChainS.sons,
              );

              Stringer.blogStringsListsDifferences(
                  strings1: Stringer.sortAlphabetically2(_originalPaths),
                  strings2: Stringer.sortAlphabetically2(_paths),
              );


            }
        ),

        AppBarButton(
            verse: 'fastTestss',
            onTap: () async {await _fastTest(context);},
        ),

      ],
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        children: <Widget>[

          const Stratosphere(),

          SizedBox(
            width: _screenWidth,
            height: _screenHeight - Stratosphere.smallAppBarStratosphere - SpecializedLabs.height,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              children: <Widget>[

                /// PARAGRAPH
                WidgetFader(
                  fadeType: FadeType.fadeIn,
                  curve: Curves.fastOutSlowIn,
                  child: SuperVerse(
                    verse: _fuckingText,
                    maxLines: 10,
                    centered: false,
                    margin: 10,
                    highlight: _highlightedText,
                  ),
                ),

                /// TEXT FIELD
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// FIELD
                    Container(
                      color: Colorz.bloodTest,
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: SuperTextField(
                              title: 'test Lab',
                              isFormField: true,
                              width: _fieldWidth,
                              textController: _textController,
                              // fieldColor: Colorz.white20,
                              maxLines: 1000,
                              // minLines: numberOfLines,
                              maxLength: 10,
                              counterIsOn: true,
                              onEditingComplete: (){
                                blog('editing just completed');
                              },
                              onTap: (){
                                blog('just tapped');
                              },
                              // corners: 50,
                              // autofocus: false,
                              hintText: 'fuck you',
                              onSubmitted: (String val){
                                blog('submitted val : $val');
                              },
                              // margins: const EdgeInsets.symmetric(vertical: 50),
                              // textSize: _textSize,
                              // textSizeFactor: _sizeFactor,
                              textInputAction: TextInputAction.newline,
                              validator: (){

                                final bool _containsSubString = TextChecker.stringContainsSubString(
                                    string: _textController.text,
                                    subString: 'a77a ',
                                );

                                if (_containsSubString == true){
                                  return 'you can not say a77a';
                                }
                                else {
                                  return null;
                                }
                              },
                              onChanged: _onTextFieldChanged,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// SIZE
                    Container(
                      width: 50,
                      height: _concludedHeight,
                      color: Colorz.yellow255,
                    ),

                  ],
                ),

                /// HASH VERSE
                // ValueListenableBuilder(
                //   valueListenable: _showHash,
                //   builder: (_, bool showHash, Widget child){
                //
                //     return ValueListenableBuilder(
                //       valueListenable: _hashVerse,
                //       builder: (_, String verse, Widget child){
                //
                //         return Container(
                //           width: 200,
                //           margin: Scale.superMargins(margins: 10),
                //           child: SuperVerse(
                //             verse: verse,
                //             maxLines: 6,
                //             weight: VerseWeight.thin,
                //             size: 3,
                //             italic: true,
                //           ),
                //         );
                //
                //         },
                //     );
                //
                //     },
                // ),

                /// HORIZONTAL FLYERS GRID
                // Center(
                //   child: Container(
                //     width: 300,
                //     height: 150,
                //     color: Colorz.bloodTest,
                //     margin: Scale.superMargins(margins: 20),
                //     child: FlyersGrid(
                //       gridWidth: 300,
                //       gridHeight: 150,
                //       scrollController: ScrollController(),
                //       scrollDirection: Axis.horizontal,
                //       topPadding: 0,
                //       numberOfColumnsOrRows: 1,
                //       // isLoadingGrid: false,
                //       paginationFlyersIDs: const <String>[
                //         'IcWyY7CZzQ1FUieRaoG4',
                //         'IcWyY7CZzQ1FUieRaoG4',
                //         'IcWyY7CZzQ1FUieRaoG4',
                //         'IcWyY7CZzQ1FUieRaoG4',
                //         'IcWyY7CZzQ1FUieRaoG4',
                //       ],
                //     ),
                //   ),
                // ),

                /// PROMOTED FLYERS
                // Selector<FlyersProvider, List<FlyerModel>>(
                //   selector: (_, FlyersProvider flyersProvider) => flyersProvider.promotedFlyers,
                //   builder: (BuildContext ctx, List<FlyerModel> flyers, Widget child){
                //
                //     return
                //
                //         FlyersShelf(
                //           title: 'Promoted Flyers',
                //           titleIcon: Iconz.flyer,
                //           flyers: flyers,
                //           flyerOnTap: (FlyerModel flyer) => onFlyerTap(context: context, flyer: flyer),
                //           onScrollEnd: (){blog('REACHED SHELF END');},
                //         );
                //
                //   },
                // ),

                // /// LIST PUSHER
                // if (Keyboarders.keyboardIsOn(context) == true)
                // ValueListenableBuilder(
                //     valueListenable: _rebuildListPusher,
                //     builder: (_, int rebuilds, Widget child){
                //
                //       return ListPusher(
                //         maxHeight: 160,
                //         expand: Keyboarders.keyboardIsOn(context) == true,
                //         duration: const Duration(seconds: 1),
                //       );
                //
                //     }
                // ),
                //
                // DreamBox(
                //   width: _screenWidth,
                //   height: 100,
                //   color: Colorz.green255,
                //   verse: 'Rebuild the Fucker Bitch',
                //   onTap: (){
                //     _rebuildListPusher.value = _rebuildListPusher.value++;
                //   },
                // ),

                /// IMAGE
                ValueListenableBuilder(
                    valueListenable: _theFiles,
                    builder: (_, List<File> files, Widget child){

                      if (Mapper.checkCanLoopList(files) == false){
                        return const SizedBox();
                      }

                      else {
                        return Container(
                          width: _screenWidth,
                          height: 100,
                          color: Colorz.grey80,
                          child: ListView.builder(
                            itemCount: files.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, int index){

                              return SuperImage(
                                width: 100,
                                height: 100,
                                // scale: 1,
                                boxFit: BoxFit.fitHeight,
                                pic: files[index],
                                iconColor: Colorz.blue255,
                                // loading: false,
                                // backgroundColor: Colorz.black255,
                                corners: 10,
                                // greyscale: false,
                              );

                            },
                          ),
                        );
                      }

                    }
                ),


              ],
            ),
          ),

          const SpecializedLabs(),

        ],
      ),
    );
  }
}
