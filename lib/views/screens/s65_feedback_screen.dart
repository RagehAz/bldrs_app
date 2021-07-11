import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/secondary_models/feedback_model.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController _feedbackController;
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
    _feedbackController = new TextEditingController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _uploadFeedBack() async {

    _triggerLoading();

    /// upload text to firebase
    await Fire.createDoc(
      context: context,
      collName: FireCollection.feedbacks,
      input: FeedbackModel(
        userID: superUserID(),
        timeStamp: DateTime.now(),
        feedback: _feedbackController.text,
      ).toMap(),
    );

    _triggerLoading();

    await superDialog(
      context: context,
      title: 'Thanks',
      body: 'FeedBack sent',
      boolDialog: false,
    );

    Nav.goBack(context);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      pageTitle: 'About Bldrs.net',
      sky: Sky.Black,
      loading: _loading,
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          SuperVerse(
            verse: 'Your opinion Matters !',
            margin: 10,
          ),

          Center(
            child: Container(
              width: Scale.superScreenWidth(context) * 0.7,
              margin: const EdgeInsets.only(bottom: 10),
              child: SuperVerse(
                verse: 'Tell us what you think about Bldrs.net, or what upgrades you might think of',
                margin: 5,
                maxLines: 3,
                size: 1,
                scaleFactor: 1.25,
                weight: VerseWeight.thin,
                italic: true,
              ),
            ),
          ),

          TextFieldBubble(
            title: 'Feedback',
            textController: _feedbackController,
            loading: _loading,
            maxLines: 5,
            fieldIsRequired: true,
            keyboardTextInputAction: TextInputAction.newline,
            keyboardTextInputType: TextInputType.multiline,
            maxLength: 1000,
            counterIsOn: true,
          ),

          DreamBox(
            height: 50,
            width: 200,
            verse: 'Send',
            verseColor: Colorz.Black225,
            color: Colorz.Yellow225,
            verseScaleFactor: 0.6,
            onTap: _uploadFeedBack,
          ),

          PyramidsHorizon(heightFactor: 10,),

        ],
      ),
    );
  }
}
