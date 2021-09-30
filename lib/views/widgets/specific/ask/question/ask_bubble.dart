import 'dart:io';
import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/users/user_streamer.dart';
import 'package:bldrs/views/widgets/specific/ask/question/question_model.dart';
import 'package:bldrs/views/widgets/specific/ask/question/question_ops.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class QuestionBubble extends StatefulWidget {
  final BzType bzType;
  final Function tappingAskInfo;

  QuestionBubble({
    this.bzType,
    @required this.tappingAskInfo,
  });

  @override
  _QuestionBubbleState createState() => _QuestionBubbleState();
}

class _QuestionBubbleState extends State<QuestionBubble> {
  TextEditingController _bodyController;
  TextEditingController _titleController;
  bool _askButtonInactive = true;
  List<File> _questionPics;
  List<Keyword> _keywords;
  FlyerType _questionType;
// -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   bool _loading = false;
//   Future <void> _triggerLoading({Function function}) async {
//
//     if(mounted){
//
//       if (function == null){
//         setState(() {
//           _loading = !_loading;
//         });
//       }
//
//       else {
//         setState(() {
//           _loading = !_loading;
//           function();
//         });
//       }
//
//     }
//
//     _loading == true?
//     print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
//   }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _bodyController = new TextEditingController();
    _titleController = new TextEditingController();
    _bodyController.addListener(textListener);

    _questionPics = [];
  }
  // ----------------------------------------------------------------------
  @override
  void dispose() {
    // if (textControllerHasNoValue(_askBodyController))_askBodyController.dispose();
    // if (textControllerHasNoValue(_askTitleController))_askTitleController.dispose();
    _bodyController.dispose();
    _titleController.dispose();
    super.dispose();
  }
  // ----------------------------------------------------------------------
  void textListener(){
    // print('ask body text controller value is : ${_askBodyController.text}');
    String _text = _bodyController.text;
    if (_text.length == 1 || _text.length == 0){
      setState(() {
        _askButtonInactive = _text.length > 0 ? false : true;
      });
    }

  }
  // ----------------------------------------------------------------------
  Future<void> _addPic() async {
    final _imageFile = await Imagers.takeGalleryPicture(PicType.askPic);
    setState(() {_questionPics.add(File(_imageFile.path));});
  }
  // ----------------------------------------------------------------------
  void _deletePic(File pic) async {
    // int _picFileIndex = _questionPics.indexWhere((p) => p == pic);
    setState(() {
      _questionPics.remove(pic);
    });
  }
  // ----------------------------------------------------------------------
  void submitQuestion() {
    // print(_askBody);
    // _askBodyController.clear();
    // print('Your Question is Submitted');
  }
