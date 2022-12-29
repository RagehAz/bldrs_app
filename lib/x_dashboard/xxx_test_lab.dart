import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:widget_fader/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/xxxx_specialized_labs.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/test_widgets/is_connected_button.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/test_widgets/is_signed_in_button.dart';
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

class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // -----------------------------------------------------------------------------

  /// FAST TEST

  // --------------------

  /// ======================================================================[ ]
  // -------------------------------------------------
  Future<void> _fastTest(BuildContext context) async {

    /// ---------------- >>>


  }
  // -------------------------------------------------
  /// ======================================================================[ ]

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
  // --------------------
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
  // --------------------
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
                title:  'WAT DA FAK',
                child: StatefulBuilder(

                  builder: (_, state){

                    /// this provider can listen properly to variable changes inside this dialog
                    final UiProvider _ui = Provider.of<UiProvider>(context, listen: true);

                    final bool _isLoading = _ui.isLoading;

                    return Column(
                      children: <Widget>[

                        SuperVerse(
                          verse:  '$_isLoading',
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
  // --------------------
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final ValueNotifier<String> _highlightedText = ValueNotifier<String>(null);
  void _onTextFieldChanged(String text){
    blog('received text : $text');

    final String _phone  = TextMod.nullifyNumberIfOnlyCountryCode(
      number: text,
      countryID: 'egy',
    );

    setNotifier(notifier: _highlightedText, mounted: mounted, value: _phone);
  }
  // --------------------
  final ValueNotifier<dynamic> _thePic = ValueNotifier(null);
  // --------------------
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
  // --------------------
  void blogEverything(){
    final ZoneModel _currentZone = _zoneProvider.currentZone;
    _currentZone.blogZone();
    final bool _isLoading = _uiProvider.isLoading;
    blogLoading(loading: _isLoading, callerName: 'TestScreen');
    final List<Phrase> _phrases = _phraseProvider.mainPhrases;
    Phrase.blogPhrases(_phrases);
    final BzModel _myActiveBz = _bzzProvider.myActiveBz;
    _myActiveBz.blogBz();
    final String _wallPhid = _chainsProvider.wallPhid;
    blog('wall phid : $_wallPhid');
  }
  // --------------------
  final String _original = 'Fuck you ${TextMod.userNameVarTag1} you fuck '
      'ya ${TextMod.userNameVarTag1}, ya bitch fuck you company ${TextMod.bzNameVarTag1} and your co founder ${TextMod.authorNameVarTag1} '
      'after that, lets have a beer at ${TextMod.bzNameVarTag2} at night because i need to eat two chickens';
  // --------------------
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

    setNotifier(notifier: _hashVerse, mounted: mounted, value: _showHash.value  == true ? _output : _original);
    setNotifier(notifier: _showHash, mounted: mounted, value: !_showHash.value);

  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<File>> _theFiles = ValueNotifier(<File>[]);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    // -----------------------------------------------------------------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // blog('SCREEN WIDTH : ($_screenWidth) <=> SCREEN HEIGHT ($_screenHeight)');
    // -----------------------------------------------------------------------------
    /// THANK YOU ALLAH
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
      // key: const ValueKey('test_lab'),
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
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
                fit: BoxFit.fitWidth,
                pic: pic ?? Iconz.dvBlackHole,
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
            verse: Verse.plain('chainS'),
            onTap: () async {

            }
        ),

        /// FAST TEST
        AppBarButton(
          verse: Verse.plain('fastTest'),
          onTap: () async {await _fastTest(context);},
        ),

      ],
      child: ListView(
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
                    verse: Verse.plain(_fuckingText),
                    maxLines: 10,
                    // centered: true,
                    margin: 10,
                    highlight: _highlightedText,
                    // textDirection: TextDirection.ltr,
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
                              appBarType: AppBarType.basic,
                              globalKey: globalKey,
                              titleVerse: Verse.plain('test Lab'),
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
                              hintVerse: Verse.plain('fuck you'),
                              onSubmitted: (String val){
                                blog('submitted val : $val');
                              },
                              // margins: const EdgeInsets.symmetric(vertical: 50),
                              // textSize: _textSize,
                              // textSizeFactor: _sizeFactor,
                              textInputAction: TextInputAction.newline,
                              validator: (String text){

                                final bool _containsSubString = TextCheck.stringContainsSubString(
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

                ValueListenableBuilder(
                    valueListenable: _highlightedText,
                    builder: (_, String text, Widget child){

                      return SuperVerse(
                        verse: Verse.plain(text),
                        labelColor: Colorz.blue80,
                      );

                    }
                ),

                // PhidsButtonsList(
                //   phids: Chain.getOnlyPhidsSonsFromChains(chains: _chainsProvider.bldrsChains),
                //   buttonWidth: _fieldWidth,
                //   onPhidTap: (String phid){
                //     blog('phid is : $phid');
                //   },
                // ),

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
                //   verse:  'Rebuild the Fucker Bitch',
                //   onTap: (){
                //     _rebuildListPusher.value  = _rebuildListPusher.value++;
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
                            // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                            itemBuilder: (_, int index){

                              return SuperImage(
                                width: 100,
                                height: 100,
                                // scale: 1,
                                fit: BoxFit.fitHeight,
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
  // -----------------------------------------------------------------------------
}
