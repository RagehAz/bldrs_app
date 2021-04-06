// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bz_bottom_sheet.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzEditorScreen extends StatefulWidget {
  final bool firstTimer;
  final UserModel userModel;
  final BzModel bzModel;

  BzEditorScreen({
    this.firstTimer = false,
    @required this.userModel,
    this.bzModel,
});

  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
}

class _BzEditorScreenState extends State<BzEditorScreen> with TickerProviderStateMixin{
  FlyersProvider _prof;
  // -------------------------
  final _formKey = GlobalKey<FormState>();
  // -------------------------
  BzModel _bz;
  // -------------------------
  String _currentBzID;
  BzAccountType _currentAccountType;
  // -------------------------
  BldrsSection _currentSection;
  List<bool> _bzTypeInActivityList;
  BzType _currentBzType; // profession
  List<bool> _bzFormInActivityList;
  BzForm _currentBzForm;
  // -------------------------
  TextEditingController _bzNameTextController = TextEditingController();
  String _currentBzLogoURL;
  File _currentBzLogoFile;
  TextEditingController _bzScopeTextController = TextEditingController();
  String _currentBzCountry;
  String _currentBzProvince;
  String _currentBzArea;
  TextEditingController _bzAboutTextController = TextEditingController();
  GeoPoint _currentBzPosition;
  List<ContactModel> _currentBzContacts;
  List<AuthorModel> _currentBzAuthors;
  bool _currentBzShowsTeam;
  // -------------------------
  AuthorModel _currentAuthor;
  TextEditingController _authorNameTextController = TextEditingController();
  File _currentAuthorPicFile;
  String _currentAuthorPicURL;
  TextEditingController _authorTitleTextController = TextEditingController();
  List<ContactModel> _currentAuthorContacts;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------