// ---------------------------------------------------------------------------
  Future<void> _onAsk() async {

      if (TextChecker.textControllerHasNoValue(_bodyController) == true){

        await NavDialog.showNavDialog(
          context: context,
          isBig: true,
          firstLine: 'Question is empty',
          secondLine: 'Please type your question first'
        );

      }

      else if (TextChecker.textControllerHasNoValue(_titleController) == true){

        await NavDialog.showNavDialog(
            context: context,
            isBig: true,
            firstLine: 'Title is empty',
            secondLine: 'Please type question title to proceed'
        );

      }

      else {

        QuestionModel _question = QuestionModel(
          questionID: 'mafeesh id',
          body: _bodyController.text,
          pics: _questionPics,
          time: DateTime.now(),
          keywords: _keywords,
          title: _titleController.text,
          ownerID: superUserID(),
          questionIsOpen: true,
          questionType: _questionType,
          totalChats: 0,
          totalViews: 0,
          userDeletedQuestion: false,
          userSeenAll: true,
        );

        await QuestionOps.createQuestionOps(
          context: context,
          question: _question,
        );

        await NavDialog.showNavDialog(
            context: context,
            isBig: true,
            firstLine: 'Question submitted',
            secondLine: 'Question is submitted, and all bitched will see now'
        );

        _titleController.clear();
        _bodyController.clear();

      }

  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // final _questionsProvider = Provider.of<QuestionsProvider>(context);
    UserStatus _userStatus = UserStatus.PlanningTalking;
    double _abPadding = Ratioz.appBarPadding;
    double _abHeight = Ratioz.appBarSmallHeight;
    double _abButtonsHeight = _abHeight - (_abPadding);

    String askHint = TextGenerator.askHinter(context, widget.bzType);

    // bool _askButtonInactive = _askBodyController.text.length == 0 ? true : false;
// ---------------------------------------------------------------------------

    int numberOfColumns = 3;
    // int numberOfRows = 1;

    // int _gridColumnsCount = numberOfColumns;
    double gridZoneWidth = Bubble.clearWidth(context);
    List<Color> _boxesColors = [Colorz.White30, Colorz.White20, Colorz.White10];
    double _spacingRatioToGridWidth = 0.1;
    double _gridBzWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    // double _gridBzHeight = _gridBzWidth;
    double _gridSpacing = _gridBzWidth * _spacingRatioToGridWidth;
    // int _picCount = _questionPics.length == 0 ? _boxesColors.length : _questionPics.length;
    // int _numOfGridRows(int _bzCount){return (_bzCount/_gridColumnsCount).ceil();}
    // int _numOfRows = numberOfRows == null ? _numOfGridRows(_picCount) : numberOfRows;
    // double _gridHeight = _gridBzHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1,
      maxCrossAxisExtent: _gridBzWidth,//gridFlyerWidth,
    );

    // double zoneCorners = (_gridBzWidth * Ratioz.bzLogoCorner) + _gridSpacing;

    return Bubble(
      centered: true,
      bubbleColor: Colorz.White10,
      columnChildren: <Widget>[

        /// USER LABEL
        Container(
          height: _abButtonsHeight * 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// USER PICTURE
              UserBalloon(
                // userPic: Iconz.DumAuthorPic,
                balloonType: _userStatus,
                balloonWidth: _abButtonsHeight,
                blackAndWhite: false,
                loading: false,
                onTap: () {
                  print('this person should ask a fucking question');
                },
              ),

              /// SPACER
              Container(
                width: Ratioz.appBarMargin,
                height: _abButtonsHeight,
              ),

              userStreamBuilder(
                context: context,
                listen: false,
                builder: (context, userModel){

                  return
                    /// USER NAME AND TITLE
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SuperVerse(
                          verse: userModel.name,
                          size: 2,
                          weight: VerseWeight.regular,
                          margin: 0,
                        ),
                        SuperVerse(
                          verse: userModel.company == null || userModel.company == '' ? userModel.title : '${userModel.title} @ ${userModel.company}',
                          size: 1,
                          weight: VerseWeight.thin,
                        ),
                      ],
                    );

                }
              ),


              /// EXPANDER SPACE
              const Expander(),

              /// INFO BUTTON
              DreamBox(
                height: _abButtonsHeight * 0.8,
                width: _abButtonsHeight * 0.8,
                icon: Iconz.Info,
                iconSizeFactor: 0.5,
                onTap: widget.tappingAskInfo,
              ),

            ],
          ),
        ),

        /// ASK TITLE TEXT FIELD
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
          child: SuperTextField(
            maxLines: 2,
            labelColor: Colorz.White10,
            textController: _titleController,
            inputColor: Colorz.White255,
            hintText: 'Question title',
            centered: true,
            height: 60,
            inputSize: 3,
            keyboardTextInputType: TextInputType.text,
            keyboardTextInputAction: TextInputAction.next,
            maxLength: 100,
            counterIsOn: false,
            fieldIsFormField: false,
            // validator: (){}, // TASK : question body must include question mark '?'
          ),
        ),

        /// ASK BODY TEXT FIELD
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
          child: SuperTextField(
            textController: _bodyController,
            inputColor: Colorz.White255,
            hintText: askHint,
            keyboardTextInputType: TextInputType.multiline,
            maxLength: 1000,
            maxLines: 7,
            counterIsOn: false,
            fieldIsFormField: false,
            // validator: (){}, // TASK : question body must include question mark '?'
          ),
        ),

        /// ASK PICS
        Container(
          // color: Colorz.BloodTest,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SuperVerse(
                verse: 'Attach images to your Question',
                color: Colorz.White10,
                weight: VerseWeight.thin,
                italic: true,
                margin: Ratioz.appBarPadding,
              ),

              Stack(
                children: <Widget>[

                  /// GRID FOOTPRINTS
                  if (_questionPics.length == 0)
                    GridView(
                      physics: NeverScrollableScrollPhysics() ,
                      scrollDirection: Axis.vertical,
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      // padding: EdgeInsets.all(_gridSpacing),
                      gridDelegate: _gridDelegate,
                      children: _boxesColors.map(
                            (color) => BzLogo(
                              width: _gridBzWidth,
                              image: color,
                              bzPageIsOn: false,
                              tinyMode: true,
                              zeroCornerIsOn: false,
                              onTap: (){
                                Keyboarders.minimizeKeyboardOnTapOutSide(context);
                                _addPic();
                                },
                            ),
                      ).toList(),
                    ),


                  /// ASK PICS GRID
                  if (_questionPics.length != 0)
                    GridView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      // padding: EdgeInsets.all(_gridSpacing),
                      // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                      gridDelegate: _gridDelegate,
                      children: _questionPics.map(
                            (pic) => BzLogo(
                            width: _gridBzWidth,
                            image: pic,
                            bzPageIsOn: false,
                            tinyMode: true,
                            zeroCornerIsOn: false,
                            onTap: (){
                              // TASK : tap ask picture to go full screen
                              print('SHOULD GO FULL SCREEN AND BACK : ${pic.path}');
                              // for now it will delete image
                              _deletePic(pic);
                            }
                        ),

                      ).toList(),

                    ),

                ],
              ),

            ],
          ),
        ),

        /// ASK BUTTON
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            DreamBox(
              height: 40,
              // width: 40,
              margins: EdgeInsets.only(top: 10),
              icon: Iconz.PhoneGallery,
              verse: 'Add Image',
              iconSizeFactor: 0.6,
              onTap: (){
                Keyboarders.minimizeKeyboardOnTapOutSide(context);
                _addPic();
              },

            ),

            Align(
              alignment: Aligners.superInverseCenterAlignment(context),
              child: DreamBox(
                inActiveMode: _askButtonInactive,
                width: 150,
                height: 40,
                margins: EdgeInsets.only(top: 10),
                verse: Wordz.ask(context),
                verseColor: Colorz.Black255,
                verseScaleFactor: 0.7,
                color: Colorz.Yellow255,
                verseWeight: VerseWeight.bold,
                onTap: _onAsk,
              ),
            ),


          ],
        ),

      ],
    );
  }
}




