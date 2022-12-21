import 'dart:async';

import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
  final ValueNotifier<UserModel> _userModel = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
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

    UserModel _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (_oldUser.need == null){
      _oldUser = _oldUser.copyWith(
        need: NeedModel.createInitialNeed(
          context: context,
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

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
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

    final UserModel _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _needsChanged = UserModel.usersAreIdentical(
        user1: _oldUser,
        user2: _userModel.value
    ) == false;

    if (_needsChanged == true){

      unawaited(WaitDialog.showWaitDialog(
        context: context,
      ));

      final UserModel _newUser = _userModel.value.copyWith(
        need: _userModel.value.need.copyWith(
          since: DateTime.now(),
        ),
      );

      await UserProtocols.renovate(
        context: context,
        newPic: null,
        newUser: _newUser,
        oldUser: _oldUser,
      );

      await WaitDialog.closeWaitDialog(context);

      await Nav.goBack(context: context, invoker: 'onConfirmEditingNeed');

    }

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
            valueListenable: _userModel,
            builder: (_, UserModel userModel, Widget child){

              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: Stratosphere.stratosphereSandwich,
                children: <Widget>[

                  /// NEED TYPE SELECTION
                  Bubble(
                      bubbleHeaderVM: const BubbleHeaderVM(),
                      childrenCentered: true,
                      columnChildren: <Widget>[

                        /// WHAT ARE YOU LOOKING FOR
                        const SuperVerse(
                          verse: Verse(
                            text: 'phid_what_are_you_looking_for',
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
                        BulletPoints(
                          bubbleWidth: Bubble.clearWidth(context) - 50,
                          centered: true,
                          bulletPoints: const <Verse>[
                            Verse(
                              text: 'phid_all_businesses_can_see_this',
                              translate: true,
                            ),
                            Verse(
                              text: 'phid_businesses_can_respond_and_ask_for_more_info',
                              translate: true,
                            ),

                          ],
                        ),

                        /// BUTTONS
                        ...List.generate(NeedModel.needsTypes.length, (index){

                          final NeedType _type = NeedModel.needsTypes[index];
                          final bool _isSelected = userModel.need.needType == _type;

                          return Bubble(
                            width: Bubble.clearWidth(context),
                            bubbleColor: _isSelected == true ? Colorz.yellow255 : Colorz.white10,
                            bubbleHeaderVM: const BubbleHeaderVM(),
                            onBubbleTap: (){

                              setNotifier(
                                  notifier: _userModel,
                                  mounted: mounted,
                                  value: _userModel.value.copyWith(
                                    need: _userModel.value.need.copyWith(
                                      needType: _type,
                                    ),
                                  ),
                              );

                              },
                            childrenCentered: true,
                            columnChildren: <Widget>[

                              SizedBox(
                                width: Bubble.clearWidth(context),
                                child: SuperVerse(
                                  verse: Verse(
                                    text: NeedModel.getNeedTypePhid(_type),
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
                  TextFieldBubble(
                    key: const ValueKey<String>('need_description_button'),
                    formKey: _formKey,
                    bubbleHeaderVM: const BubbleHeaderVM(
                      headlineVerse: Verse(
                        text: 'phid_extra_notes',
                        translate: true,

                      ),
                    ),
                    // focusNode: _aboutNode,
                    appBarType: AppBarType.basic,
                    hintVerse: const Verse(
                      text: 'phid_tell_businesses_what_you_looking_for',
                      translate: true,
                    ),
                    counterIsOn: true,
                    maxLength: 1000,
                    maxLines: 20,
                    keyboardTextInputType: TextInputType.multiline,
                    initialText: userModel.need?.notes,
                    onTextChanged: (String text){

                      setNotifier(
                          notifier: _userModel,
                          mounted: mounted,
                          value: _userModel.value.copyWith(
                            need: _userModel.value.need.copyWith(
                              notes: text,
                            ),
                          ),
                      );

                    },
                    // autoValidate: true,
                    validator: (String text){
                      return null;
                    },
                  ),

                  /// SPECIFIC ZONE
                  ZoneSelectionBubble(
                    zoneViewingEvent: ViewingEvent.userEditor,
                    titleVerse: const Verse(
                      text: 'phid_zone',
                      translate: true,
                    ),
                    isRequired: false,
                    currentZone: userModel.zone,
                    depth: ZoneDepth.district,
                    onZoneChanged: (ZoneModel zone) async {

                      final ZoneModel _completeZone = await ZoneProtocols.completeZoneModel(
                        context: context,
                        incompleteZoneModel: zone,
                      );

                      setNotifier(
                          notifier: _userModel,
                          mounted: mounted,
                          value: _userModel.value.copyWith(
                            zone: _completeZone,
                          ),
                      );

                    },
                    // selectCountryAndCityOnly: true,
                    // selectCountryIDOnly: false,
                    validator: () => Formers.zoneValidator(
                      context: context,
                      zoneModel: userModel.zone,
                      selectCountryAndCityOnly: true,
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
