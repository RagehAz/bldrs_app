import 'dart:io';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:bldrs/models/enums/enum_bz_form.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/header/header.dart';
import 'package:bldrs/views/widgets/flyer/header/mini_header/mini_header_items/mini_header_strip/mini_header_strip_items/bz_logo.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBzScreen2 extends StatefulWidget {
  @override
  _AddBzScreen2State createState() => _AddBzScreen2State();
}

class _AddBzScreen2State extends State<AddBzScreen2> {
  bool bzPageIsOn;
  BldrsSection chosenSection;
  BzType chosenBzType;
  List<bool> bzTypeInActivityList;
  BzForm chosenBzForm;
  List<bool> bzFormInActivityList;
  TextEditingController scopeTextController;
  TextEditingController bzNameTextController;
  File _storedLogo;
  File _pickedLogo;
  // ----------------------------------------------------------------------
  void initState(){
    super.initState();
    bzPageIsOn = false;
    createBzTypeInActivityList();
    createBzFormInActivityLst();
    scopeTextController = new TextEditingController();
    bzNameTextController = new TextEditingController();
  }
  // ----------------------------------------------------------------------
  void triggerMaxHeader(){
    setState(() {
      bzPageIsOn = !bzPageIsOn;
    });
  }
  // ----------------------------------------------------------------------
  void selectASection(int index){
    setState(() {
      chosenSection = bldrsSectionsList[index];
      bzTypeInActivityList =
          chosenSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
          chosenSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
          chosenSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
          bzTypeInActivityList;
    });
  }
  // ----------------------------------------------------------------------
  void selectBzType(int index){
      setState(() {
        chosenBzType = bzTypesList[index];
        bzFormInActivityList =
        chosenBzType == BzType.Developer ? [true, false] :
        chosenBzType == BzType.Broker ? [false, false] :
        chosenBzType == BzType.Designer ? [false, false] :
        chosenBzType == BzType.Contractor ? [false, false] :
        chosenBzType == BzType.Artisan ? [false, false] :
        chosenBzType == BzType.Manufacturer ? [true, false] :
        chosenBzType == BzType.Supplier ? [true, false] :
        bzFormInActivityList;
      });
  }
  // ----------------------------------------------------------------------
  void createBzTypeInActivityList(){
      setState(() {
        bzTypeInActivityList = List.filled(bzTypesList.length, true);
      });
  }
  // ----------------------------------------------------------------------
  void selectBzForm(int index){
      setState(() {
        chosenBzForm = bzFormsList[index];
      });
  }
  // ----------------------------------------------------------------------
  void createBzFormInActivityLst(){
      setState(() {
        bzFormInActivityList = List.filled(bzFormsList.length, true);
      });
  }
  // ----------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeCameraPicture');
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _storedLogo = File(imageFile.path);
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedLogo.copy('${appDir.path}/$fileName');
    // _selectImage(savedImage);
  }
  // ----------------------------------------------------------------------
  // void _selectImage(File pickedImage){
  //   _pickedLogo = pickedImage;
  // }
  // ----------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {
      _storedLogo = null;
    });
  }
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Stratosphere(),

            MultipleChoiceBubble(
                title: 'Sections :',
                buttonsList: sectionsListStrings(context),
                tappingAButton: selectASection,
                chosenButton: sectionStringer(context, chosenSection),
            ),

            // --- CHOOSE BzType
            MultipleChoiceBubble(
              title: 'Account type :',
              buttonsList: bzTypesStrings(context),
              tappingAButton: selectBzType,
              chosenButton: bzTypeSingleStringer(context, chosenBzType),
              buttonsInActivityList: bzTypeInActivityList,
            ),

            // --- CHOOSE BzForm
            MultipleChoiceBubble(
              title: 'Business form :',
              buttonsList: bzFormStrings(context),
              tappingAButton: selectBzForm,
              chosenButton: bzFormStringer(context, chosenBzForm),
              buttonsInActivityList: bzFormInActivityList,
            ),

            // --- type BzName
            TextFieldBubble(
              title: chosenBzForm == BzForm.Individual ? 'Business Entity name' : 'Company name',
              hintText: '...',
              counterIsOn: true,
              maxLength: 72,
              maxLines: 2,
              keyboardTextInputType: TextInputType.name,
              textController: bzNameTextController,
            ),

            // --- type BzFields
            TextFieldBubble(
              title: 'Scope of services :',
              hintText: '...',
              counterIsOn: true,
              maxLength: 193,
              maxLines: 4,
              keyboardTextInputType: TextInputType.multiline,
              textController: scopeTextController,
            ),

            AddLogoBubble(
              logo: _storedLogo,
              addBtFunction: _takeGalleryPicture,
              deleteLogoFunction: _deleteLogo,
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Stack(
                children: <Widget>[

                  FlyerZone(
                    flyerSizeFactor: 0.5,
                    tappingFlyerZone: (){print('fuck you');},
                    stackWidgets: <Widget>[

                      Header(
                          coBz: null,
                          coAuthor: null,
                          flyerShowsAuthor: true,
                          followIsOn: null,
                          flyerZoneWidth: superFlyerZoneWidth(context, 0.5),
                          bzPageIsOn: bzPageIsOn,
                          tappingHeader: triggerMaxHeader,
                          tappingFollow: null,
                          tappingUnfollow: null,
                      ),

                    ],
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class MultipleChoiceBubble extends StatelessWidget {
  final String title;
  final List<String> buttonsList;
  final Function tappingAButton;
  final String chosenButton;
  final List<bool> buttonsInActivityList;

  MultipleChoiceBubble({
    @required this.title,
    @required this.buttonsList,
    @required this.tappingAButton,
    @required this.chosenButton,
    this.buttonsInActivityList,
});

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
          ),

          Wrap(
              spacing: 0,
              runSpacing: 0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,

              children:
              List<Widget>.generate(
                  buttonsList.length,
                      (int index) {
                    return
                      DreamBox(
                        height: 40,
                        inActiveMode: buttonsInActivityList == null ? false : buttonsInActivityList[index],
                        verse: buttonsList[index],
                        verseItalic: false,
                        color: chosenButton == buttonsList[index] ? Colorz.Yellow : Colorz.WhiteAir,
                        verseColor: chosenButton == buttonsList[index] ? Colorz.BlackBlack : Colorz.White,
                        verseWeight: chosenButton == buttonsList[index] ? VerseWeight.black :  VerseWeight.bold,
                        verseScaleFactor: 0.6,
                        boxMargins: EdgeInsets.all(5),
                        boxFunction: () => tappingAButton(index),
                      );
                  }
              )


          ),


        ]
    );
  }
}

