import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/secondary_models/feedback_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {

  const FeedBack({
    Key key
  }) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController _feedbackController;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

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

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _feedbackController = new TextEditingController();
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
      collName: FireColl.feedbacks,
      addDocID: true,
      input: FeedbackModel(
        userID: superUserID(),
        timeStamp: DateTime.now(),
        feedback: _feedbackController.text,
      ).toMap(),
    );

    _triggerLoading();

    await CenterDialog.showCenterDialog(
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
      skyType: SkyType.Black,
      loading: _loading,
      layoutWidget: ListView(
        children: <Widget>[

          const Stratosphere(),

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
            verseColor: Colorz.black230,
            color: Colorz.yellow255,
            verseScaleFactor: 0.6,
            onTap: _uploadFeedBack,
          ),

          const PyramidsHorizon(),

        ],
      ),
    );
  }
}
