import 'dart:async';
import 'package:bldrs/a_models/secondary_models/feedback_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/real/ops/app_feedback_real_ops.dart';
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
  TextEditingController _feedbackController;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _uploadFeedBack() async {
    unawaited(_triggerLoading());

    /// upload text to firebase
    final FeedbackModel _uploadedModel = await FeedbackRealOps.createFeedback(
        context: context,
        feedback: FeedbackModel(
          userID: AuthFireOps.superUserID(),
          timeStamp: DateTime.now(),
          feedback: _feedbackController.text,
        ),
    );

    unawaited(_triggerLoading());

    if (_uploadedModel == null){
      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: '##Not Sent',
        bodyVerse: '##Sorry !, something went wrong',
      );
    }
    else {
      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: '##Thanks',
        bodyVerse: '##FeedBack sent',
      );
    }

    Nav.goBack(
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
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      pageTitleVerse: 'phid_feedback',
      skyType: SkyType.non,
      // loading: _loading,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          const SuperVerse(
            verse: '##Your opinion Matters !',
            margin: 10,
            color: Colorz.yellow255,
          ),

          Center(
            child: Container(
              width: Scale.superScreenWidth(context) * 0.7,
              margin: const EdgeInsets.only(bottom: 10),
              child: const SuperVerse(
                verse: '##Tell us what you think about Bldrs.net, or what upgrades you might think of',
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
            leadingIcon: _userModel?.pic,
            bubbleColor: Colorz.white20,
            titleVerse: '##Feedback',
            textController: _feedbackController,
            // loading: _loading,
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
            verse: '##Send',
            verseColor: Colorz.black230,
            color: Colorz.yellow255,
            verseScaleFactor: 0.6,
            onTap: _uploadFeedBack,
          ),

        ],
      ),
    );
  }
}
