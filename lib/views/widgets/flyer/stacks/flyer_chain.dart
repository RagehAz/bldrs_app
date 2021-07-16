import 'dart:io';

import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/screens/x1_publisher_screen.dart';
import 'package:bldrs/views/screens/x2_flyer_editor_screen.dart';
import 'package:bldrs/views/screens/x3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FlyerChain extends StatefulWidget {
  final int chainNumber;
  final Function onDeleteChain;
  final double chainHeight;
  final BzModel bzModel;
  final bool firstTimer;
  final ValueKey chainKey;

  FlyerChain({
    @required this.chainNumber,
    @required this.onDeleteChain,
    @required this.chainHeight,
    @required this.bzModel,
    @required this.firstTimer,
    @required this.chainKey,
});


  @override
  _FlyerChainState createState() => _FlyerChainState();
}

class _FlyerChainState extends State<FlyerChain> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final _formKey = GlobalKey<FormState>();
  DraftFlyerModel _draftFlyer;

  int _textLength = 0;
  final int _flyerTitleMaxLength = Standards.flyerTitleMaxLength;
  Color _counterColor = Colorz.White80;

  List<TextEditingController> _headlinesControllers;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _draftFlyer = _createEmptyDraft();
    _headlinesControllers = TextChecker.createEmptyTextControllers(1);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    TextChecker.disposeAllTextControllers(_headlinesControllers);
    super.dispose();
  }
// -----------------------------------------------------------------------------
  DraftFlyerModel _createEmptyDraft(){
    DraftFlyerModel _draft = DraftFlyerModel(
      assetsSources: new List(),
      assetsFiles: new List(),
      boxesFits: new List(),
      headlinesControllers: new List(),
      key: widget.chainKey,
      state: FlyerState.Draft,
    );
    return _draft;
  }
