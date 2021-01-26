import 'dart:io';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_logo_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBzScreen extends StatefulWidget {
  @override
  _CreateBzScreenState createState() => _CreateBzScreenState();
}

class _CreateBzScreenState extends State<CreateBzScreen> {
  bool bzPageIsOn;
  BldrsSection chosenSection;
  BzType chosenBzType;
  List<bool> bzTypeInActivityList;
  BzForm chosenBzForm;
  String currentBzScope;
  String currentBzAbout;
  List<bool> bzFormInActivityList;
  TextEditingController scopeTextController;
  TextEditingController bzNameTextController;
  File _storedLogo;
  File _pickedLogo;
  BzModel newBz;
  AuthorModel newAuthor;
  BzModel newBzModel;
  TextEditingController aboutTextController;
  // ----------------------------------------------------------------------
  void initState(){
    super.initState();
    bzPageIsOn = false;
    createBzTypeInActivityList();
    createBzFormInActivityLst();
    scopeTextController = new TextEditingController();
    bzNameTextController = new TextEditingController();
    newBz = new BzModel();
    newAuthor = new AuthorModel(
          // userID: 'author${DateTime.now()}',
          // bzId: 'bz${DateTime.now()},',
        userID: 'user${DateTime.now()}',
    );
    newBzModel = new BzModel();
    // newBz.bz = newBzModel;
    // newBz.authors = [newAuthor];
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

        // newBz.bz.bzType = chosenBzType;
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
        // newBz.bz.bzForm = chosenBzForm;
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
      // newBz.bz.bzLogo = _storedLogo;
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
  // ----------------------------------------------------------------------
void typingBzName(String bzName){
    setState(() {
      bzNameTextController.text = bzName;
    });
}
  // ----------------------------------------------------------------------
  void typingBzScope(String bzScope){
    setState(() {
      currentBzScope = bzScope;
    });
  }
  // ----------------------------------------------------------------------
  void typingBzAbout(String bzAbout){
    setState(() {
      currentBzAbout = bzAbout;
    });
  }
  // ----------------------------------------------------------------------
void openCityList(){

}
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      pageTitle: Wordz.createAccount(context), // createBzAccount
      tappingRageh: (){ print(_storedLogo.runtimeType);},
      layoutWidget: Stack(
        children: <Widget>[

          SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Stratosphere(),

                MultipleChoiceBubble(
                  title: '${Wordz.sections(context)} :',
                  buttonsList: sectionsListStrings(context),
                  tappingAButton: selectASection,
                  chosenButton: sectionStringer(context, chosenSection),
                ),

                // --- CHOOSE BzType
                MultipleChoiceBubble(
                  title: '${Wordz.accountType(context)} :',
                  buttonsList: bzTypesStrings(context),
                  tappingAButton: selectBzType,
                  chosenButton: bzTypeSingleStringer(context, chosenBzType),
                  buttonsInActivityList: bzTypeInActivityList,
                ),

                // --- CHOOSE BzForm
                MultipleChoiceBubble(
                  title: '${Wordz.businessForm(context)} :',
                  buttonsList: bzFormStrings(context),
                  tappingAButton: selectBzForm,
                  chosenButton: bzFormStringer(context, chosenBzForm),
                  buttonsInActivityList: bzFormInActivityList,
                ),

                BubblesSeparator(),

                // --- ADD LOGO
                AddLogoBubble(
                  logo: _storedLogo,
                  addBtFunction: _takeGalleryPicture,
                  deleteLogoFunction: _deleteLogo,
                ),

                // --- type BzName
                TextFieldBubble(
                  title: chosenBzForm == BzForm.Individual ? 'Business Entity name' : Wordz.companyName(context),
                  hintText: '...',
                  counterIsOn: true,
                  maxLength: 72,
                  maxLines: 2,
                  keyboardTextInputType: TextInputType.name,
                  textController: bzNameTextController,
                  textOnChanged: (bzName) => typingBzName(bzName),
                ),

                // --- type BzScope
                TextFieldBubble(
                  title: '${Wordz.scopeOfServices(context)} :',
                  hintText: '...',
                  counterIsOn: true,
                  maxLength: 193,
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.multiline,
                  textController: scopeTextController,
                  textOnChanged: (bzScope) => typingBzScope(bzScope),
                ),

                // --- type BzAbout
                TextFieldBubble(
                  title: newBz.bzName == null  || newBz.bzName == '' ? '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' : '${Wordz.about(context)} ${newBz.bzName}',
                  hintText: '...',
                  counterIsOn: true,
                  maxLength: 193,
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.multiline,
                  textController: aboutTextController,
                  textOnChanged: (bzAbout) => typingBzAbout(bzAbout),
                ),

                BubblesSeparator(),

                // --- bzLocale
                InPyramidsBubble(
                    bubbleColor: Colorz.WhiteAir,
                    columnChildren: <Widget>[

                      SuperVerse(
                        verse: Wordz.hqCity(context),
                        margin: 5,
                      ),

                      DreamBox(
                        height: 40,
                        bubble: false,
                        verse: 'city, ${Wordz.country(context)}',
                        color: Colorz.WhiteAir,
                        boxFunction: openCityList,
                      )
                    ]
                ),

                BubblesSeparator(),

                // --- type BzAbout
                TextFieldBubble(
                  title: Wordz.authorName(context),
                  hintText: '...',
                  counterIsOn: true,
                  maxLength: 193,
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.multiline,
                  textController: aboutTextController,
                  textOnChanged: (bzAbout) => typingBzAbout(bzAbout),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Stack(
                    children: <Widget>[

                      FlyerZone(
                        flyerSizeFactor: 0.7,
                        tappingFlyerZone: (){print('fuck you');},
                        stackWidgets: <Widget>[

                          Header(
                            bz: newBz,
                            author: newAuthor,
                            flyerShowsAuthor: true,
                            followIsOn: null,
                            flyerZoneWidth: superFlyerZoneWidth(context, 0.7),
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

          Positioned(
            bottom: 0,
            left: 10,
            child: Builder(
              builder: (context) =>
              IconButton(
                iconSize: 30,
                icon: DreamBox(
                  height: 30,
                  verse: 'f  ',
                  verseScaleFactor: 0.6,
                ),
                onPressed: (){
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        width: screenWidth * 0.6,
                        backgroundColor: Colorz.BloodTest,
                        behavior: SnackBarBehavior.floating,

                        elevation: 0,
                        content: SuperVerse(
                          verse: 'wtf',
                          labelColor: Colorz.BloodTest,
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'koko',
                          onPressed: (){},
                        ),

                      ));
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}