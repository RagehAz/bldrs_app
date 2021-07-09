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
import 'package:bldrs/views/screens/x2_draft_picture_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker2/multi_image_picker2.dart';



class FlyerMakerStack extends StatefulWidget {
  final Function deleteFlyer;
  final int flyerNumber;

  FlyerMakerStack({
    @required this.deleteFlyer,
    @required this.flyerNumber,
    Key key
}) : super(key: key);


  @override
  _FlyerMakerStackState createState() => _FlyerMakerStackState();
}

class _FlyerMakerStackState extends State<FlyerMakerStack> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------

  List<Asset> _pictures = <Asset>[];
  TextEditingController _textController = TextEditingController();
  int _textLength = 0;
  Color _counterColor = Colorz.WhiteSmoke;
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
    // _textController.text = 'blah';
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    if (TextChecker.textControllerHasNoValue(_textController))_textController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future <void> _onPictureTap(int index) async {
    print('index is : $index');
    dynamic _result = await Nav.goToNewScreen(context,
        DraftPictureScreen(
          pictures : _pictures,
          index: index,
        )
    );

    minimizeKeyboardOnTapOutSide(context);
  }
// -----------------------------------------------------------------------------
  Future<void> _getMultiImages({BzAccountType accountType, int index}) async {

    /// if flyer reached max slides
    if(Standards.getMaxFlyersSlidesByAccountType(accountType) <= index ){
      await superDialog(
        context: context,
        title: 'Obbaaaa',
        body: 'Ta3alaaaaaaa ba2aaa ya 7abibi',
      );
    }

    /// if still picking images
    else {

      List<Asset> _galleryImages;

      if(mounted){
        _galleryImages = await getMultiImagesFromGallery(
          context: context,
          images: _pictures,
          mounted: mounted,
          accountType: accountType,
        );

        if(_galleryImages.length == 0){
          // will do nothing
        } else {
          setState(() {
            _pictures = _galleryImages;
          });
        }

      }

      if(_galleryImages.length == _pictures.length){
        print('lengths are the same, ${_galleryImages.toString()}');
      } else {
        print('lengths are not the same , ${_galleryImages.toString()}');
      }


    }

  }
// -----------------------------------------------------------------------------



  @override
  Widget build(BuildContext context) {

    const double _overAllHeight = 340;
    const double _stackTitleHeight = 85;
    const double _flyerNumberTagZoneHeight = 15;

    const double _stackZoneHeight = _overAllHeight - _stackTitleHeight;
    const double _flyerZoneHeight = _stackZoneHeight - _flyerNumberTagZoneHeight - (Ratioz.appBarPadding * 5);

    double _flyerSizeFactor = Scale.superFlyerSizeFactorByHeight(context, _flyerZoneHeight);
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    BorderRadius _flyerBorderRadius = Borderers.superFlyerCorners(context, _flyerZoneWidth);
    BoxDecoration _flyerDecoration = BoxDecoration(
      borderRadius: _flyerBorderRadius,
      color: Colorz.WhiteAir,
    );

    BzAccountType _accountType = BzAccountType.Premium;

    int _flyerTitleMaxLength = Standards.flyerTitleMaxLength;

    double _deleteFlyerButtonSize = _stackTitleHeight * 0.4;
    double _flyerTitleZoneWidth = Scale.superScreenWidth(context) - _deleteFlyerButtonSize - (Ratioz.appBarMargin * 3);

    return Container(
      width: Scale.superScreenWidth(context),
      height: _overAllHeight,
      color: Colorz.WhiteAir,
      margin: EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      child: Column(
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
                              verse: '${widget.flyerNumber}.',
                              size: 1,
                              italic: true,
                              color: Colorz.WhiteSmoke,
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

                            if(_counterColor != Colorz.BloodRed){
                              setState(() {
                                _counterColor = Colorz.BloodRed;
                              });
                            }

                            return 'Only $_flyerTitleMaxLength characters allowed for the flyer title';
                          } else {


                            if(_counterColor != Colorz.WhiteSmoke){
                              setState(() {
                                _counterColor = Colorz.WhiteSmoke;
                              });
                            }

                            return null;
                          }
                        },
                        // margin: EdgeInsets.only(top: Ratioz.appBarPadding),
                        hintText: 'Flyer Headline ...',
                        labelColor: Colorz.WhiteAir,
                        textController: _textController,
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
                    boxFunction: widget.deleteFlyer,
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
              itemCount: _pictures.length + 1,
              scrollDirection: Axis.horizontal,
              itemExtent: _flyerZoneWidth,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              addAutomaticKeepAlives: true,
              itemBuilder: (ctx, index){

                Function _addPics = () => _getMultiImages(accountType : _accountType, index: index);

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
                            color: Colorz.WhiteLingerie,
                            labelColor: Colorz.WhiteAir,
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

                            /// IMAGES
                            GestureDetector(
                              onTap: () => _onPictureTap(index),
                              child: Container(
                                width: _flyerZoneWidth,
                                height: _flyerZoneHeight,
                                child: ClipRRect(
                                  borderRadius: _flyerBorderRadius,
                                  child: superImageWidget(_pictures[index], width: _flyerZoneWidth.toInt(), height: _flyerZoneHeight.toInt()),
                                ),
                              ),
                            )

                                :

                            /// ADD IMAGE BUTTON

                            GestureDetector(
                              onTap: _addPics,
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

                                      iconColor: Colorz.WhiteGlass,
                                      bubble: false,
                                      boxFunction: _addPics,
                                    ),

                                    SizedBox(
                                      height: _flyerZoneWidth * 0.05,
                                    ),

                                    Container(
                                      width: _flyerZoneWidth * 0.95,
                                      child: SuperVerse(
                                        verse: 'Add Photos',
                                        size: 2,
                                        color: Colorz.WhiteGlass,
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
