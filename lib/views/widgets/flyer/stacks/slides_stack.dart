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
import 'package:bldrs/views/screens/x1_flyers_publisher_screen.dart';
import 'package:bldrs/views/screens/x2_flyer_editor_screen.dart';
import 'package:bldrs/views/screens/x3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class SlidesStack extends StatefulWidget {
  final DraftFlyerModel draftFlyerModel;

  final int draftIndex;
  final Function onDeleteDraft;
  final Function onAddPics;
  final double stackHeight;
  final BzModel bzModel;
  final bool firstTimer;

  SlidesStack({
    @required this.draftFlyerModel,

    @required this.draftIndex,
    @required this.onDeleteDraft,
    @required this.onAddPics,
    @required this.stackHeight,
    @required this.bzModel,
    @required this.firstTimer,

});


  @override
  _SlidesStackState createState() => _SlidesStackState();
}

class _SlidesStackState extends State<SlidesStack> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  int _textLength = 0;
  Color _counterColor = Colorz.White80;
  final _formKey = GlobalKey<FormState>();
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
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future <void> _onPictureTap(int index) async {
    print('index is : $index');
    dynamic _result = await Nav.goToNewScreen(context,
        FlyerEditorScreen(
          draftFlyerModel : widget.draftFlyerModel,
          index: index,
          firstTimer: widget.firstTimer,
          bzModel: widget.bzModel,
          flyerModel: null,
        )
    );

    minimizeKeyboardOnTapOutSide(context);
  }
// -----------------------------------------------------------------------------



  @override
  Widget build(BuildContext context) {

    double _overAllHeight = widget.stackHeight;
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

    int _flyerTitleMaxLength = Standards.flyerTitleMaxLength;

    double _deleteFlyerButtonSize = _stackTitleHeight * 0.4;
    double _flyerTitleZoneWidth = Scale.superScreenWidth(context) - _deleteFlyerButtonSize - (Ratioz.appBarMargin * 3);

    double _verticalMargin = Ratioz.appBarPadding;

    print('SLIDES STACK : num : ${widget.draftIndex + 1}');
    print('SLIDES STACK : Height : ${widget.stackHeight}');

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

                    /// TITLE OF THE TITLE TEXT FIELD
                    Container(
                      width: _flyerTitleZoneWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Ratioz.appBarPadding, left: Ratioz.appBarPadding, top: Ratioz.appBarMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            /// TITLE OF THE TITLE
                            SuperVerse(
                              verse: '${widget.draftIndex + 1}.',
                              size: 1,
                              italic: true,
                              color: Colorz.White80,
                              weight: VerseWeight.thin,
                            ),

                            /// TEXT FIELD COUNTER
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

                    /// TITLE TEXT FIELD
                    Form(
                      key: _formKey,
                      child: SuperTextField(
                        onTap: (){},

                        fieldIsFormField: true,
                        height: _stackTitleHeight,
                        width: _flyerTitleZoneWidth,
                        maxLines: 1,
                        inputSize: 2,
                        counterIsOn: false,
                        centered: false,
                        validator: (val){
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
                          }
                        },
                        // margin: EdgeInsets.only(top: Ratioz.appBarPadding),
                        hintText: 'Flyer Headline ...',
                        labelColor: Colorz.White10,
                        textController: widget.draftFlyerModel.titleController,
                        maxLength: _flyerTitleMaxLength,
                        onChanged: (value){
                          _formKey.currentState.validate();

                          setState(() {
                            _textLength = value.length;
                          });
                        },

                      ),
                    )

                  ],
                ),

                /// SPACER
                SizedBox(
                  width: Ratioz.appBarMargin,
                ),

                /// DELETE DRAFT FLYER BUTTON
                Container(
                  width: _deleteFlyerButtonSize,
                  height: _stackTitleHeight,
                  alignment: Alignment.topCenter,
                  child:
                  DreamBox(
                    height: _deleteFlyerButtonSize,
                    width: _deleteFlyerButtonSize,
                    icon: Iconz.XLarge,
                    iconSizeFactor: 0.7,
                    onTap: widget.onDeleteDraft,
                  ),


                ),

              ],
            ),
          ),

          /// SLIDES STACK
          Container(
            width: Scale.superScreenWidth(context),
            height: _stackZoneHeight,
            // color: Colorz.WhiteAir,
            alignment: Aligners.superCenterAlignment(context),
            child: ListView.builder(
              itemCount: widget.draftFlyerModel.assets.length + 1,
              scrollDirection: Axis.horizontal,
              itemExtent: _flyerZoneWidth,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              addAutomaticKeepAlives: true,
              itemBuilder: (ctx, index){

                List<Asset> _pictures = widget.draftFlyerModel.assets;

                bool _indexIsForAddButton = _pictures?.length == index ? true : false;

                Asset _asset = _indexIsForAddButton ? null : _pictures[index];

                if(_pictures != null && _pictures.length != 0 && _pictures.length != index){
                  String _picName = _asset?.name;
                print('SLIDES STACK : pic : ${_picName}');
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
                          index < _pictures.length ?
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
                            index < _pictures.length ?

                            /// IMAGE
                            GestureDetector(
                              onTap: () => _onPictureTap(index),
                              child: Container(
                                width: _flyerZoneWidth,
                                height: _flyerZoneHeight,
                                child: ClipRRect(
                                  borderRadius: _flyerBorderRadius,
                                  child:
                                  superImageWidget(_asset, width: _flyerZoneWidth.toInt(), height: _flyerZoneHeight.toInt()),
                                ),
                              ),
                            )

                                :

                            /// ADD IMAGE BUTTON
                            GestureDetector(
                              onTap: widget.onAddPics,
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
                                      onTap: widget.onAddPics,
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