// -----------------------------------------------------------------------------
  Future<void> _getMultiGalleryImages({double flyerZoneWidth}) async {

    _triggerLoading();

    List<Asset> _assetsSources = _draftFlyer.assetsSources;

    int _maxLength = Standards.getMaxSlidesCount(widget.bzModel.accountType);

    /// A - if max images reached
    if(_maxLength <= _assetsSources.length ){

      await Dialogz.maxSlidesReached(context, _maxLength);

    }

    /// A - if can pick more images
    else {

      List<Asset> _outputAssets;

      if(mounted){

        _outputAssets = await Imagers.getMultiImagesFromGallery(
          context: context,
          images: _assetsSources,
          mounted: mounted,
          accountType: widget.bzModel.accountType,
        );

        /// B - if didn't pick more images
        if(_outputAssets.length == 0){
          // will do nothing
        }

        /// B - if made new picks
        else {

          List<File> _assetsAsFiles = await Imagers.getFilesFromAssets(_outputAssets);
          List<BoxFit> _fits = Imagers.concludeBoxesFits(assets: _assetsSources, flyerZoneWidth: flyerZoneWidth);

          /// TASK : fix this in relation to existing controllers values
          List<TextEditingController> _newControllers = new List();

          setState(() {
            _draftFlyer.assetsSources = _outputAssets;
            _draftFlyer.assetsFiles = _assetsAsFiles;
            _draftFlyer.boxesFits = _fits;
            _draftFlyer.headlinesControllers = _newControllers;
          });

        }

      }

    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  Future <void> _onImageTap(int index) async {

    /// TASK : calculating flyer editor width is redundant and should be in separate method
    double _screenWidth = Scale.superScreenWidth(context);
    double _buttonSize = 50;
    double _panelWidth = _buttonSize + (Ratioz.appBarMargin * 2);
    double _flyerZoneWidth = _screenWidth - _panelWidth - Ratioz.appBarMargin;

    print('index is : $index');
    dynamic _result = await Nav.goToNewScreen(context,
        FlyerEditorScreen(
          draftFlyerModel : _draftFlyer,
          firstTitle : _headlinesControllers.isEmpty ? null : _headlinesControllers[0].text,
          headlinesControllers: _headlinesControllers,
          index: index,
          firstTimer: widget.firstTimer,
          bzModel: widget.bzModel,
          flyerModel: null,
          flyerZoneWidth: _flyerZoneWidth,
          onDeleteImage: (i) => _onImageDelete(i),
        )
    );

    if (_result == 'published'){
      setState(() {
        _draftFlyer.state = FlyerState.Published;
      });
    }

    else {
      print('not published');
    }

    /// why
    Keyboarders.minimizeKeyboardOnTapOutSide(context);
  }
// -----------------------------------------------------------------------------
  void _onImageDelete(int imageIndex) {
      setState(() {
        _draftFlyer.assetsSources.removeAt(imageIndex);
        _draftFlyer.assetsFiles.removeAt(imageIndex);
        _draftFlyer.headlinesControllers.removeAt(imageIndex);
      });
  }
// -----------------------------------------------------------------------------
  dynamic _firstHeadlineValidator(dynamic val){

    if(val.length >= _flyerTitleMaxLength){

      if(_counterColor != Colorz.Red225){
        setState(() {
          _counterColor = Colorz.Red225;
        });
      }

      return 'Only $_flyerTitleMaxLength characters allowed for the flyer title';
    } else {

      if(_counterColor != Colorz.White80){
        setState(() {
          _counterColor = Colorz.White80;
        });
      }

      return null;
    }}
// -----------------------------------------------------------------------------
  void _firstHeadlineOnChanged(String val){
    _formKey.currentState.validate();

    setState(() {
      _textLength = val.length;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    double _overAllHeight = widget.chainHeight;
    const double _stackTitleHeight = 85;
    const double _flyerNumberTagZoneHeight = 15;

    double _stackZoneHeight = _overAllHeight - _stackTitleHeight;
    double _flyerZoneHeight = _stackZoneHeight - _flyerNumberTagZoneHeight - (Ratioz.appBarPadding * 5);

    double _flyerSizeFactor = Scale.superFlyerSizeFactorByHeight(context, _flyerZoneHeight);
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    BorderRadius _flyerBorderRadius = Borderers.superFlyerCorners(context, _flyerZoneWidth);
    BoxDecoration _flyerDecoration = BoxDecoration(
      borderRadius: _flyerBorderRadius,
      color: Colorz.White10,
    );

    BzAccountType _accountType = BzAccountType.Premium;

    double _deleteFlyerButtonSize = _stackTitleHeight * 0.4;
    double _flyerTitleZoneWidth = Scale.superScreenWidth(context) - _deleteFlyerButtonSize - (Ratioz.appBarMargin * 3);

    double _verticalMargin = Ratioz.appBarPadding;

    String _chainNumberString =
    _draftFlyer.state == FlyerState.Draft ? '${widget.chainNumber} .' :
    _draftFlyer.state == FlyerState.Published ? '${widget.chainNumber} - Published @ 6:28 pm ,  Thursday 15 July 2021 .' :
    _draftFlyer.state == FlyerState.Unpublished ? '${widget.chainNumber} - unPublished @ 6:28 pm ,  Thursday 15 July 2021 .' :
    _draftFlyer.state == FlyerState.Draft ? '${widget.chainNumber} .' :
    '${widget.chainNumber} .';

    bool _isPublished = _draftFlyer.state == FlyerState.Published ? true : false;

    return Container(
      width: Scale.superScreenWidth(context),
      height: _overAllHeight,
      color: Colorz.White10,
      margin: EdgeInsets.symmetric(vertical: _verticalMargin),
      child:
      ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          /// FLYER TITLE
          Container(
            width: Scale.superScreenWidth(context),
            height: _stackTitleHeight,
            alignment: Aligners.superCenterAlignment(context),
            // color: Colorz.BloodTest,
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// FLYER TITLE TEXT FIELD & COUNTER
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// CHAIN NUMBER AND COUNTER
                    Container(
                      width: _flyerTitleZoneWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Ratioz.appBarPadding, left: Ratioz.appBarPadding, top: Ratioz.appBarMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            /// CHAIN NUMBER
                            SuperVerse(
                              verse: _chainNumberString,
                              size: 1,
                              italic: true,
                              color: _isPublished ? Colorz. Green255: Colorz.White80,
                              weight: VerseWeight.thin,
                            ),

                            /// TEXT FIELD COUNTER
                            if  (_isPublished == false)
                            SuperVerse(
                              verse: '${_textLength} / ${_flyerTitleMaxLength}',
                              size: 1,
                              italic: true,
                              color: _counterColor,
                              weight: VerseWeight.thin,
                            ),

                          ],
                        ),
                      ),
                    ),

                    /// FIRST HEADLINE TEXT FIELD
                    if  (_isPublished == false)
                    Form(
                      key: _formKey,
                      child: SuperTextField(
                        // onTap: (){},
                        fieldIsFormField: true,
                        height: _stackTitleHeight,
                        width: _flyerTitleZoneWidth,
                        maxLines: 1,
                        inputSize: 2,
                        counterIsOn: false,
                        centered: false,
                        validator: (val) => _firstHeadlineValidator(val),
                        // margin: EdgeInsets.only(top: Ratioz.appBarPadding),
                        hintText: 'Flyer Headline ...',
                        labelColor: Colorz.White10,
                        textController: _headlinesControllers[0],
                        maxLength: _flyerTitleMaxLength,
                        onChanged: (value) => _firstHeadlineOnChanged(value),

                      ),
                    ),

                    /// FIRST HEADLINE AS SUPER VERSE
                    if (_isPublished == true)
                    Container(
                      width: _flyerTitleZoneWidth,
                      height: _deleteFlyerButtonSize,
                      decoration: BoxDecoration(
                        color: Colorz.White10,
                        borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12),
                      ),
                      alignment: Aligners.superCenterAlignment(context),
                      padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                      child: SuperVerse(
                        verse: _headlinesControllers[0].text,
                        centered: false,
                        size: 3,
                      ),
                    ),

                  ],
                ),

                /// SPACER
                SizedBox(
                  width: Ratioz.appBarMargin,
                ),

                /// DELETE DRAFT BUTTON
                Container(
                  width: _deleteFlyerButtonSize,
                  height: _stackTitleHeight,
                  alignment: Alignment.topCenter,
                  child:
                  DreamBox(
                    height: _deleteFlyerButtonSize,
                    width: _deleteFlyerButtonSize,
                    color: _isPublished ? Colorz.Green255 : null,
                    icon: _isPublished ? Iconz.Check : Iconz.XLarge,
                    iconColor: _isPublished ? Colorz.White255 : null,
                    iconSizeFactor: 0.7,
                    onTap: widget.onDeleteChain,
                  ),

                ),

              ],
            ),
          ),

          /// SLIDES CHAIN
          Container(
            width: Scale.superScreenWidth(context),
            height: _stackZoneHeight,
            // color: Colorz.WhiteAir,
            alignment: Aligners.superCenterAlignment(context),
            child: ListView.builder(
              itemCount: _draftFlyer.assetsSources.length + 1,
              scrollDirection: Axis.horizontal,
              itemExtent: _flyerZoneWidth,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              addAutomaticKeepAlives: true,
              itemBuilder: (ctx, index){

                List<Asset> _assetsSources = _draftFlyer.assetsSources;

                bool _indexIsForAddButton = _assetsSources?.length == index ? true : false;

                Asset _asset = _indexIsForAddButton ? null : _assetsSources[index];

                if(_assetsSources != null && _assetsSources.length != 0 && _assetsSources.length != index){
                  String _picName = _asset?.name;
                // print('SLIDES STACK : pic : ${_picName}');
                }

                return
                  Container(
                    margin: EdgeInsets.only(left: Ratioz.appBarPadding, right: Ratioz.appBarPadding, bottom: Ratioz.appBarPadding),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[

                        /// FLYER NUMBER
                        Container(
                          width: _flyerZoneWidth,
                          height: _flyerNumberTagZoneHeight,
                          // padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                          decoration: BoxDecoration(
                            borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner * 0.5),
                            // color: Colorz.WhiteAir,
                          ),
                          alignment: Aligners.superCenterAlignment(context),
                          child:
                          index < _assetsSources.length ?
                          SuperVerse(
                            verse: '${index + 1}',
                            size: 1,
                            color: Colorz.White200,
                            labelColor: Colorz.White10,
                          ) : Container(),
                        ),

                        /// SPACER
                        SizedBox(
                          height: Ratioz.appBarPadding,
                        ),

                        /// IMAGE
                        Container(
                            width: _flyerZoneWidth,
                            height: _flyerZoneHeight,
                            // decoration: _flyerDecoration,
                            child:
                            index < _assetsSources.length ?

                            /// IMAGE
                            GestureDetector(
                              onTap: () => _onImageTap(index),
                              child: Container(
                                width: _flyerZoneWidth,
                                height: _flyerZoneHeight,
                                child: ClipRRect(
                                  borderRadius: _flyerBorderRadius,
                                  child:
                                  Imagers.superImageWidget(_asset, width: _flyerZoneWidth.toInt(), height: _flyerZoneHeight.toInt()),
                                ),
                              ),
                            )

                                :

                            /// ADD IMAGE BUTTON
                            GestureDetector(
                              onTap: () => _getMultiGalleryImages(flyerZoneWidth: _flyerZoneWidth),
                              child: Container(
                                width: _flyerZoneWidth,
                                height: _flyerZoneHeight,
                                decoration: _flyerDecoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                    /// PLUS ICON
                                    DreamBox(
                                      height: _flyerZoneWidth * 0.5,
                                      width: _flyerZoneWidth * 0.5,
                                      icon: Iconz.Plus,

                                      iconColor: Colorz.White20,
                                      bubble: false,
                                      onTap: null,//() => _getMultiGalleryImages(flyerZoneWidth: _flyerZoneWidth),
                                    ),

                                    SizedBox(
                                      height: _flyerZoneWidth * 0.05,
                                    ),

                                    Container(
                                      width: _flyerZoneWidth * 0.95,
                                      child: SuperVerse(
                                        verse: 'Add Photos',
                                        size: 2,
                                        color: Colorz.White20,
                                        maxLines: 2,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            )

                        ),

                      ],
                    ),
                  );



              },
            ),
          ),

        ],
      ),
    );
  }
}