class TextFieldBubble extends StatelessWidget {
  final String title;
  final String hintText;
  final bool counterIsOn;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;
  final TextInputType keyboardTextInputType;

  TextFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.counterIsOn = false,
    this.maxLines = 5,
    this.maxLength = 100,
    this.textController,
    @required this.keyboardTextInputType,
  });
  @override
  Widget build(BuildContext context) {
    return
      InPyramidsBubble(
          bubbleColor: Colorz.WhiteAir,
          columnChildren: <Widget>[

            SuperVerse(
              verse: title,
              margin: 5,
            ),

            SuperTextField(
              hintText: hintText,
              counterIsOn: counterIsOn,
              keyboardTextInputType: keyboardTextInputType,
              maxLines: maxLines,
              maxLength: maxLength,
              textController: textController,
            )
          ]
      )
    ;
  }
}

class AddLogoBubble extends StatelessWidget {
  final Function addBtFunction;
  final File logo;
  final Function deleteLogoFunction;

  AddLogoBubble({
    @required this.addBtFunction,
    @required this.logo,
    @required this.deleteLogoFunction,
});
  @override
  Widget build(BuildContext context) {

    final double logoWidth = 100;
    final double btZoneWidth = logoWidth * 0.5;
    final double btWidth = btZoneWidth * 0.8;

    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        centered: true,
        columnChildren: <Widget>[

          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Container(
                    width: btZoneWidth,
                    height: logoWidth,
                  ),

                  Container(
                    width: logoWidth*1.1,
                    height: logoWidth,
                  ),

                  Container(
                    width: btZoneWidth,
                    height: logoWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        // --- GALLERY BUTTON
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.PhoneGallery,
                          iconSizeFactor: 0.6,
                          bubble: true,
                          boxFunction: addBtFunction,
                        ),

                        // --- DELETE LOGO
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.XLarge,
                          iconSizeFactor: 0.5,
                          bubble: true,
                          boxFunction: deleteLogoFunction,
                        ),

                      ],
                    ),
                  ),

                ],
              ),

              GestureDetector(
                onTap: logo == null ? (){} : addBtFunction,
                child: BzLogo(
                  width: logoWidth,
                  file: logo,
                  margins: EdgeInsets.all(10),
                ),
              ),

              logo == null ?
              DreamBox(
                height: logoWidth,
                width: logoWidth,
                icon: Iconz.Plus,
                iconSizeFactor: 0.4,
                bubble: false,
                opacity: 0.9,
                iconColor: Colorz.White,
                boxFunction: addBtFunction,
              ) : Container(),

            ],
          ),

          SuperVerse(
            verse: 'Business Logo' ,
            centered: true,
            margin: 5,
          ),

        ]
    );
  }
}
