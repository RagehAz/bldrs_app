import 'dart:io';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:bldrs/xxx_lab/ask/question/question_ops.dart';
import 'package:flutter/material.dart';

class QuestionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QuestionBubble({
    @required this.tappingAskInfo,
    this.bzType,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzType bzType;
  final Function tappingAskInfo;
  /// --------------------------------------------------------------------------
  @override
  _QuestionBubbleState createState() => _QuestionBubbleState();
  /// --------------------------------------------------------------------------
}

class _QuestionBubbleState extends State<QuestionBubble> {
  TextEditingController _bodyController;
  TextEditingController _titleController;
  bool _askButtonInactive = true;
  List<File> _questionPics;
  List<KW> _keywords;
  BzType _questionDirectedTo;
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
//     blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
//   }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _bodyController = TextEditingController();
    _titleController = TextEditingController();
    _bodyController.addListener(textListener);

    _questionPics = <File>[];
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
  void textListener() {
    // blog('ask body text controller value is : ${_askBodyController.text}');

    final String _text = _bodyController.text;

    if (_text.length == 1 || _text.isEmpty) {
      bool _inactiveMode = false;
      if (_text.isNotEmpty) {
        _inactiveMode = false;
      } else {
        _inactiveMode = true;
      }

      setState(() {
        _askButtonInactive = _inactiveMode;
      });
    }
  }
  // ----------------------------------------------------------------------
  Future<void> _addPic() async {
    final File _imageFile =
        await Imagers.takeGalleryPicture(picType: Imagers.PicType.askPic);
    setState(() {
      _questionPics.add(File(_imageFile.path));
    });
  }
  // ----------------------------------------------------------------------
  void _deletePic(File pic) {
    // int _picFileIndex = _questionPics.indexWhere((p) => p == pic);
    setState(() {
      _questionPics.remove(pic);
    });
  }
  // ----------------------------------------------------------------------
  void submitQuestion() {
    // blog(_askBody);
    // _askBodyController.clear();
    // blog('Your Question is Submitted');
  }
// ---------------------------------------------------------------------------
  Future<void> _onAsk() async {
    if (TextChecker.textControllerIsEmpty(_bodyController) == true) {
      await NavDialog.showNavDialog(
          context: context,
          firstLine: 'Question is empty',
          secondLine: 'Please type your question first');
    }

    else if (TextChecker.textControllerIsEmpty(_titleController) == true) {
      await NavDialog.showNavDialog(
          context: context,
          firstLine: 'Title is empty',
          secondLine: 'Please type question title to proceed');
    }

    else {
      final QuestionModel _question = QuestionModel(
        questionID: 'mafeesh id',
        body: _bodyController.text,
        pics: _questionPics,
        time: DateTime.now(),
        keywords: _keywords,
        title: _titleController.text,
        ownerID: FireAuthOps.superUserID(),
        questionIsOpen: true,
        directedTo: _questionDirectedTo,
        totalChats: 0,
        totalViews: 0,
        userDeletedQuestion: false,
        userSeenAll: true,
        niceCount: 123,
        redirectCount: 5143,
        repliesCount: 54831,
      );

      await QuestionOps.createQuestionOps(
        context: context,
        question: _question,
        userID: FireAuthOps.superUserID(),
      );

      await NavDialog.showNavDialog(
          context: context,
          firstLine: 'Question submitted',
          secondLine: 'Question is submitted, and all bitched will see now');

      _titleController.clear();
      _bodyController.clear();
    }
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // final _questionsProvider = Provider.of<QuestionsProvider>(context);
    const UserStatus _userStatus = UserStatus.planning;
    const double _abPadding = Ratioz.appBarPadding;
    const double _abHeight = Ratioz.appBarSmallHeight;
    const double _abButtonsHeight = _abHeight - _abPadding;

    final String askHint = TextGen.askHinter(context, widget.bzType);

    // bool _askButtonInactive = _askBodyController.text.length == 0 ? true : false;
// ---------------------------------------------------------------------------

    const int numberOfColumns = 3;
    // int numberOfRows = 1;

    // int _gridColumnsCount = numberOfColumns;
    final double gridZoneWidth = Bubble.clearWidth(context);
    const List<Color> _boxesColors = <Color>[
      Colorz.white30,
      Colorz.white20,
      Colorz.white10
    ];
    const double _spacingRatioToGridWidth = 0.1;
    final double _gridBzWidth = gridZoneWidth /
        (numberOfColumns +
            (numberOfColumns * _spacingRatioToGridWidth) +
            _spacingRatioToGridWidth);
    // double _gridBzHeight = _gridBzWidth;
    final double _gridSpacing = _gridBzWidth * _spacingRatioToGridWidth;
    // int _picCount = _questionPics.length == 0 ? _boxesColors.length : _questionPics.length;
    // int _numOfGridRows(int _bzCount){return (_bzCount/_gridColumnsCount).ceil();}
    // int _numOfRows = numberOfRows == null ? _numOfGridRows(_picCount) : numberOfRows;
    // double _gridHeight = _gridBzHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    final SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate =
        SliverGridDelegateWithMaxCrossAxisExtent(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      maxCrossAxisExtent: _gridBzWidth, //gridFlyerWidth,
    );

    // double zoneCorners = (_gridBzWidth * Ratioz.bzLogoCorner) + _gridSpacing;

    return Bubble(
      centered: true,
      bubbleColor: Colorz.white10,
      columnChildren: <Widget>[

        /// USER LABEL
        SizedBox(
          height: _abButtonsHeight * 1.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// USER PICTURE
              UserBalloon(
                userModel: UserModel.dummyUserModel(context),
                balloonType: _userStatus,
                balloonWidth: _abButtonsHeight,
                loading: false,
                onTap: () {
                  blog('this person should ask a fucking question');
                },
              ),

              /// SPACER
              const SizedBox(
                width: Ratioz.appBarMargin,
                height: _abButtonsHeight,
              ),

              /// USER BUBBLE (WAS PREVIOUSLY A STREAM FOR NO GOOD REASON)
              // userStreamBuilder(
              //     context: context,
              //     listen: false,
              //     builder: (BuildContext context, UserModel userModel) {
              //       return
              //
              //           /// USER NAME AND TITLE
              //           Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           SuperVerse(
              //             verse: userModel.name,
              //             weight: VerseWeight.regular,
              //             margin: 0,
              //           ),
              //           SuperVerse(
              //             verse: userModel.company == null ||
              //                     userModel.company == ''
              //                 ? userModel.title
              //                 : '${userModel.title} @ ${userModel.company}',
              //             size: 1,
              //             weight: VerseWeight.thin,
              //           ),
              //         ],
              //       );
              //     }),

              /// EXPANDER SPACE
              const Expander(),

              /// INFO BUTTON
              DreamBox(
                height: _abButtonsHeight * 0.8,
                width: _abButtonsHeight * 0.8,
                icon: Iconz.info,
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
            textController: _titleController,
            hintText: 'Question title',
            centered: true,
            height: 60,
            inputSize: 3,
            keyboardTextInputAction: TextInputAction.next,
            maxLength: 100,
            counterIsOn: false,
            // validator: (){}, // TASK : question body must include question mark '?'
          ),
        ),

        /// ASK BODY TEXT FIELD
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
          child: SuperTextField(
            textController: _bodyController,
            hintText: askHint,
            keyboardTextInputType: TextInputType.multiline,
            maxLength: 1000,
            counterIsOn: false,
            // validator: (){}, // TASK : question body must include question mark '?'
          ),
        ),

        /// ASK PICS
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SuperVerse(
              verse: 'Attach images to your Question',
              color: Colorz.white10,
              weight: VerseWeight.thin,
              italic: true,
              margin: Ratioz.appBarPadding,
            ),
            Stack(
              children: <Widget>[
                /// GRID FOOTPRINTS
                if (_questionPics.isEmpty)
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(_gridSpacing),
                    gridDelegate: _gridDelegate,
                    children: _boxesColors
                        .map(
                          (Color color) => BzLogo(
                            width: _gridBzWidth,
                            image: color,
                            zeroCornerIsOn: false,
                            onTap: () {
                              Keyboarders.minimizeKeyboardOnTapOutSide(context);
                              _addPic();
                            },
                          ),
                        )
                        .toList(),
                  ),

                /// ASK PICS GRID
                if (_questionPics.isNotEmpty)
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(_gridSpacing),
                    // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                    gridDelegate: _gridDelegate,
                    children: _questionPics
                        .map(
                          (File pic) => BzLogo(
                              width: _gridBzWidth,
                              image: pic,
                              zeroCornerIsOn: false,
                              onTap: () {
                                // TASK : tap ask picture to go full screen
                                blog(
                                    'SHOULD GO FULL SCREEN AND BACK : ${pic.path}');
                                // for now it will delete image
                                _deletePic(pic);
                              }),
                        )
                        .toList(),
                  ),
              ],
            ),
          ],
        ),

        /// ASK BUTTON
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DreamBox(
              height: 40,
              // width: 40,
              margins: const EdgeInsets.only(top: 10),
              icon: Iconz.phoneGallery,
              verse: 'Add Image',
              iconSizeFactor: 0.6,
              onTap: () {
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
                margins: const EdgeInsets.only(top: 10),
                verse: Wordz.ask(context),
                verseColor: Colorz.black255,
                verseScaleFactor: 0.7,
                color: Colorz.yellow255,
                onTap: _onAsk,
              ),
            ),
          ],
        ),

      ],
    );
  }
}
