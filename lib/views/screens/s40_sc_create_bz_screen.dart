import 'dart:io';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_logo_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateBzScreen extends StatefulWidget {
  @override
  _CreateBzScreenState createState() => _CreateBzScreenState();
}

class _CreateBzScreenState extends State<CreateBzScreen> {
  bool bzPageIsOn;
  BldrsSection _currentSection;
  List<bool> bzTypeInActivityList;
  List<bool> bzFormInActivityList;
  TextEditingController scopeTextController;
  TextEditingController bzNameTextController;
  TextEditingController aboutTextController;
  // -------------------------
  BzModel _currentBz;
  // -------------------------
  BzType _currentBzType;
  BzForm _currentBzForm;
  BzAccountType _currentAccountType;
  // -------------------------
  String _currentBzName;
  String _currentBzScope;
  File _currentLogo;
  String _currentScope;
  String _currentCountry;
  String _currentProvince;
  String _currentArea;
  String _currentBzAbout;
  GeoPoint _currentLocation;
  List<ContactModel> _currentContacts;
  AuthorModel _currentAuthor;
  bool _currentBzShowsTeam;
  // ----------------------------------------------------------------------
  void initState(){
    super.initState();
    bzPageIsOn = false;
    createBzTypeInActivityList();
    createBzFormInActivityLst();
    scopeTextController = new TextEditingController();
    bzNameTextController = new TextEditingController();
    _currentBz = new BzModel();
    _currentAuthor = new AuthorModel();
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
      _currentSection = bldrsSectionsList[index];
      bzTypeInActivityList =
          _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
          _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
          _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
          bzTypeInActivityList;
    });
  }
  // ----------------------------------------------------------------------
  void selectBzType(int index){
      setState(() {
        _currentBzType = bzTypesList[index];
        bzFormInActivityList =
        _currentBzType == BzType.Developer ? [true, false] :
        _currentBzType == BzType.Broker ? [false, false] :
        _currentBzType == BzType.Designer ? [false, false] :
        _currentBzType == BzType.Contractor ? [false, false] :
        _currentBzType == BzType.Artisan ? [false, false] :
        _currentBzType == BzType.Manufacturer ? [true, false] :
        _currentBzType == BzType.Supplier ? [true, false] :
        bzFormInActivityList;
        // _currentBz.bzType = _currentBzType;
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
        _currentBzForm = bzFormsList[index];
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
      _currentLogo = File(imageFile.path);
      // newBz.bz.bzLogo = _storedLogo;
    });

    // final appDir = await sysPaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage = await _currentLogo.copy('${appDir.path}/$fileName');
    // _selectImage(savedImage);
  }
  // ----------------------------------------------------------------------
  // void _selectImage(File pickedImage){
  //   _pickedLogo = pickedImage;
  // }
  // ----------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {
      _currentLogo = null;
    });
  }
  // ----------------------------------------------------------------------
void typingBzName(String bzName){
    setState(() {
      _currentBzName = bzName;
    });
}
  // ----------------------------------------------------------------------
  void typingBzScope(String bzScope){
    setState(() {
      _currentBzScope = bzScope;
    });
  }
  // ----------------------------------------------------------------------
  void typingBzAbout(String bzAbout){
    setState(() {
      _currentBzAbout = bzAbout;
    });
  }
  // ----------------------------------------------------------------------
  void _tapCountryButton(){
    print('_tapCountryButton');
  }
  // ----------------------------------------------------------------------
  void _tapProvinceButton(){
    print('_tapProvinceButton');
  }
  // ----------------------------------------------------------------------
  void _tapAreaButton(){
    print('_tapAreaButton');
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

//     print(
// '_currentBz : $_currentBz, '
// '_currentBzType : $_currentBzType, '
// '_currentBzForm : $_currentBzForm, '
// '_currentAccountType : $_currentAccountType, '
// '_currentBzName : $_currentBzName, '
// '_currentBzScope : $_currentBzScope, '
// '_currentLogo : $_currentLogo, '
// '_currentScope : $_currentScope, '
// '_currentCountry : $_currentCountry, '
// '_currentCity : $_currentCity, '
// '_currentBzAbout : $_currentBzAbout, '
// '_currentLocation : $_currentLocation, '
// '_currentContacts : $_currentContacts, '
// '_currentAuthor : $_currentAuthor, '
// '_currentBzShowsTeam : $_currentBzShowsTeam, '
//     );

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      pageTitle: Wordz.createAccount(context), // createBzAccount
      // tappingRageh: (){ print(_currentLogo.runtimeType);},
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
                  chosenButton: sectionStringer(context, _currentSection),
                ),

                // --- CHOOSE BzType
                MultipleChoiceBubble(
                  title: '${Wordz.accountType(context)} :',
                  buttonsList: bzTypesStrings(context),
                  tappingAButton: selectBzType,
                  chosenButton: bzTypeSingleStringer(context, _currentBzType),
                  buttonsInActivityList: bzTypeInActivityList,
                ),

                // --- CHOOSE BzForm
                MultipleChoiceBubble(
                  title: '${Wordz.businessForm(context)} :',
                  buttonsList: bzFormStrings(context),
                  tappingAButton: selectBzForm,
                  chosenButton: bzFormStringer(context, _currentBzForm),
                  buttonsInActivityList: bzFormInActivityList,
                ),

                BubblesSeparator(),

                // --- ADD LOGO
                AddLogoBubble(
                  logo: _currentLogo,
                  addBtFunction: _takeGalleryPicture,
                  deleteLogoFunction: _deleteLogo,
                ),

                // --- type BzName
                TextFieldBubble(
                  title: _currentBzForm == BzForm.Individual ? 'Business Entity name' : Wordz.companyName(context),
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
                  title: _currentBz.bzName == null  || _currentBz.bzName == '' ? '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' : '${Wordz.about(context)} ${_currentBz.bzName}',
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
                LocaleBubble(
                  title : Wordz.hqCity(context), // موقع المقر الرئيسي
                  country: _currentCountry,
                  province: _currentProvince,
                  area: _currentArea,
                  tapCountry: _tapCountryButton,
                  tapProvince: _tapProvinceButton,
                  tapArea: _tapAreaButton,
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
                            bz: _currentBz,
                            author: _currentAuthor,
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