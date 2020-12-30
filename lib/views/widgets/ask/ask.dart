import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/providers/questions_provider.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/questions_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/user_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String bldrsTypePageTitle(BzType bzType) {
  return bzType == BzType.Developer
      ? 'Real-Estate Developers'
      : bzType == BzType.Broker
          ? 'Real-Estate Brokers'
          : bzType == BzType.Manufacturer
              ? 'Manufacturers'
              : bzType == BzType.Supplier
                  ? 'Suppliers & Distributors'
                  : bzType == BzType.Designer
                      ? 'Architects, Engineers, Designers & Decorators'
                      : bzType == BzType.Contractor
                          ? 'General & Speciality Contractors'
                          : bzType == BzType.Artisan
                              ? 'Artisans & Craftsmen'
                              : 'The Builders';
}

class Ask extends StatelessWidget {
  final BzType bzType;
  final Function tappingAskInfo;
  final TextEditingController _textController = TextEditingController();
  String questionBody = '';

  Ask({
    this.bzType,
    @required this.tappingAskInfo,
  });

  void submitQuestion() {
    print(questionBody);
    _textController.clear();
    print('Your Question is Submitted');
  }

  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context);
    UserType userType = UserType.PlanningUser;
    double abPadding = Ratioz.ddAppBarMargin * 0.5;
    double abHeight = Ratioz.ddAppBarHeight;
    double abButtonsHeight = abHeight - (abPadding);

    String askHint = bzType == BzType.Developer
        ? 'I\'m Looking for a property directly from the developer ...'
        : bzType == BzType.Broker
            ? 'I\'m Looking for a property from brokers and re-sellers ...'
            : bzType == BzType.Manufacturer
                ? 'I want to Manufacture or get big quantities ...'
                : bzType == BzType.Supplier
                    ? 'I\'m searching for a product ...'
                    : bzType == BzType.Designer
                        ? 'I need consultation from a designer ...'
                        : bzType == BzType.Contractor
                            ? 'I\'m Looking for a contractor to build a project ...'
                            : bzType == BzType.Artisan
                                ? 'I want a craftsman to fix or build something ...'
                                : 'Ask the Builders in your city';

    // String askIcon =
    // bzType == BzType.Developer ? Iconz.BxPropertiesOff :
    // bzType == BzType.Broker ? Iconz.BxPropertiesOff :
    // bzType == BzType.Manufacturer ? Iconz.BxProductsOff :
    // bzType == BzType.Supplier ? Iconz.BxProductsOff :
    // bzType == BzType.Designer ? Iconz.BxDesignsOff :
    // bzType == BzType.Contractor ? Iconz.BxProjectsOff :
    // bzType == BzType.Artisan ? Iconz.BxCraftsOff :
    // null;

    return InPyramidsBubble(
      centered: true,
      bubbleColor: Colorz.WhiteAir,
      columnChildren: <Widget>[
        // --- USER LABEL
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- USER PICTURE
            UserBubble(
              userPic: Iconz.DumAuthorPic,
              userType: userType,
              bubbleWidth: abButtonsHeight,
              blackAndWhite: false,
              onTap: () {
                print('this person should ask a fucking question');
              },
            ),

            // --- SPACER
            Container(
              width: Ratioz.ddAppBarMargin,
              height: abButtonsHeight,
            ),

            // --- USER NAME AND TITLE
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SuperVerse(
                  verse: 'Rageh El Azzazy',
                  size: 2,
                  weight: VerseWeight.regular,
                  margin: 0,
                ),
                SuperVerse(
                  verse: 'Founder & CEO & Bldrs.net',
                  size: 1,
                  weight: VerseWeight.thin,
                ),
              ],
            ),

            // --- EXPANDER SPACE
            Expanded(
              child: Container(),
            ),

            // --- INFO BUTTON
            DreamBox(
              height: abButtonsHeight * 0.8,
              width: abButtonsHeight * 0.8,
              icon: Iconz.Info,
              iconSizeFactor: 0.5,
              boxFunction: tappingAskInfo,
            )
          ],
        ),

        // --- QUESTION TEXT FIELD
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Ratioz.ddAppBarMargin),
          child: SuperTextField(
              textController: _textController,
              inputColor: Colorz.White,
              hintText: askHint,
              keyboardTextInputType: TextInputType.multiline,
              maxLength: 1000,
              counterIsOn: false,
              onChanged: (text) {
                this.questionBody = text;
                print(questionBody);
              }),
        ),

        // --- ASK BUTTON
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SuperVerse(
              verse: 'We need to add the functionality\nfor the asker to choose which\nBzType he is asking,\nand which hashtags',
              size: 0,
              color: Colorz.BloodRed,
              italic: true,
              maxLines: 7,
              centered: false,
              margin: 5,
            ),

            Align(
              alignment: superInverseCenterAlignment(context),
              child: DreamBox(

                width: 150,
                height: 40,
                boxMargins: EdgeInsets.only(bottom: 10),
                verse: 'Ask',
                verseColor: Colorz.BlackBlack,
                verseScaleFactor: 0.7,
                color: Colorz.Yellow,
                verseWeight: VerseWeight.bold,
                boxFunction: submitQuestion,
              ),
            )
          ],
        ),
      ],
    );
  }
}
