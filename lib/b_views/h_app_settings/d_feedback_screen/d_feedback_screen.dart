import 'dart:async';
import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/feedback_protocols/real/app_feedback_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FeedBack({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FeedBackState createState() => _FeedBackState();
  /// --------------------------------------------------------------------------
}

class _FeedBackState extends State<FeedBack> {
  // -----------------------------------------------------------------------------
  TextEditingController _feedbackController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
  }
  // --------------------
  @override
  void dispose() {
    _feedbackController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _uploadFeedBack() async {

    unawaited(_triggerLoading(setTo: true));

    /// upload text to firebase
    final FeedbackModel _uploadedModel = await FeedbackRealOps.createFeedback(
      feedback: FeedbackModel(
        userID: AuthFireOps.superUserID(),
        timeStamp: DateTime.now(),
        feedback: _feedbackController.text,
      ),
    );

    unawaited(_triggerLoading(setTo: false));

    if (_uploadedModel == null){
      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          text: 'phid_not_sent',
          translate: true,
        ),
        bodyVerse: const Verse(
          text: 'phid_somethingIsWrong',
          translate: true,
        ),
      );
    }

    else {
      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          text: 'phid_thanks',
          translate: true,
        ),
        bodyVerse: const Verse(
          text: 'phid_feedback_has_been_sent',
          translate: true,
        ),
      );
    }

    await Nav.goBack(
      context: context,
      invoker: 'FeedbackScreen',
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return MainLayout(
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      appBarType: AppBarType.basic,
      historyButtonIsOn: false,
      pageTitleVerse: const Verse(
        text: 'phid_feedback',
        translate: true,
      ),
      skyType: SkyType.non,
      // loading: _loading,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          const SuperVerse(
            verse: Verse(
              text: 'phid_your_opinion_matters',
              translate: true,
              casing: Casing.upperCase,
            ),
            margin: 10,
            color: Colorz.yellow255,
          ),

          Center(
            child: Container(
              width: Scale.screenWidth(context) * 0.7,
              margin: const EdgeInsets.only(bottom: 10),
              child: const SuperVerse(
                verse: Verse(
                  pseudo: 'Tell us what you think about Bldrs.net, or what upgrades you might think of',
                  text: 'phid_feedback_description',
                  translate: true,
                ),
                margin: 5,
                maxLines: 3,
                size: 1,
                scaleFactor: 1.25,
                weight: VerseWeight.thin,
                italic: true,
                labelColor: Colorz.white20,
                color: Colorz.yellow255,
              ),
            ),
          ),

          TextFieldBubble(
            appBarType: AppBarType.basic,
            headerViewModel: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_feedback',
                translate: true,
              ),
              redDot: true,
            ),
            leadingIcon: _userModel?.picPath,
            bubbleColor: Colorz.white20,
            textController: _feedbackController,
            // loading: _loading,
            maxLines: 5,
            keyboardTextInputAction: TextInputAction.newline,
            keyboardTextInputType: TextInputType.multiline,
            maxLength: 1000,
            counterIsOn: true,
          ),

          DreamBox(
            height: 50,
            width: 200,
            verse: const Verse(
              text: 'phid_send',
              translate: true
            ),
            verseColor: Colorz.black230,
            color: Colorz.yellow255,
            verseScaleFactor: 0.6,
            onTap: _uploadFeedBack,
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
