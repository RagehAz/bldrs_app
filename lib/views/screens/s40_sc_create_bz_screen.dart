import 'dart:io';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/mappers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/bubbles/add_logo_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
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
    _snackController = AnimationController(duration: const Duration(seconds: 2), vsync: this, );
    _bzPageIsOn = false;
    create_BzTypeInActivityList();
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
  void create_BzTypeInActivityList(){
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
  void _tapCountryButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> flags}){
    print('_tapCountryButton');
    slideBottomSheet(
      context: context,
      draggable: true,
      height: null,
      child: ButtonsList(
          mapFirstValues: geebListOfFirstValuesFromMaps(flags),
          mapSecondValues: geebListOfSecondValuesFromMaps(flags),
          provider: countryPro,
          localizerPage: LocalizerPage.BottomSheet,
          buttonTap: (value){
            print('value issss : $value');
            setState(() {
              _currentCountry = value;
            });
            _closeBottomSheet();
          },
      ),
    );
  }

  void _closeBottomSheet(){
    Navigator.of(context).pop();
  }
  // ----------------------------------------------------------------------
  void _tapProvinceButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> provinces}){
    slideBottomSheet(
        context: context,
        draggable: true,
        height: null,
        child: ButtonsList(
        mapFirstValues: geebListOfFirstValuesFromMaps(provinces),
        mapSecondValues: geebListOfSecondValuesFromMaps(provinces),
        provider: countryPro,
        localizerPage: LocalizerPage.Province,
        buttonTap: (value){
          print('value issss : $value');
          setState(() {
            _currentProvince = value;
          });
          _closeBottomSheet();
          },
        ),
    );
  }
  // ----------------------------------------------------------------------
  void _tapAreaButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> areas}){
    slideBottomSheet(
      context: context,
      draggable: true,
      height: null,
      child: ButtonsList(
        mapFirstValues: geebListOfFirstValuesFromMaps(areas),
        mapSecondValues: geebListOfSecondValuesFromMaps(areas),
        provider: countryPro,
        localizerPage: LocalizerPage.Province,
        buttonTap: (value){
          print('value issss : $value');
          setState(() {
            _currentArea = value;
          });
          _closeBottomSheet();
        },
      ),
    );
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    List<Map<String,String>> _flags = _countryPro.getAvailableCountries();
    List<Map<String,String>> _provinces = _countryPro.getProvincesNames(context, _currentCountry);//_chosenCountry);
    List<Map<String,String>> _areas = _countryPro.getAreasNames(context, _currentProvince);//_chosenProvince);
    print(_provinces);
    print('current area issssssssssssssssss $_currentArea');
    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);
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
                  title : Wordz.hqCity(context), // موقع المقر الرئيسي
                  country: _currentCountry,
                  province: _currentProvince,
                  area: _currentArea,
                  tapCountry: () => _tapCountryButton(context: context, flags: _flags, countryPro: _countryPro ),
                  tapProvince: () => _tapProvinceButton(context: context, provinces: _provinces, countryPro: _countryPro ),
                  tapArea: ()=>_tapAreaButton(context: context, areas: _areas, countryPro: _countryPro),
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