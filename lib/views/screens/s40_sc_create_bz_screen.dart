import 'dart:io';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/mappers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/bubbles/add_logo_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/buttons/bt_list.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/layouts/bottom_sheet.dart';
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
import 'package:provider/provider.dart';

class CreateBzScreen extends StatefulWidget {
  @override
  _CreateBzScreenState createState() => _CreateBzScreenState();
}

class _CreateBzScreenState extends State<CreateBzScreen> with TickerProviderStateMixin{
  bool _bzPageIsOn;
  BldrsSection _currentSection;
  List<bool> _bzTypeInActivityList;
  List<bool> _bzFormInActivityList;
  TextEditingController _scopeTextController;
  TextEditingController _bzNameTextController;
  TextEditingController _aboutTextController;
  AnimationController _snackController;
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
  String _currentCountryID;
  String _currentProvinceID;
  String _currentAreaID;
  String _currentBzAbout;
  GeoPoint _currentLocation;
  List<ContactModel> _currentContacts;
  AuthorModel _currentAuthor;
  bool _currentBzShowsTeam;
  // ----------------------------------------------------------------------
  void initState(){
    super.initState();
    _snackController = AnimationController(duration: const Duration(seconds: 2), vsync: this, );
    _bzPageIsOn = false;
    createBzTypeInActivityList();
    createBzFormInActivityLst();
    _scopeTextController = new TextEditingController();
    _bzNameTextController = new TextEditingController();
    _currentBz = new BzModel();
    _currentAuthor = new AuthorModel();
  }
  // ----------------------------------------------------------------------
  void triggerMaxHeader(){
    setState(() {
      _bzPageIsOn = !_bzPageIsOn;
    });
  }
  // ----------------------------------------------------------------------
  void selectASection(int index){
    setState(() {
      _currentSection = bldrsSectionsList[index];
      _bzTypeInActivityList =
          _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
          _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
          _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
          _bzTypeInActivityList;
    });
  }
  // ----------------------------------------------------------------------
  void selectBzType(int index){
      setState(() {
        _currentBzType = bzTypesList[index];
        _bzFormInActivityList =
        _currentBzType == BzType.Developer ? [true, false] :
        _currentBzType == BzType.Broker ? [false, false] :
        _currentBzType == BzType.Designer ? [false, false] :
        _currentBzType == BzType.Contractor ? [false, false] :
        _currentBzType == BzType.Artisan ? [false, false] :
        _currentBzType == BzType.Manufacturer ? [true, false] :
        _currentBzType == BzType.Supplier ? [true, false] :
        _bzFormInActivityList;
        // _currentBz.bzType = _currentBzType;
      });
  }
  // ----------------------------------------------------------------------
  void createBzTypeInActivityList(){
      setState(() {
        _bzTypeInActivityList = List.filled(bzTypesList.length, true);
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
        _bzFormInActivityList = List.filled(bzFormsList.length, true);
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
  void _closeBottomSheet(){
    Navigator.of(context).pop();
  }
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  void _changeCountry(String countryID){
    setState(() {
      _currentCountryID = countryID;
    });
  }
  // ----------------------------------------------------------------------
  void _changeProvince(String provinceID){
    setState(() {
      _currentProvinceID = provinceID;
    });
  }
  // ----------------------------------------------------------------------
  void _changeArea(String areaID){
          setState(() {
            _currentAreaID = areaID;
          });
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      pageTitle: Wordz.createAccount(context), // createBzAccount
      appBarRowWidgets: <Widget>[
        BldrsBackButton(
        onTap: (){},
        ),
      ],
      // tappingRageh: (){ print(_currentLogo.runtimeType);},
      layoutWidget: Stack(
        children: <Widget>[

          SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Stratosphere(),

                // --- CHOOSE SECTION
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
                  buttonsInActivityList: _bzTypeInActivityList,
                ),

                // --- CHOOSE BzForm
                MultipleChoiceBubble(
                  title: '${Wordz.businessForm(context)} :',
                  buttonsList: bzFormStrings(context),
                  tappingAButton: selectBzForm,
                  chosenButton: bzFormStringer(context, _currentBzForm),
                  buttonsInActivityList: _bzFormInActivityList,
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
                  textController: _bzNameTextController,
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
                  textController: _scopeTextController,
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
                  textController: _aboutTextController,
                  textOnChanged: (bzAbout) => typingBzAbout(bzAbout),
                ),

                BubblesSeparator(),

                // --- bzLocale
                LocaleBubble(
                  changeCountry : (countryID) => _changeCountry(countryID),
                  changeProvince : (provinceID) => _changeProvince(provinceID),
                  changeArea : (areaID) => _changeArea(areaID),
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
                  textController: _aboutTextController,
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
                            bzPageIsOn: _bzPageIsOn,
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
                iconSize: 50,
                onPressed: (){},
                icon: DreamBox(
                  height: 50,
                  width: 50,
                  verse: 'fuckkk  ',
                  verseScaleFactor: 0.6,
                  boxFunction: (){

                    print('snackjack');
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                        SnackBar(

                          // width: screenWidth,
                          backgroundColor: Colorz.BloodTest,
                          shape: RoundedRectangleBorder(borderRadius: superBorderRadius(context, 20, 0, 0, 20)),
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          content: SuperVerse(
                            verse: 'wtf',
                            labelColor: Colorz.BloodTest,
                          ),
                          duration: Duration(seconds: 2),
                          animation: CurvedAnimation(parent: _snackController, curve: Curves.easeIn,),
                          action: SnackBarAction(
                            label: 'koko',
                            onPressed: (){},
                          ),

                          margin: EdgeInsets.only(top: screenHeight*0.5),
                        ));
                  },
                ),


              ),
            ),
          ),

        ],
      ),
    );
  }
}