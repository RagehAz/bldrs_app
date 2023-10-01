import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class NeedEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NeedEditorScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  State<NeedEditorScreen> createState() => _NeedEditorScreenState();
/// --------------------------------------------------------------------------
}

class _NeedEditorScreenState extends State<NeedEditorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final ValueNotifier<UserModel?> _userModel = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    UserModel? _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (_oldUser?.need == null){
      _oldUser = _oldUser?.copyWith(
        need: NeedModel.createInitialNeed(
          userZone: _oldUser.zone,
        ),
      );
    }

    setNotifier(
        notifier: _userModel,
        mounted: mounted,
        value: _oldUser,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _userModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> onConfirmEditingNeed() async {

    final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _needsChanged = UserModel.usersAreIdentical(
        user1: _oldUser,
        user2: _userModel.value
    ) == false;

    if (_needsChanged == true){

      WaitDialog.showUnawaitedWaitDialog();

      final UserModel? _newUser = _userModel.value?.copyWith(
        need: _userModel.value?.need?.copyWith(
          since: DateTime.now(),
        ),
      );

      await UserProtocols.renovate(
        newUser: _newUser,
        oldUser: _oldUser,
        invoker: 'onConfirmEditingNeed',
      );

      await WaitDialog.closeWaitDialog();

      await Nav.goBack(
          context: context,
          invoker: 'onConfirmEditingNeed',
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel _userModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

    final double _clearWidth = Bubble.clearWidth(context: context);

    return MainLayout(
      key: const ValueKey<String>('BzEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      searchButtonIsOn: false,
      skyType: SkyType.grey,
      title: const Verse(
        id: 'phid_edit_needs',
        translate: true,
      ),
      confirmButton: ConfirmButton.button(
        // onSkipTap: ,
        // enAlignment: ,
        // isDisabled: ,
        firstLine: const Verse(
          id: 'phid_confirm',
          translate: true,
        ),
        secondLine: const Verse(
          id: 'phid_confirm',
          translate: true,
        ),
        onTap: () => onConfirmEditingNeed(),
      ),
      child: Form(
        key: _formKey,
        child: ValueListenableBuilder(
            valueListenable: _userModel,
            builder: (_, UserModel? userModel, Widget? child){

              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: Stratosphere.stratosphereSandwich,
                children: <Widget>[

                  /// NEED TYPE SELECTION
                  Bubble(
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                      ),
                      childrenCentered: true,
                      columnChildren: <Widget>[

                        /// WHAT ARE YOU LOOKING FOR
                        const BldrsText(
                          verse: Verse(
                            id: 'phid_what_are_you_looking_for',
                            translate: true,
                            casing: Casing.upperCase,
                          ),
                          margin: 20,
                          maxLines: 3,
                          size: 3,
                          weight: VerseWeight.black,
                          color: Colorz.yellow255,
                          shadow: true,
                        ),

                        /// BULLET POINTS
                        BldrsBulletPoints(
                          bubbleWidth: _clearWidth - 50,
                          centered: true,
                          bulletPoints: const <Verse>[
                            Verse(
                              id: 'phid_all_businesses_can_see_this',
                              translate: true,
                            ),
                            Verse(
                              id: 'phid_businesses_can_respond_and_ask_for_more_info',
                              translate: true,
                            ),

                          ],
                        ),

                        /// BUTTONS
                        ...List.generate(NeedModel.needsTypes.length, (index){

                          final NeedType _type = NeedModel.needsTypes[index];
                          final bool _isSelected = userModel?.need?.needType == _type;

                          return Bubble(
                            width: _clearWidth,
                            bubbleColor: _isSelected == true ? Colorz.yellow255 : Colorz.white10,
                            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                              context: context,
                            ),
                            onBubbleTap: (){

                              setNotifier(
                                  notifier: _userModel,
                                  mounted: mounted,
                                  value: _userModel.value?.copyWith(
                                    need: _userModel.value?.need?.copyWith(
                                      needType: _type,
                                    ),
                                  ),
                              );

                              },
                            childrenCentered: true,
                            columnChildren: <Widget>[

                              SizedBox(
                                width: Bubble.clearWidth(context: context),
                                child: BldrsText(
                                  verse: Verse(
                                    id: NeedModel.getNeedTypePhid(_type),
                                    translate: true,
                                  ),
                                  color: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                  italic: true,
                                ),
                              ),

                            ],
                          );

                        }),

                      ]
                  ),

                  /// NEED DESCRIPTION
                  BldrsTextFieldBubble(
                    key: const ValueKey<String>('need_description_button'),
                    formKey: _formKey,
                    bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                      context: context,
                      headlineVerse: const Verse(
                        id: 'phid_extra_notes',
                        translate: true,

                      ),
                    ),
                    // focusNode: _aboutNode,
                    appBarType: AppBarType.basic,
                    hintVerse: const Verse(
                      id: 'phid_tell_businesses_what_you_looking_for',
                      translate: true,
                    ),
                    counterIsOn: true,
                    maxLength: 1000,
                    maxLines: 20,
                    keyboardTextInputType: TextInputType.multiline,
                    initialText: userModel?.need?.notes,
                    autoCorrect: Keyboard.autoCorrectIsOn(),
                    enableSuggestions: Keyboard.suggestionsEnabled(),
                    onTextChanged: (String? text){

                      setNotifier(
                          notifier: _userModel,
                          mounted: mounted,
                          value: _userModel.value?.copyWith(
                            need: _userModel.value?.need?.copyWith(
                              notes: text,
                            ),
                          ),
                      );

                    },
                    // autoValidate: true,
                    validator: (String? text){
                      return null;
                    },
                  ),

                  /// SPECIFIC ZONE
                  ZoneSelectionBubble(
                    zoneViewingEvent: ViewingEvent.userEditor,
                    titleVerse: const Verse(
                      id: 'phid_zone',
                      translate: true,
                    ),
                    isRequired: false,
                    currentZone: userModel?.zone,
                    viewerZone: userModel?.zone,
                    depth: ZoneDepth.city,
                    onZoneChanged: (ZoneModel? zone) async {

                      final ZoneModel? _completeZone = await ZoneProtocols.completeZoneModel(
                        incompleteZoneModel: zone,
                        invoker: 'BzEditorScreen.onZoneChanged',
                      );

                      setNotifier(
                          notifier: _userModel,
                          mounted: mounted,
                          value: _userModel.value?.copyWith(
                            zone: _completeZone,
                          ),
                      );

                    },
                    validator: () => Formers.zoneValidator(
                      zoneModel: userModel?.zone,
                      selectCountryIDOnly: false,
                      canValidate: true,
                    ),
                  ),

                  /// PLAN : SCOPE SELECTOR : put it later after we test : it might be ..
                  /// PLAN : overwhelming and complex for users now to handle
                  /*
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
                          _need.value  = _need.value.copyWith(
                            scope: SpecModel.getSpecsIDs(specs),
                          );
                        }
                      },
                    ),
                  ),
                   */

                  /// PLAN : SELECT FLYERS BUBBLE

                  const Horizon(),

                ],
              );

            }),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