  void initState(){
    // -------------------------
    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _bz = widget.firstTimer == true ? BzModel.createInitialBzModelFromUserData(widget.userModel) : widget.bzModel;
    // -------------------------
    _currentBzID = _bz.bzID;
    _currentAccountType = _bz.accountType;
    // -------------------------
    _currentBzType = _bz.bzType;
    _currentSection = getBldrsSectionByBzType(_currentBzType);
    _currentBzForm = _bz.bzForm;
    // -------------------------
    _createBzTypeInActivityList();
    _createBzFormInActivityLst();
    // -------------------------
    _bzNameTextController.text = _bz.bzName;
    _currentBzLogoURL = _bz.bzLogo;
    _bzScopeTextController.text = _bz.bzScope;
    _currentBzCountry = _bz.bzCountry;
    _currentBzProvince = _bz.bzProvince;
    _currentBzArea = _bz.bzArea;
    _bzAboutTextController.text =  _bz.bzAbout;
    _currentBzPosition = _bz.bzPosition;
    _currentBzContacts = _bz.bzContacts;
    _currentBzAuthors = _bz.bzAuthors;
    _currentBzShowsTeam = _currentBzShowsTeam;
    // -------------------------
    _currentAuthor = AuthorModel.getAuthorFromBzByAuthorID(_bz, widget.userModel.userID);
    _authorNameTextController.text = _currentAuthor.authorName;
    _currentAuthorPicURL = _currentAuthor.authorPic;
    _authorTitleTextController.text = _currentAuthor.authorTitle;
    _currentAuthorContacts = _currentAuthor.authorContacts;
    // -------------------------
    super.initState();
  }
  // ----------------------------------------------------------------------
  @override
  void dispose() {
    if (textControllerHasNoValue(_bzNameTextController))_bzNameTextController.dispose();
    if (textControllerHasNoValue(_bzScopeTextController))_bzScopeTextController.dispose();
    if (textControllerHasNoValue(_bzAboutTextController))_bzAboutTextController.dispose();
    if (textControllerHasNoValue(_authorNameTextController))_authorNameTextController.dispose();
    if (textControllerHasNoValue(_authorTitleTextController))_authorTitleTextController.dispose();
    super.dispose();
  }
  // ----------------------------------------------------------------------
  void _showBzCard (){
    setState(() {});

    slideBzBottomSheet(
      context: context,
      bz: BzModel(
        bzID: '',
        bzType: _currentBzType,
        bzForm: _currentBzForm,
        bldrBirth: DateTime.now(),
        accountType: _currentAccountType,
        bzURL: '',
        bzName: _bzNameTextController.text,
        bzLogo: _currentBzLogoFile ?? _currentBzLogoURL,
        bzScope: _bzScopeTextController.text,
        bzCountry: _currentBzCountry,
        bzProvince: _currentBzProvince,
        bzArea: _currentBzArea,
        bzAbout: _bzAboutTextController.text,
        bzPosition: _currentBzPosition,
        bzContacts: _currentBzContacts,
        bzAuthors: _currentBzAuthors,
        bzShowsTeam: _currentBzShowsTeam,
        bzIsVerified: _bz.bzIsVerified,
        bzAccountIsDeactivated: _bz.bzAccountIsDeactivated,
        bzAccountIsBanned: _bz.bzAccountIsBanned,
        bzTotalFollowers: _bz.bzTotalFollowers,
        bzTotalSaves: _bz.bzTotalSaves,
        bzTotalShares: _bz.bzTotalShares,
        bzTotalSlides: _bz.bzTotalSlides,
        bzTotalViews: _bz.bzTotalViews,
        bzTotalCalls: _bz.bzTotalCalls,
        bzFlyers: _bz.bzFlyers,

      ),
      author: AuthorModel(
        userID: '',
        // bzID: '',
        authorName: _authorNameTextController.text,
        authorTitle: _authorTitleTextController.text,
        authorPic: _currentAuthorPicFile ?? _currentAuthorPicURL,
        authorContacts: _currentAuthorContacts,
        authorIsMaster: _currentAuthor.authorIsMaster,
      ),
    );

  }
  // ----------------------------------------------------------------------
  void _selectASection(int index){
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
  void _selectBzType(int index){
      setState(() {
        _currentBzType = BzModel.bzTypesList[index];
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
  void _createBzTypeInActivityList(){
    if(widget.firstTimer){
      setState(() {
        _bzTypeInActivityList = List.filled(BzModel.bzTypesList.length, true);
      });
    } else {
      _bzTypeInActivityList =
      _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
      _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
      _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
      _bzTypeInActivityList;
    }
  }
  // ----------------------------------------------------------------------
  void _createBzFormInActivityLst(){
    if (widget.firstTimer){
      setState(() {
        _bzFormInActivityList = List.filled(BzModel.bzFormsList.length, true);
      });
    } else {
      _bzFormInActivityList =
      _currentBzType == BzType.Developer ? [true, false] :
      _currentBzType == BzType.Broker ? [false, false] :
      _currentBzType == BzType.Designer ? [false, false] :
      _currentBzType == BzType.Contractor ? [false, false] :
      _currentBzType == BzType.Artisan ? [false, false] :
      _currentBzType == BzType.Manufacturer ? [true, false] :
      _currentBzType == BzType.Supplier ? [true, false] :
      _bzFormInActivityList;
    }
  }
  // ----------------------------------------------------------------------
  Future<void> _takeBzLogo() async {
    final _imageFile = await takeGalleryPicture(PicType.bzLogo);
    setState(() {_currentBzLogoFile = File(_imageFile.path);});
  }
  // ----------------------------------------------------------------------
  Future<void> _takeAuthorPicture() async {
    final _imageFile = await takeGalleryPicture(PicType.authorPic);
    setState(() {_currentAuthorPicFile = File(_imageFile.path);});
  }
  // ----------------------------------------------------------------------
  // Future<BzModel> _createBzModel(UserModel user) async {
  //   // -------------------------------------
  //   /// TASK : SHOULD USE bzID as logoFile name in fire storage
  //   /// so this process should come after creating the bzDocument
  //   String _bzLogoURL;
  //   if (_currentBzLogoFile != null){
  //     _bzLogoURL = await savePicOnFirebaseStorageAndGetURL(
  //         context: context,
  //         inputFile: _currentBzLogoFile,
  //         fileName: user.userID,
  //         picType: PicType.bzLogo
  //     );
  //   }
  //   // -------------------------------------
  //   String _authorPicURL;
  //   if(_currentAuthorPicFile != null){
  //     _authorPicURL = await savePicOnFirebaseStorageAndGetURL(
  //         context: context,
  //         inputFile: _currentAuthorPicFile,
  //         fileName: user.userID,
  //         picType: PicType.authorPic
  //     );
  //   }
  //   // -------------------------------------
  //   AuthorModel _modifiedAuthor = AuthorModel(
  //       userID: user.userID,
  //       authorName: _authorNameTextController.text,
  //       authorPic: _authorPicURL ?? _currentAuthorPicURL,
  //       authorTitle: _authorTitleTextController.text,
  //       authorIsMaster: _currentAuthor.authorIsMaster,
  //       authorContacts: _currentAuthorContacts,
  //   );
  //   // -------------------------------------
  //   List<AuthorModel> _firstTimeAuthorsList = <AuthorModel>[_modifiedAuthor,];
  //   // -------------------------------------
  //   List<AuthorModel> _modifiedAuthorsList;
  //   if (widget.firstTimer == false){
  //     _modifiedAuthorsList = new List();
  //     List<AuthorModel> _originalAuthors = _currentBzAuthors;
  //     int _indexOfCurrentAuthor = _originalAuthors.indexWhere((au) => _currentAuthor.userID == au.userID);
  //     _originalAuthors.removeAt(_indexOfCurrentAuthor);
  //     _originalAuthors.insert(_indexOfCurrentAuthor, _modifiedAuthor);
  //     _modifiedAuthorsList = _originalAuthors;
  //   }
  //   // -------------------------------------
  //   return new BzModel(
  //     bzID: widget.firstTimer? _currentBzID : widget.bzModel.bzID,
  //     // -------------------------
  //     bzType: _currentBzType,
  //     bzForm: _currentBzForm,
  //     bldrBirth:  widget.firstTimer? DateTime.now() : widget.bzModel.bldrBirth,
  //     accountType: widget.firstTimer? BzAccountType.Default : _currentAccountType,
  //     bzURL: widget.firstTimer ? '...' : widget.bzModel.bzURL,
  //     // -------------------------
  //     bzName: _bzNameTextController.text ?? user.company,
  //     bzLogo: _bzLogoURL ??  _currentBzLogoURL,
  //     bzScope: _bzScopeTextController.text,
  //     bzCountry: _currentBzCountry ?? user.country, // i guess mloosh lazma ?? user.country as _currentBzCountry is already defined in initstate
  //     bzProvince: _currentBzProvince ?? user.province, // i guess mloosh lazma ?? user.province
  //     bzArea: _currentBzArea ?? user.area,  // i guess mloosh lazma ?? user.area
  //     bzAbout: _bzAboutTextController.text,
  //     bzPosition: _currentBzPosition,
  //     bzContacts: _currentBzContacts ?? user.contacts,
  //     bzAuthors: widget.firstTimer ? _firstTimeAuthorsList : _modifiedAuthorsList,
  //     bzShowsTeam: _currentBzShowsTeam,
  //     // -------------------------
  //     bzIsVerified: widget.firstTimer ? false : widget.bzModel.bzIsVerified,
  //     bzAccountIsDeactivated: widget.firstTimer ? false : widget.bzModel.bzAccountIsDeactivated,
  //     bzAccountIsBanned: widget.firstTimer ? false : widget.bzModel.bzAccountIsBanned,
  //     // -------------------------
  //     bzTotalFollowers: widget.firstTimer ? 0 : widget.bzModel.bzTotalFollowers,
  //     bzTotalSaves: widget.firstTimer ? 0 : widget.bzModel.bzTotalSaves,
  //     bzTotalShares: widget.firstTimer ? 0 : widget.bzModel.bzTotalShares,
  //     bzTotalSlides: widget.firstTimer ? 0 : widget.bzModel.bzTotalSlides,
  //     bzTotalViews: widget.firstTimer ? 0 : widget.bzModel.bzTotalViews,
  //     bzTotalCalls: widget.firstTimer ? 0 : widget.bzModel.bzTotalCalls,
  //     // -------------------------
  //     bzFlyers: widget.firstTimer ? [] : widget.bzModel.bzFlyers,
  //   );
  // }
  // ----------------------------------------------------------------------
  // Future <void> _confirmBz(BuildContext context, FlyersProvider pro, UserModel userModel) async {
  //   /// any change hs happened to allow this function in first place, otherwise, confirm button must be inactive
  //   /// then we need to validate
  //   /// all required fields are not null
  //   /// and validate the correct user input syntax in fields like phone e-mail & social media links
  //   // final bool isValid = _form.currentState.validate();
  //   // if(!isValid){return;}
  //   // _form.currentState.save();
  //
  //   _triggerLoading();
  //
  //   BzModel _bzModelWithoutID = await _createBzModel(userModel);
  //
  //   if(widget.firstTimer){
  //     BzModel _bzModel = await BzCRUD().createBzOps(context, _bzModelWithoutID, userModel);
  //     superDialog(context, 'Successfully added new Business Account', 'Great !');
  //   } else {
  //
  //   }
  //
  //   await tryAndCatch(
  //     context: context,
  //     functions: () async {
  //       // await pro.addBz(context, _bzModel, userModel);
  //
  //       if (widget.firstTimer){
  //       await _prof.createBzDocument(_bzModel, userModel);
  //
  //       superDialog(context, 'Successfully added new Business Account', 'Great !');
  //
  //       } else {
  //         await pro.updateFirestoreBz(_bzModel);
  //
  //         await superDialog(context, 'Successfully Edited your Business Account', 'Great !');
  //         goBack(context, argument: 'ok');
  //       }
  //     },
  //   );
  //
  //   _triggerLoading();
  //
  // }
  // ----------------------------------------------------------------------
  // Future<void> _deleteBzProfile(BuildContext context, FlyersProvider pro, UserModel userModel) async {
  //   _triggerLoading();
  //   try { await pro.deleteBz(_bzID, userModel); }
  //   catch(error) {
  //     await showDialog(
  //       context: context,
  //       builder: (ctx)=>
  //           AlertDialog(
  //             title: SuperVerse(verse: 'error man', color: Colorz.BlackBlack,),
  //             content: SuperVerse(verse: 'error is : ${error.toString()}', color: Colorz.BlackBlack, maxLines: 10,),
  //             backgroundColor: Colorz.Grey,
  //             elevation: 10,
  //             shape: RoundedRectangleBorder(borderRadius: superBorderAll(context, 20)),
  //             contentPadding: EdgeInsets.all(10),
  //             actionsOverflowButtonSpacing: 10,
  //             actionsPadding: EdgeInsets.all(5),
  //             insetPadding: EdgeInsets.symmetric(vertical: (superScreenHeight(context)*0.32), horizontal: 35),
  //             buttonPadding:  EdgeInsets.all(5),
  //             titlePadding:  EdgeInsets.all(20),
  //             actions: <Widget>[BldrsBackButton(onTap: ()=> goBack(ctx)),],
  //
  //           ),
  //     );
  //   }
  //   finally {
  //     _triggerLoading();
  //     goToNewScreen(context, UserProfileScreen());
  //   }
  //
  // }
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  /// TASK : create bzEditors validators for bubbles instead of this basic null checker
  /// TASK : need to validate inputs creating new bz
  bool _inputsAreValid(){
    // final bool isValid = _form.currentState.validate();
    // if(!isValid){return;}
    // _form.currentState.save();

    minimizeKeyboardOnTapOutSide(context);

    bool _inputsAreValid;
    if (
    _currentBzType == null ||
        _currentBzForm == null ||
        _bzNameTextController.text == null ||
        _bzNameTextController.text.length < 3 ||
        _currentBzLogoFile == null ||
        _bzScopeTextController.text == null ||
        _bzScopeTextController.text.length < 3 ||
        _currentBzCountry == null ||
        _currentBzProvince == null ||
        _currentBzArea == null ||
        _bzAboutTextController.text == null ||
        _bzAboutTextController.text.length < 6
        // _currentBzContacts.length == 0 ||
        // _currentBzShowsTeam == null
    ) {
      _inputsAreValid = false;
    } else {
      _inputsAreValid = true;
    }

    /// TASK : temp bzEditor validator = true
    return true;
    }
  // ----------------------------------------------------------------------
  /// create new bzModel with current data and start createBzOps
  Future<void> _createNewBz() async {
    /// assert that all required fields are added and valid
    if (_inputsAreValid() == false) {
      /// TASK : add error missing data indicator in UI bubbles
      await superDialog(context, 'Please add all required fields', 'incomplete');

    } else {

      _triggerLoading();

      /// create new master AuthorModel
      AuthorModel _firstMasterAuthor = AuthorModel(
        userID: widget.userModel.userID,
        authorName: _authorNameTextController.text,
        authorPic: _currentAuthorPicFile, // if null createBzOps uses user.pic URL instead
        authorTitle: _authorTitleTextController.text,
        authorIsMaster: true,
        authorContacts: _currentAuthorContacts,
      );
      List<AuthorModel> _firstTimeAuthorsList = <AuthorModel>[_firstMasterAuthor,];

      /// create new first time bzModel
      BzModel _newBzModel = BzModel(
        bzID: null, // will be generated in createBzOps
        // -------------------------
        bzType: _currentBzType,
        bzForm: _currentBzForm,
        bldrBirth: null, // timestamp will be generated inside createBzOps
        accountType: BzAccountType.Default, // changing this is not in bzEditor
        bzURL: null, // will be generated inside createBzOps
        // -------------------------
        bzName: _bzNameTextController.text,
        bzLogo: _currentBzLogoFile,
        bzScope: _bzScopeTextController.text,
        bzCountry: _currentBzCountry,
        bzProvince: _currentBzProvince,
        bzArea: _currentBzArea,
        bzAbout: _bzAboutTextController.text,
        bzPosition: _currentBzPosition,
        bzContacts: _currentBzContacts,
        bzAuthors: _firstTimeAuthorsList,
        bzShowsTeam: _currentBzShowsTeam,
        // -------------------------
        bzIsVerified: false,
        bzAccountIsDeactivated: false,
        bzAccountIsBanned: false,
        // -------------------------
        bzTotalFollowers: 0,
        bzTotalSaves: 0,
        bzTotalShares: 0,
        bzTotalSlides: 0,
        bzTotalViews: 0,
        bzTotalCalls: 0,
        // -------------------------
        bzFlyers: [],
      );

      /// start createBzOps
      BzModel _bzModel = await BzCRUD().createBzOps(
          context: context,
          inputBz : _newBzModel,
          userModel: widget.userModel
      );

      /// add the final _bzModel to local list and notifyListeners
      _prof.addBzModelToLocalList(_bzModel);

      _triggerLoading();

      await superDialog(context, 'Successfully added your Business Account ', 'Great !');

      goBack(context);

    }

  }
  // ----------------------------------------------------------------------
  /// create updated bzModel with changed data and start updateBzOps
  Future<void> _updateExistingBz() async {

    if (_inputsAreValid() == false) {
      await superDialog(context, 'Please add all required fields', 'incomplete');
    } else {

      _triggerLoading();

      /// create modified authorModel
      AuthorModel _modifiedAuthor = AuthorModel(
        userID: widget.userModel.userID,
        authorName: _authorNameTextController.text,
        authorPic: _currentAuthorPicFile ?? _currentAuthorPicURL,
        authorTitle: _authorTitleTextController.text,
        authorIsMaster: _currentAuthor.authorIsMaster,
        authorContacts: _currentAuthorContacts,
      );
      List<AuthorModel> _modifiedAuthorsList = AuthorModel.replaceAuthorModelInAuthorsList(_currentBzAuthors, _modifiedAuthor);

      /// create modified bzModel
      BzModel _modifiedBzModel = BzModel(
        bzID: widget.bzModel.bzID,
        // -------------------------
        bzType: _currentBzType,
        bzForm: _currentBzForm,
        bldrBirth: widget.bzModel.bldrBirth,
        accountType: _currentAccountType,
        bzURL: widget.bzModel.bzURL,
        // -------------------------
        bzName: _bzNameTextController.text,
        bzLogo: _currentBzLogoFile ?? _currentBzLogoURL,
        bzScope: _bzScopeTextController.text,
        bzCountry: _currentBzCountry,
        bzProvince: _currentBzProvince,
        bzArea: _currentBzArea,
        bzAbout: _bzAboutTextController.text,
        bzPosition: _currentBzPosition,
        bzContacts: _currentBzContacts,
        bzAuthors: _modifiedAuthorsList,
        bzShowsTeam: _currentBzShowsTeam,
        // -------------------------
        bzIsVerified: widget.bzModel.bzIsVerified,
        bzAccountIsDeactivated: widget.bzModel.bzAccountIsDeactivated,
        bzAccountIsBanned: widget.bzModel.bzAccountIsBanned,
        // -------------------------
        bzTotalFollowers: widget.bzModel.bzTotalFollowers,
        bzTotalSaves: widget.bzModel.bzTotalSaves,
        bzTotalShares: widget.bzModel.bzTotalShares,
        bzTotalSlides: widget.bzModel.bzTotalSlides,
        bzTotalViews: widget.bzModel.bzTotalViews,
        bzTotalCalls: widget.bzModel.bzTotalCalls,
        // -------------------------
        bzFlyers: widget.bzModel.bzFlyers,
      );

      /// start updateBzOps
      BzModel _finalBzModel = await BzCRUD().updateBzOps(
        context: context,
        modifiedBz: _modifiedBzModel,
        originalBz: _bz,
        bzLogoFile: _currentBzLogoFile,
        authorPicFile: _currentAuthorPicFile,
      );

      /// update _TinyBzModel in local list with the modified one and notifyListeners
      TinyBz _tinyBz = TinyBz.getTinyBzFromBzModel(_finalBzModel);
      _prof.updateTinyBzModelInLocalList(_tinyBz);

      _triggerLoading();

      await superDialog(context, 'Successfully updated your Business Account ', 'Great !');

      goBack(context);

    }

    }
  // ----------------------------------------------------------------------
  Future<void> _confirmButton() async {
    // TASK : create bool dialog and use it here before confirming bz edits in bzEditor
    // temp solution here below to just notify
      bool _continueOps = await superDialog(context, 'Are you sure you want to continue ?', '');
      _continueOps = true;
      if (_continueOps == true){
        widget.firstTimer ? _createNewBz() : _updateExistingBz();
      }

  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Widget _separator = BubblesSeparator();

    String _bzAboutBubbleTitle =
    Wordz.about(context);
    // _bzNameTextController.text == null || _bzNameTextController.text == '' ?
    // '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' :
    // '${Wordz.about(context)} ${_bzNameTextController.text}';

    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      pageTitle: widget.firstTimer == true ? Wordz.createBzAccount(context) : 'Edit Business account info', // createBzAccount
      appBarBackButton: true,
      layoutWidget: Stack(
        children: <Widget>[

          //--- BUBBLES
          ListView(
            children: <Widget>[

              Stratosphere(),

              // --- CHOOSE SECTION
              MultipleChoiceBubble(
                title: Wordz.sections(context),
                buttonsList: TextGenerator.sectionsListStrings(context),
                tappingAButton: _selectASection,
                chosenButton: TextGenerator.sectionStringer(context, _currentSection),
              ),

              // --- CHOOSE BzType
              MultipleChoiceBubble(
                title: 'Profession',
                buttonsList: TextGenerator.bzTypesStrings(context),
                tappingAButton: _selectBzType,
                chosenButton: TextGenerator.bzTypeSingleStringer(context, _currentBzType),
                buttonsInActivityList: _bzTypeInActivityList,
              ),

              // --- CHOOSE BzForm
              MultipleChoiceBubble(
                title: Wordz.businessForm(context),
                buttonsList: TextGenerator.bzFormStrings(context),
                tappingAButton: (index) => setState(() {_currentBzForm = BzModel.bzFormsList[index];}),
                chosenButton: TextGenerator.bzFormStringer(context, _currentBzForm),
                buttonsInActivityList: _bzFormInActivityList,
              ),

              _separator,

              // --- ADD LOGO
              AddGalleryPicBubble(
                pic: _currentBzLogoFile == null ? _currentBzLogoURL : _currentBzLogoFile,
                addBtFunction: _takeBzLogo,
                deletePicFunction: () => setState(() {_currentBzLogoFile = null;}),
                title: Wordz.businessLogo(context),
                bubbleType: BubbleType.bzLogo,
              ),

              // --- type BzName
              TextFieldBubble(
                textController: _bzNameTextController,
                key: Key('bzName'),
                title: _currentBzForm == BzForm.Individual ? 'Business Entity name' : Wordz.companyName(context),
                hintText: '...',
                counterIsOn: true,
                maxLength: 72,
                maxLines: 2,
                keyboardTextInputType: TextInputType.name,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              // --- type BzScope
              TextFieldBubble(
                textController: _bzScopeTextController,
                key: Key('bzScope'),
                title: '${Wordz.scopeOfServices(context)} :',
                hintText: '...',
                counterIsOn: true,
                maxLength: 193,
                maxLines: 4,
                keyboardTextInputType: TextInputType.multiline,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              // --- type BzAbout
              TextFieldBubble(
                textController: _bzAboutTextController,
                key: Key('bzAbout'),
                title: _bzAboutBubbleTitle,
                hintText: '...',
                counterIsOn: true,
                maxLength: 193,
                maxLines: 4,
                keyboardTextInputType: TextInputType.multiline,
              ),

              _separator,

              // --- bzLocale
              LocaleBubble(
                changeCountry : (countryID) => setState(() {_currentBzCountry = countryID;}),
                changeProvince : (provinceID) => setState(() {_currentBzProvince = provinceID;}),
                changeArea : (areaID) => setState(() {_currentBzArea = areaID;}),
                currentZone: Zone(countryID: _currentBzCountry, provinceID: _currentBzProvince, areaID: _currentBzArea),
                title: 'Headquarters Area',//Wordz.hqCity(context),
              ),

              _separator,

              // --- type AuthorName
              TextFieldBubble(
                textController: _authorNameTextController,
                key: Key('authorName'),
                title: Wordz.authorName(context),
                hintText: '...',
                counterIsOn: true,
                maxLength: 20,
                maxLines: 1,
                keyboardTextInputType: TextInputType.name,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              // --- type AuthorTitle
              TextFieldBubble(
                textController: _authorTitleTextController,
                key: Key('authorTitle'),
                title: Wordz.jobTitle(context),
                hintText: '...',
                counterIsOn: true,
                maxLength: 20,
                maxLines: 1,
                keyboardTextInputType: TextInputType.name,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              // --- ADD AUTHOR PIC
              AddGalleryPicBubble(
                pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
                addBtFunction: _takeAuthorPicture,
                deletePicFunction: () => setState(() {_currentAuthorPicFile = null;}),
                title: 'Add a professional picture of yourself',
                bubbleType: BubbleType.authorPic,
              ),

              PyramidsHorizon(heightFactor: 5,),

            ],
          ),

          // ---  BOTTOM BUTTONS
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              children: <Widget>[

                // --- SHOW BZCARD
                DreamBox(
                  height: 50,
                  color: Colorz.BabyBlue,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.7,
                  verse: 'Show\nFlyer',
                  verseScaleFactor: 0.8,
                  verseColor: Colorz.BlackBlack,
                  verseMaxLines: 2,
                  boxMargins: EdgeInsets.all(5),
                  boxFunction: _showBzCard,
                ),

                // --- CONFIRM BUTTON
                DreamBox(
                  height: 50,
                  color: Colorz.Yellow,
                  verseColor: Colorz.BlackBlack,
                  verseWeight: VerseWeight.black,
                  verse: 'Confirm',
                  secondLine: widget.firstTimer ? 'Create new business profile' : 'Update business profile',
                  verseScaleFactor: 0.7,
                  boxMargins: EdgeInsets.all(5),
                  boxFunction: _confirmButton,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

