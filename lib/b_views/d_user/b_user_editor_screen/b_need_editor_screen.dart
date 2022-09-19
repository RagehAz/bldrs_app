import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/user/need_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/x_bz_editor_screen_controllers.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/z_components/scope_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/status_bubble.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class NeedEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NeedEditorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<NeedEditorScreen> createState() => _NeedEditorScreenState();
/// --------------------------------------------------------------------------
}

class _NeedEditorScreenState extends State<NeedEditorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final ValueNotifier<UserStatus> _currentUserStatus = ValueNotifier(null);
  final ValueNotifier<NeedModel> _need = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    _currentUserStatus.value = _userModel.status;
    _need.value = NeedModel.createInitialNeed(
      context: context,
      userZone: _userModel.zone,
    );

  }
  // --------------------

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  // --------------------
  @override
  void dispose() {
    _currentUserStatus.dispose();
    _need.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  static const List<Map<String, dynamic>> _status = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Property Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Looking for a new property',
          'userStatus': UserStatus.searching
        },
        <String, dynamic>{
          'state': 'Constructing an existing property',
          'userStatus': UserStatus.finishing
        },
        <String, dynamic>{
          'state': 'Want to Sell / Rent my property',
          'userStatus': UserStatus.selling
        }
      ],
    },
    <String, dynamic>{
      'title': 'Construction Status',
      'buttons': <Map<String, dynamic>>[
        <String, dynamic>{
          'state': 'Planning Construction',
          'userStatus': UserStatus.planning
        },
        <String, dynamic>{
          'state': 'Under Construction',
          'userStatus': UserStatus.building
        }
      ],
    },
  ];
  // --------------------
  void _switchUserStatus(UserStatus type) {
    _currentUserStatus.value = type;
  }
  // --------------------
  Future<void> onConfirmEditingNeed() async {

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel _userModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

    return MainLayout(
      key: const ValueKey<String>('BzEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: const Verse(
        text: 'phid_edit_needs',
        translate: true,
      ),
      confirmButtonModel: ConfirmButtonModel(
        firstLine: const Verse(
          text: 'phid_confirm',
          translate: true,
        ),
        secondLine: const Verse(
          text: 'phid_confirm',
          translate: true,
        ),
        onTap: () => onConfirmEditingNeed(),
      ),
      layoutWidget: Form(
        key: _formKey,
        child: ValueListenableBuilder(
            valueListenable: _need,
            builder: (_, NeedModel need, Widget child){

              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: Stratosphere.stratosphereSandwich,
                children: <Widget>[

                  ValueListenableBuilder(
                    valueListenable: _currentUserStatus,
                    builder: (_, UserStatus userStatus, Widget child){
                      return StatusBubble(
                        status: _status,
                        currentStatus: userStatus,
                        onSelectStatus: (UserStatus type) => _switchUserStatus(type),
                      );
                    },
                  ),

                  /// NEED TYPE SELECTION
                  MultipleChoiceBubble(
                    titleVerse: const Verse(
                      pseudo: 'What are you planning for ?',
                      text: 'phid_what_are_you_looking_for',
                      translate: true,
                    ),
                    onButtonTap: (int index){
                      blog('selected this shit : ${NeedModel.needsType[index]}');
                      _need.value = _need.value.copyWith(
                        needType: NeedModel.needsType[index],
                      );
                    },
                    selectedButtonsPhids: <String>[NeedModel.getNeedTypePhid(need.needType)],
                    buttonsVerses: NeedModel.getNeedsTypesVerses(
                      context: context,
                      needsTypes: NeedModel.needsType,
                    ),
                    wrapButtons: false,
                  ),

                  /// SCOPE SELECTOR
                  ScopeSelectorBubble(
                    headlineVerse: const Verse(
                      text: 'phid_specs',
                      translate: true,
                    ),
                    flyerTypes: NeedModel.concludeFlyersTypesByNeedType(need.needType),
                    selectedSpecs: SpecModel.generateSpecsByPhids(
                      context: context,
                      phids: need.scope,
                    ),
                    bulletPoints: const <Verse>[
                      Verse(
                        text: 'x',
                        translate: true,
                      )
                    ],
                    addButtonVerse: const Verse(
                      text: 'phid_add_specs',
                      translate: true,
                    ),
                    onAddScope: (FlyerType flyerType) => onAddScopesTap(
                        context: context,
                        selectedSpecs: SpecModel.generateSpecsByPhids(
                          context: context,
                          phids: need.scope,
                        ),
                        flyerType: flyerType,
                        zone: need.zone,
                        onlyChainKSelection: false,
                        onFinish: (List<SpecModel> specs) async {
                          if (specs != null){
                            _need.value = _need.value.copyWith(
                              scope: SpecModel.getSpecsIDs(specs),
                            );
                          }
                        },
                    ),
                  ),

                  /// NEED ZONE
                  ZoneSelectionBubble(
                    titleVerse: const Verse(
                      text: 'phid_zone',
                      translate: true,
                    ),
                    isRequired: false,
                    currentZone: need.zone,
                    onZoneChanged: (ZoneModel zone){
                      _need.value = _need.value.copyWith(
                        zone: zone,
                      );
                    },
                    // selectCountryAndCityOnly: true,
                    // selectCountryIDOnly: false,
                    validator: () => Formers.zoneValidator(
                      zoneModel: need.zone,
                      selectCountryAndCityOnly: true,
                      selectCountryIDOnly: false,
                      canValidate: true,
                    ),
                  ),

                  /// NEED DESCRIPTION
                  TextFieldBubble(
                    key: const ValueKey<String>('need_description_button'),
                    globalKey: _formKey,
                    // focusNode: _aboutNode,
                    appBarType: AppBarType.basic,
                    titleVerse: const Verse(
                      text: 'phid_extra_notes',
                      translate: true,
                    ),
                    hintVerse: const Verse(
                      text: 'phid_tell_businesses_what_you_looking_for',
                      translate: true,
                    ),
                    counterIsOn: true,
                    maxLength: 1000,
                    maxLines: 20,
                    keyboardTextInputType: TextInputType.multiline,
                    initialText: need?.description,
                    textOnChanged: (String text){
                      _need.value = _need.value.copyWith(
                        description: text,
                      );
                    },
                    // autoValidate: true,
                    validator: (String text){
                      return null;
                    },
                  ),

                  /// SELECT FLYERS BUBBLE

                ],
              );

            }),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
