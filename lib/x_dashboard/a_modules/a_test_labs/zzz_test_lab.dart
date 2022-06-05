import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/animators/list_pusher.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/foundation/storage.dart' as Storage;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/a_specialized_labs.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/test_widgets/is_connected_button.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/test_widgets/is_signed_in_button.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
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
}
/// --------------------------------------------------------------------------
class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  ZoneProvider _zoneProvider;
  PhraseProvider _phraseProvider;
  ScrollController _scrollController; /// tamam disposed
  AnimationController _animationController; /// tamam disposed
  UiProvider _uiProvider;
  ChainsProvider  _chainsProvider;
  String _fuckingText;
  BzzProvider _bzzProvider;
  FlyersProvider _flyersProvider;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _fuckingText = 'Lorum Ipsum Gypsum board\n'
        'This is a test paragraph that includes design '
        'and Designs with projects of designs and properties '
        'with a touch of crafts and several other cool '
        'awesome stuff bitch';


    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

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

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _highlightedText.dispose();
    _thePic.dispose();
    super.dispose(); /// tamam
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
  final ValueNotifier<int> _rebuildListPusher = ValueNotifier(0);
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
    final List<FlyerModel> _savedFlyers = _flyersProvider.savedFlyers;
    FlyerModel.blogFlyers(flyers: _savedFlyers);
    final BzModel _myActiveBz = _bzzProvider.myActiveBz;
    _myActiveBz.blogBz();
    final String _wallPhid = _chainsProvider.wallPhid;
    blog('wall phid : $_wallPhid');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    blog('SCREEN WIDTH : ($_screenWidth) <=> SCREEN HEIGHT ($_screenHeight)');
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
      zoneButtonIsOn: false,
      appBarRowWidgets: const <Widget>[
        IsSignedInButton(),
        IsConnectedButton(),
      ],
      layoutWidget: Column(
        // physics: const BouncingScrollPhysics(),
        // controller: _scrollController,
        children: <Widget>[

          const Stratosphere(),

          const SpecializedLabs(),

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

                const BubblesSeparator(),

                /// DO SOMETHING
                WideButton(
                    color: Colorz.red255,
                    verse: 'GET THE IMAGE THINGy',
                    icon: Iconz.dvGouran,
                    onTap: () async {

                      const String _url = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/notesBanners%2F1654159842665023.jpg?alt=media&token=cf0e2f0a-e3c5-492e-9f44-bb7217bd20fd';

                      _thePic.value = _url;

                      final String _with = await Storage.getImageNameByURL(
                        url: _url,
                        context: context,
                        withExtension: true,
                      );

                      final String _without = await Storage.getImageNameByURL(
                        url: _url,
                        context: context,
                        withExtension: false,
                      );


                      // final String _fileName = '';
                      blog('file name is : _with : ( $_with )');
                      blog('file name is : _without : ( $_without )');

                    }
                    ),

                WideButton(
                    color: Colorz.red255,
                    verse: 'Do Something',
                    icon: Iconz.star,
                    onTap: () async {

                    }),

                /// TEXT FIELD
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colorz.bloodTest,
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: SuperTextField(
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
                              keyboardTextInputAction: TextInputAction.newline,
                              validator: (){
                                if (stringContainsSubString(string: _textController.text, subString: 'a77a ') == true){
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
                    Container(
                      width: 50,
                      height: _concludedHeight,
                      color: Colorz.yellow255,
                    ),
                  ],
                ),

                ValueListenableBuilder(
                    valueListenable: _thePic,
                    builder: (_, dynamic pic, Widget child){
                      return SuperImage(
                        width: 100,
                        height: 100,
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

                /// DO SOMETHING
                WideButton(
                    color: Colorz.black255,
                    verse: 'DO THE CURRENCIES',
                    icon: Iconz.contAfrica,
                    onTap: () async {
                      // final List<CurrencyModel> _currencies = _zoneProvider.allCurrencies;
                      //
                      // final List<String> _currenciesIDs = CurrencyModel.getCurrenciesIDs(_currencies);
                      //
                      // blog(_currenciesIDs);
                      // blog('xxx-x-x-x-x------------------------x-x-x---------------------------------------------------------------');
                      // final Chain _specsChain = _chainsProvider.specsChain;
                      //
                      // _specsChain.blogChain();
                      //
                      // blog('xxx-x-x-x-x------------------------x-x-x---------------------------------------------------------------');
                      //
                      // final List<Chain> _newSons = Chain.replaceChainInChains(
                      //     chains: _specsChain.sons,
                      //     oldChainID: 'phid_s_currency',
                      //     chainToReplace: Chain(
                      //       id: 'phid_s_currency',
                      //       sons: _currenciesIDs,
                      //     ),
                      // );
                      //
                      // final Chain _finalChain = Chain(
                      //   id: _specsChain.id,
                      //   sons: _newSons,
                      // );
                      //
                      // _finalChain.blogChain();
                      //
                      // await createNamedDoc(
                      //     context: context,
                      //     collName: FireColl.chains,
                      //     docName: FireDoc.chains_specs,
                      //     input: _finalChain.toMap(),
                      // );
                    }),

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

                /// LIST PUSHER
                if (Keyboarders.keyboardIsOn(context) == true)
                ValueListenableBuilder(
                    valueListenable: _rebuildListPusher,
                    builder: (_, int rebuilds, Widget child){

                      return ListPusher(
                        maxHeight: 160,
                        expand: Keyboarders.keyboardIsOn(context) == true,
                        duration: const Duration(seconds: 1),
                      );

                    }
                ),

                DreamBox(
                  width: _screenWidth,
                  height: 100,
                  color: Colorz.green255,
                  verse: 'Rebuild the Fucker Bitch',
                  onTap: (){
                    _rebuildListPusher.value = _rebuildListPusher.value++;
                  },
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
