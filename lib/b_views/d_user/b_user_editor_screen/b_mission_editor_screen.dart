import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/user/user_project.dart';
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

class MissionEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MissionEditorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<MissionEditorScreen> createState() => _MissionEditorScreenState();
/// --------------------------------------------------------------------------
}

class _MissionEditorScreenState extends State<MissionEditorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final ValueNotifier<UserStatus> _currentUserStatus = ValueNotifier(null);
  final ValueNotifier<MissionModel> _mission = ValueNotifier(null);
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
    _mission.value = MissionModel.createInitialMission(
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
    _mission.dispose();
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
  Future<void> onConfirmEditingMission() async {

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
        text: 'phid_blding_mission',
        translate: true,
      ),
      appBarRowWidgets: [
        AppBarButton(
          verse: Verse.plain('BOM'),
          onTap: (){

            Formers.validateForm(_formKey);

            // _tempBz.value = _tempBz.value.nullifyField(
            //   zone: true,
            // );

            // _tempBz.value = _tempBz.value.copyWith(
            //   bz: [],
            // );

          },
        ),
      ],
      confirmButtonModel: ConfirmButtonModel(
        firstLine: const Verse(
          text: 'phid_confirm',
          translate: true,
        ),
        secondLine: const Verse(
          text: 'phid_confirm',
          translate: true,
        ),
        onTap: () => onConfirmEditingMission(),
      ),
      layoutWidget: Form(
        key: _formKey,
        child: ValueListenableBuilder(
            valueListenable: _mission,
            builder: (_, MissionModel mission, Widget child){

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

                  /// MISSION TYPE SELECTION
                  MultipleChoiceBubble(
                    titleVerse: const Verse(
                      pseudo: 'What are you planning for ?',
                      text: 'phid_what_are_you_looking_for',
                      translate: true,
                    ),
                    onButtonTap: (int index){
                      blog('selected this shit : ${MissionModel.missionsTypes[index]}');
                      _mission.value = _mission.value.copyWith(
                        missionType: MissionModel.missionsTypes[index],
                      );
                    },
                    selectedButtonsPhids: <String>[MissionModel.getMissionTypePhid(mission.missionType)],
                    buttonsVerses: MissionModel.getMissionTypesVerses(
                      context: context,
                      missionsTypes: MissionModel.missionsTypes,
                    ),
                    wrapButtons: false,
                  ),

                  /// SCOPE SELECTOR
                  ScopeSelectorBubble(
                    headlineVerse: const Verse(
                      text: 'phid_mission_scope',
                      translate: true,
                    ),
                    bzTypes: MissionModel.concludeBzzTypesByMissionType(mission.missionType),
                    selectedSpecs: SpecModel.generateSpecsByPhids(
                      context: context,
                      phids: mission.scope,
                    ),
                    bulletPoints: const <Verse>[
                      Verse(
                        pseudo: 'Select at least 1 keyword to help search engines show your content in its dedicated place',
                        text: '##Select at least 1 keyword to help search engines show your content in its dedicated place',
                        translate: true,
                      )
                    ],
                    onAddScope: () => onAddScopesTap(
                        context: context,
                        selectedSpecs: SpecModel.generateSpecsByPhids(
                          context: context,
                          phids: mission.scope,
                        ),
                        bzTypes: MissionModel.concludeBzzTypesByMissionType(mission.missionType),
                        zone: mission.zone,
                        onlyChainKSelection: false,
                        onFinish: (List<SpecModel> specs) async {
                          if (specs != null){
                            _mission.value = _mission.value.copyWith(
                              scope: SpecModel.getSpecsIDs(specs),
                            );
                          }
                        },
                    ),
                  ),

                  /// MISSION ZONE
                  ZoneSelectionBubble(
                    titleVerse: const Verse(
                      text: 'phid_mission_zone',
                      translate: true,
                    ),
                    currentZone: mission.zone,
                    onZoneChanged: (ZoneModel zone){
                      _mission.value = _mission.value.copyWith(
                        zone: zone,
                      );
                    },
                    // selectCountryAndCityOnly: true,
                    // selectCountryIDOnly: false,
                    validator: () => Formers.zoneValidator(
                      zoneModel: mission.zone,
                      selectCountryAndCityOnly: true,
                      selectCountryIDOnly: false,
                      canValidate: true,
                    ),
                  ),

                  /// MISSION DESCRIPTION
                  TextFieldBubble(
                    key: const ValueKey<String>('mission_description_button'),
                    globalKey: _formKey,
                    // focusNode: _aboutNode,
                    appBarType: AppBarType.basic,
                    titleVerse: const Verse(
                      text: 'phid_mission_notes',
                      translate: true,
                    ),
                    counterIsOn: true,
                    maxLength: 1000,
                    maxLines: 20,
                    keyboardTextInputType: TextInputType.multiline,
                    initialText: mission?.description,
                    textOnChanged: (String text){
                      _mission.value = _mission.value.copyWith(
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
