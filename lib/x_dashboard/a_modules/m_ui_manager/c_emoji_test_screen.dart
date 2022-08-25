import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class EmojiTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EmojiTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  Future<void> onEmojiTap({
    @required BuildContext context,
    @required EmojiModel emo,
    @required int index
  }) async {

    await BottomDialog.showBottomDialog(
      context: context,
      title: '${emo.emoji}  ${emo.name}',
      height: 400,
      draggable: true,
      child: Container(
        width: BottomDialog.clearWidth(context),
        height: BottomDialog.clearHeight(
            draggable: true,
            context: context,
            titleIsOn: true,
            overridingDialogHeight: 400),
        color: Colorz.bloodTest,
        child: SuperVerse(
          verse:  '$index : ${emo.code}',
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<EmojiModel> _emojis = EmojiModel.allEmojis();

    return MainLayout(
      pageTitleVerse:  'Emojis',
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      layoutWidget: GridView.builder(
          itemCount: _emojis.length,
          padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 2.5,
            crossAxisSpacing: 2.5,
          ),
          itemBuilder: (BuildContext ctx, int index) {
            final EmojiModel _emoji = _emojis[index];

            return DreamBox(
              height: 50,
              width: 50,
              verse: _emoji.emoji,
              verseWeight: VerseWeight.thin,
              // margins: EdgeInsets.symmetric(horizontal: 2.5),
              onTap: () => onEmojiTap(
                context: context,
                emo: _emoji,
                index: index,
              ),
            );
          }),
    );
  }
}

class EmojiModel {
  /// --------------------------------------------------------------------------
  const EmojiModel({
    @required this.name,
    @required this.code,
    @required this.emoji,
  });

  /// --------------------------------------------------------------------------
  final String name;
  final String code;
  final String emoji;

  /// --------------------------------------------------------------------------
  static List<EmojiModel> allEmojis() {
    return const <EmojiModel>[
      EmojiModel(
          name: 'smile_grinning_face',
          code: 'u{1f600}',
          emoji: Emojis.smile_grinning_face),
      EmojiModel(
          name: 'smile_grinning_face_with_big_eyes',
          code: 'u{1f603}',
          emoji: Emojis.smile_grinning_face_with_big_eyes),
      EmojiModel(
          name: 'smile_grinning_face_with_smiling_eyes',
          code: 'u{1f604}',
          emoji: Emojis.smile_grinning_face_with_smiling_eyes),
      EmojiModel(
          name: 'smile_beaming_face_with_smiling_eyes',
          code: 'u{1f601}',
          emoji: Emojis.smile_beaming_face_with_smiling_eyes),
      EmojiModel(
          name: 'smile_grinning_squinting_face',
          code: 'u{1f606}',
          emoji: Emojis.smile_grinning_squinting_face),
      EmojiModel(
          name: 'smile_grinning_face_with_sweat',
          code: 'u{1f605}',
          emoji: Emojis.smile_grinning_face_with_sweat),
      EmojiModel(
          name: 'smile_rolling_on_the_floor_laughing',
          code: 'u{1f923}',
          emoji: Emojis.smile_rolling_on_the_floor_laughing),
      EmojiModel(
          name: 'smile_face_with_tears_of_joy',
          code: 'u{1f602}',
          emoji: Emojis.smile_face_with_tears_of_joy),
      EmojiModel(
          name: 'smile_slightly_smiling_face',
          code: 'u{1f642}',
          emoji: Emojis.smile_slightly_smiling_face),
      EmojiModel(
          name: 'smile_upside_down_face',
          code: 'u{1f643}',
          emoji: Emojis.smile_upside_down_face),
      EmojiModel(
          name: 'smile_winking_face',
          code: 'u{1f609}',
          emoji: Emojis.smile_winking_face),
      EmojiModel(
          name: 'smile_smiling_face_with_smiling_eyes',
          code: 'u{1f60a}',
          emoji: Emojis.smile_smiling_face_with_smiling_eyes),
      EmojiModel(
          name: 'smile_smiling_face_with_halo',
          code: 'u{1f607}',
          emoji: Emojis.smile_smiling_face_with_halo),
      EmojiModel(
          name: 'smile_smiling_face_with_hearts',
          code: 'u{1f970}',
          emoji: Emojis.smile_smiling_face_with_hearts),
      EmojiModel(
          name: 'smile_smiling_face_with_heart_eyes',
          code: 'u{1f60d}',
          emoji: Emojis.smile_smiling_face_with_heart_eyes),
      EmojiModel(
          name: 'smile_star_struck',
          code: 'u{1f929}',
          emoji: Emojis.smile_star_struck),
      EmojiModel(
          name: 'smile_face_blowing_a_kiss',
          code: 'u{1f618}',
          emoji: Emojis.smile_face_blowing_a_kiss),
      EmojiModel(
          name: 'smile_kissing_face',
          code: 'u{1f617}',
          emoji: Emojis.smile_kissing_face),
      EmojiModel(
          name: 'smile_smiling_face',
          code: 'u{263a}',
          emoji: Emojis.smile_smiling_face),
      EmojiModel(
          name: 'smile_kissing_face_with_closed_eyes',
          code: 'u{1f61a}',
          emoji: Emojis.smile_kissing_face_with_closed_eyes),
      EmojiModel(
          name: 'smile_kissing_face_with_smiling_eyes',
          code: 'u{1f619}',
          emoji: Emojis.smile_kissing_face_with_smiling_eyes),
      EmojiModel(
          name: 'smile_smiling_face_with_tear',
          code: 'u{1f972}',
          emoji: Emojis.smile_smiling_face_with_tear),
      EmojiModel(
          name: 'smile_face_savoring_food',
          code: 'u{1f60b}',
          emoji: Emojis.smile_face_savoring_food),
      EmojiModel(
          name: 'smile_face_with_tongue',
          code: 'u{1f61b}',
          emoji: Emojis.smile_face_with_tongue),
      EmojiModel(
          name: 'smile_winking_face_with_tongue',
          code: 'u{1f61c}',
          emoji: Emojis.smile_winking_face_with_tongue),
      EmojiModel(
          name: 'smile_zany_face',
          code: 'u{1f92a}',
          emoji: Emojis.smile_zany_face),
      EmojiModel(
          name: 'smile_squinting_face_with_tongue',
          code: 'u{1f61d}',
          emoji: Emojis.smile_squinting_face_with_tongue),
      EmojiModel(
          name: 'smile_money_mouth_face',
          code: 'u{1f911}',
          emoji: Emojis.smile_money_mouth_face),
      EmojiModel(
          name: 'smile_hugging_face',
          code: 'u{1f917}',
          emoji: Emojis.smile_hugging_face),
      EmojiModel(
          name: 'smile_face_with_hand_over_mouth',
          code: 'u{1f92d}',
          emoji: Emojis.smile_face_with_hand_over_mouth),
      EmojiModel(
          name: 'smile_shushing_face',
          code: 'u{1f92b}',
          emoji: Emojis.smile_shushing_face),
      EmojiModel(
          name: 'smile_thinking_face',
          code: 'u{1f914}',
          emoji: Emojis.smile_thinking_face),
      EmojiModel(
          name: 'smile_zipper_mouth_face',
          code: 'u{1f910}',
          emoji: Emojis.smile_zipper_mouth_face),
      EmojiModel(
          name: 'smile_face_with_raised_eyebrow',
          code: 'u{1f928}',
          emoji: Emojis.smile_face_with_raised_eyebrow),
      EmojiModel(
          name: 'smile_neutral_face',
          code: 'u{1f610}',
          emoji: Emojis.smile_neutral_face),
      EmojiModel(
          name: 'smile_expressionless_face',
          code: 'u{1f611}',
          emoji: Emojis.smile_expressionless_face),
      EmojiModel(
          name: 'smile_face_without_mouth',
          code: 'u{1f636}',
          emoji: Emojis.smile_face_without_mouth),
      EmojiModel(
          name: 'smile_smirking_face',
          code: 'u{1f60f}',
          emoji: Emojis.smile_smirking_face),
      EmojiModel(
          name: 'smile_unamused_face',
          code: 'u{1f612}',
          emoji: Emojis.smile_unamused_face),
      EmojiModel(
          name: 'smile_face_with_rolling_eyes',
          code: 'u{1f644}',
          emoji: Emojis.smile_face_with_rolling_eyes),
      EmojiModel(
          name: 'smile_grimacing_face',
          code: 'u{1f62c}',
          emoji: Emojis.smile_grimacing_face),
      EmojiModel(
          name: 'smile_lying_face',
          code: 'u{1f925}',
          emoji: Emojis.smile_lying_face),
      EmojiModel(
          name: 'smile_relieved_face',
          code: 'u{1f60c}',
          emoji: Emojis.smile_relieved_face),
      EmojiModel(
          name: 'smile_pensive_face',
          code: 'u{1f614}',
          emoji: Emojis.smile_pensive_face),
      EmojiModel(
          name: 'smile_sleepy_face',
          code: 'u{1f62a}',
          emoji: Emojis.smile_sleepy_face),
      EmojiModel(
          name: 'smile_drooling_face',
          code: 'u{1f924}',
          emoji: Emojis.smile_drooling_face),
      EmojiModel(
          name: 'smile_sleeping_face',
          code: 'u{1f634}',
          emoji: Emojis.smile_sleeping_face),
      EmojiModel(
          name: 'smile_face_with_medical_mask',
          code: 'u{1f637}',
          emoji: Emojis.smile_face_with_medical_mask),
      EmojiModel(
          name: 'smile_face_with_thermometer',
          code: 'u{1f912}',
          emoji: Emojis.smile_face_with_thermometer),
      EmojiModel(
          name: 'smile_face_with_head_bandage',
          code: 'u{1f915}',
          emoji: Emojis.smile_face_with_head_bandage),
      EmojiModel(
          name: 'smile_nauseated_face',
          code: 'u{1f922}',
          emoji: Emojis.smile_nauseated_face),
      EmojiModel(
          name: 'smile_face_vomiting',
          code: 'u{1f92e}',
          emoji: Emojis.smile_face_vomiting),
      EmojiModel(
          name: 'smile_sneezing_face',
          code: 'u{1f927}',
          emoji: Emojis.smile_sneezing_face),
      EmojiModel(
          name: 'smile_hot_face',
          code: 'u{1f975}',
          emoji: Emojis.smile_hot_face),
      EmojiModel(
          name: 'smile_cold_face',
          code: 'u{1f976}',
          emoji: Emojis.smile_cold_face),
      EmojiModel(
          name: 'smile_woozy_face',
          code: 'u{1f974}',
          emoji: Emojis.smile_woozy_face),
      EmojiModel(
          name: 'smile_knocked_out_face',
          code: 'u{1f635}',
          emoji: Emojis.smile_knocked_out_face),
      EmojiModel(
          name: 'smile_exploding_head',
          code: 'u{1f92f}',
          emoji: Emojis.smile_exploding_head),
      EmojiModel(
          name: 'smile_cowboy_hat_face',
          code: 'u{1f920}',
          emoji: Emojis.smile_cowboy_hat_face),
      EmojiModel(
          name: 'smile_partying_face',
          code: 'u{1f973}',
          emoji: Emojis.smile_partying_face),
      EmojiModel(
          name: 'smile_disguised_face',
          code: 'u{1f978}',
          emoji: Emojis.smile_disguised_face),
      EmojiModel(
          name: 'smile_smiling_face_with_sunglasses',
          code: 'u{1f60e}',
          emoji: Emojis.smile_smiling_face_with_sunglasses),
      EmojiModel(
          name: 'smile_nerd_face',
          code: 'u{1f913}',
          emoji: Emojis.smile_nerd_face),
      EmojiModel(
          name: 'smile_face_with_monocle',
          code: 'u{1f9d0}',
          emoji: Emojis.smile_face_with_monocle),
      EmojiModel(
          name: 'smile_confused_face',
          code: 'u{1f615}',
          emoji: Emojis.smile_confused_face),
      EmojiModel(
          name: 'smile_worried_face',
          code: 'u{1f61f}',
          emoji: Emojis.smile_worried_face),
      EmojiModel(
          name: 'smile_slightly_frowning_face',
          code: 'u{1f641}',
          emoji: Emojis.smile_slightly_frowning_face),
      EmojiModel(
          name: 'smile_frowning_face',
          code: 'u{2639}',
          emoji: Emojis.smile_frowning_face),
      EmojiModel(
          name: 'smile_face_with_open_mouth',
          code: 'u{1f62e}',
          emoji: Emojis.smile_face_with_open_mouth),
      EmojiModel(
          name: 'smile_hushed_face',
          code: 'u{1f62f}',
          emoji: Emojis.smile_hushed_face),
      EmojiModel(
          name: 'smile_astonished_face',
          code: 'u{1f632}',
          emoji: Emojis.smile_astonished_face),
      EmojiModel(
          name: 'smile_flushed_face',
          code: 'u{1f633}',
          emoji: Emojis.smile_flushed_face),
      EmojiModel(
          name: 'smile_pleading_face',
          code: 'u{1f97a}',
          emoji: Emojis.smile_pleading_face),
      EmojiModel(
          name: 'smile_frowning_face_with_open_mouth',
          code: 'u{1f626}',
          emoji: Emojis.smile_frowning_face_with_open_mouth),
      EmojiModel(
          name: 'smile_anguished_face',
          code: 'u{1f627}',
          emoji: Emojis.smile_anguished_face),
      EmojiModel(
          name: 'smile_fearful_face',
          code: 'u{1f628}',
          emoji: Emojis.smile_fearful_face),
      EmojiModel(
          name: 'smile_anxious_face_with_sweat',
          code: 'u{1f630}',
          emoji: Emojis.smile_anxious_face_with_sweat),
      EmojiModel(
          name: 'smile_sad_but_relieved_face',
          code: 'u{1f625}',
          emoji: Emojis.smile_sad_but_relieved_face),
      EmojiModel(
          name: 'smile_crying_face',
          code: 'u{1f622}',
          emoji: Emojis.smile_crying_face),
      EmojiModel(
          name: 'smile_loudly_crying_face',
          code: 'u{1f62d}',
          emoji: Emojis.smile_loudly_crying_face),
      EmojiModel(
          name: 'smile_face_screaming_in_fear',
          code: 'u{1f631}',
          emoji: Emojis.smile_face_screaming_in_fear),
      EmojiModel(
          name: 'smile_confounded_face',
          code: 'u{1f616}',
          emoji: Emojis.smile_confounded_face),
      EmojiModel(
          name: 'smile_persevering_face',
          code: 'u{1f623}',
          emoji: Emojis.smile_persevering_face),
      EmojiModel(
          name: 'smile_disappointed_face',
          code: 'u{1f61e}',
          emoji: Emojis.smile_disappointed_face),
      EmojiModel(
          name: 'smile_downcast_face_with_sweat',
          code: 'u{1f613}',
          emoji: Emojis.smile_downcast_face_with_sweat),
      EmojiModel(
          name: 'smile_weary_face',
          code: 'u{1f629}',
          emoji: Emojis.smile_weary_face),
      EmojiModel(
          name: 'smile_tired_face',
          code: 'u{1f62b}',
          emoji: Emojis.smile_tired_face),
      EmojiModel(
          name: 'smile_yawning_face',
          code: 'u{1f971}',
          emoji: Emojis.smile_yawning_face),
      EmojiModel(
          name: 'smile_face_with_steam_from_nose',
          code: 'u{1f624}',
          emoji: Emojis.smile_face_with_steam_from_nose),
      EmojiModel(
          name: 'smile_pouting_face',
          code: 'u{1f621}',
          emoji: Emojis.smile_pouting_face),
      EmojiModel(
          name: 'smile_angry_face',
          code: 'u{1f620}',
          emoji: Emojis.smile_angry_face),
      EmojiModel(
          name: 'smile_face_with_symbols_on_mouth',
          code: 'u{1f92c}',
          emoji: Emojis.smile_face_with_symbols_on_mouth),
      EmojiModel(
          name: 'smile_smiling_face_with_horns',
          code: 'u{1f608}',
          emoji: Emojis.smile_smiling_face_with_horns),
      EmojiModel(
          name: 'smile_angry_face_with_horns',
          code: 'u{1f47f}',
          emoji: Emojis.smile_angry_face_with_horns),
      EmojiModel(
          name: 'smile_skull', code: 'u{1f480}', emoji: Emojis.smile_skull),
      EmojiModel(
          name: 'smile_skull_and_crossbones',
          code: 'u{2620}',
          emoji: Emojis.smile_skull_and_crossbones),
      EmojiModel(
          name: 'smile_pile_of_poo',
          code: 'u{1f4a9}',
          emoji: Emojis.smile_pile_of_poo),
      EmojiModel(
          name: 'smile_clown_face',
          code: 'u{1f921}',
          emoji: Emojis.smile_clown_face),
      EmojiModel(
          name: 'smile_ogre', code: 'u{1f479}', emoji: Emojis.smile_ogre),
      EmojiModel(
          name: 'smile_goblin', code: 'u{1f47a}', emoji: Emojis.smile_goblin),
      EmojiModel(
          name: 'smile_ghost', code: 'u{1f47b}', emoji: Emojis.smile_ghost),
      EmojiModel(
          name: 'smile_alien', code: 'u{1f47d}', emoji: Emojis.smile_alien),
      EmojiModel(
          name: 'smile_alien_monster',
          code: 'u{1f47e}',
          emoji: Emojis.smile_alien_monster),
      EmojiModel(
          name: 'smile_robot', code: 'u{1f916}', emoji: Emojis.smile_robot),
      EmojiModel(
          name: 'cat_grinning_cat',
          code: 'u{1f63a}',
          emoji: Emojis.cat_grinning_cat),
      EmojiModel(
          name: 'cat_grinning_cat_with_smiling_eyes',
          code: 'u{1f638}',
          emoji: Emojis.cat_grinning_cat_with_smiling_eyes),
      EmojiModel(
          name: 'cat_cat_with_tears_of_joy',
          code: 'u{1f639}',
          emoji: Emojis.cat_cat_with_tears_of_joy),
      EmojiModel(
          name: 'cat_smiling_cat_with_heart_eyes',
          code: 'u{1f63b}',
          emoji: Emojis.cat_smiling_cat_with_heart_eyes),
      EmojiModel(
          name: 'cat_cat_with_wry_smile',
          code: 'u{1f63c}',
          emoji: Emojis.cat_cat_with_wry_smile),
      EmojiModel(
          name: 'cat_kissing_cat',
          code: 'u{1f63d}',
          emoji: Emojis.cat_kissing_cat),
      EmojiModel(
          name: 'cat_weary_cat', code: 'u{1f640}', emoji: Emojis.cat_weary_cat),
      EmojiModel(
          name: 'cat_crying_cat',
          code: 'u{1f63f}',
          emoji: Emojis.cat_crying_cat),
      EmojiModel(
          name: 'cat_pouting_cat',
          code: 'u{1f63e}',
          emoji: Emojis.cat_pouting_cat),
      EmojiModel(
          name: 'monkey_see_no_evil_monkey',
          code: 'u{1f648}',
          emoji: Emojis.monkey_see_no_evil_monkey),
      EmojiModel(
          name: 'monkey_hear_no_evil_monkey',
          code: 'u{1f649}',
          emoji: Emojis.monkey_hear_no_evil_monkey),
      EmojiModel(
          name: 'monkey_speak_no_evil_monkey',
          code: 'u{1f64a}',
          emoji: Emojis.monkey_speak_no_evil_monkey),
      EmojiModel(
          name: 'emotion_kiss_mark',
          code: 'u{1f48b}',
          emoji: Emojis.emotion_kiss_mark),
      EmojiModel(
          name: 'emotion_love_letter',
          code: 'u{1f48c}',
          emoji: Emojis.emotion_love_letter),
      EmojiModel(
          name: 'emotion_heart_with_arrow',
          code: 'u{1f498}',
          emoji: Emojis.emotion_heart_with_arrow),
      EmojiModel(
          name: 'emotion_heart_with_ribbon',
          code: 'u{1f49d}',
          emoji: Emojis.emotion_heart_with_ribbon),
      EmojiModel(
          name: 'emotion_sparkling_heart',
          code: 'u{1f496}',
          emoji: Emojis.emotion_sparkling_heart),
      EmojiModel(
          name: 'emotion_growing_heart',
          code: 'u{1f497}',
          emoji: Emojis.emotion_growing_heart),
      EmojiModel(
          name: 'emotion_beating_heart',
          code: 'u{1f493}',
          emoji: Emojis.emotion_beating_heart),
      EmojiModel(
          name: 'emotion_revolving_hearts',
          code: 'u{1f49e}',
          emoji: Emojis.emotion_revolving_hearts),
      EmojiModel(
          name: 'emotion_two_hearts',
          code: 'u{1f495}',
          emoji: Emojis.emotion_two_hearts),
      EmojiModel(
          name: 'emotion_heart_decoration',
          code: 'u{1f49f}',
          emoji: Emojis.emotion_heart_decoration),
      EmojiModel(
          name: 'emotion_heart_exclamation',
          code: 'u{2763}',
          emoji: Emojis.emotion_heart_exclamation),
      EmojiModel(
          name: 'emotion_broken_heart',
          code: 'u{1f494}',
          emoji: Emojis.emotion_broken_heart),
      EmojiModel(
          name: 'emotion_red_heart',
          code: 'u{2764}',
          emoji: Emojis.emotion_red_heart),
      EmojiModel(
          name: 'emotion_orange_heart',
          code: 'u{1f9e1}',
          emoji: Emojis.emotion_orange_heart),
      EmojiModel(
          name: 'emotion_yellow_heart',
          code: 'u{1f49b}',
          emoji: Emojis.emotion_yellow_heart),
      EmojiModel(
          name: 'emotion_green_heart',
          code: 'u{1f49a}',
          emoji: Emojis.emotion_green_heart),
      EmojiModel(
          name: 'emotion_blue_heart',
          code: 'u{1f499}',
          emoji: Emojis.emotion_blue_heart),
      EmojiModel(
          name: 'emotion_purple_heart',
          code: 'u{1f49c}',
          emoji: Emojis.emotion_purple_heart),
      EmojiModel(
          name: 'emotion_brown_heart',
          code: 'u{1f90e}',
          emoji: Emojis.emotion_brown_heart),
      EmojiModel(
          name: 'emotion_black_heart',
          code: 'u{1f5a4}',
          emoji: Emojis.emotion_black_heart),
      EmojiModel(
          name: 'emotion_white_heart',
          code: 'u{1f90d}',
          emoji: Emojis.emotion_white_heart),
      EmojiModel(
          name: 'icon_hundred_points',
          code: 'u{1f4af}',
          emoji: Emojis.icon_hundred_points),
      EmojiModel(
          name: 'icon_anger_symbol',
          code: 'u{1f4a2}',
          emoji: Emojis.icon_anger_symbol),
      EmojiModel(
          name: 'icon_collision',
          code: 'u{1f4a5}',
          emoji: Emojis.icon_collision),
      EmojiModel(
          name: 'icon_dizzy', code: 'u{1f4ab}', emoji: Emojis.icon_dizzy),
      EmojiModel(
          name: 'icon_sweat_droplets',
          code: 'u{1f4a6}',
          emoji: Emojis.icon_sweat_droplets),
      EmojiModel(
          name: 'icon_dashing_away',
          code: 'u{1f4a8}',
          emoji: Emojis.icon_dashing_away),
      EmojiModel(name: 'icon_hole', code: 'u{1f573}', emoji: Emojis.icon_hole),
      EmojiModel(name: 'icon_bomb', code: 'u{1f4a3}', emoji: Emojis.icon_bomb),
      EmojiModel(
          name: 'icon_speech_balloon',
          code: 'u{1f4ac}',
          emoji: Emojis.icon_speech_balloon),
      EmojiModel(
          name: 'icon_eye_in_speech_bubble',
          code: 'u{fe0f}',
          emoji: Emojis.icon_eye_in_speech_bubble),
      EmojiModel(
          name: 'icon_left_speech_bubble',
          code: 'u{1f5e8}',
          emoji: Emojis.icon_left_speech_bubble),
      EmojiModel(
          name: 'icon_right_anger_bubble',
          code: 'u{1f5ef}',
          emoji: Emojis.icon_right_anger_bubble),
      EmojiModel(
          name: 'icon_thought_balloon',
          code: 'u{1f4ad}',
          emoji: Emojis.icon_thought_balloon),
      EmojiModel(name: 'icon_zzz', code: 'u{1f4a4}', emoji: Emojis.icon_zzz),
      EmojiModel(
          name: 'hand_waving_hand',
          code: 'u{1f44b}',
          emoji: Emojis.hand_waving_hand),
      EmojiModel(
          name: 'hand_raised_back_of_hand',
          code: 'u{1f91a}',
          emoji: Emojis.hand_raised_back_of_hand),
      EmojiModel(
          name: 'hand_hand_with_fingers_splayed',
          code: 'u{1f590}',
          emoji: Emojis.hand_hand_with_fingers_splayed),
      EmojiModel(
          name: 'hand_raised_hand',
          code: 'u{270b}',
          emoji: Emojis.hand_raised_hand),
      EmojiModel(
          name: 'hand_vulcan_salute',
          code: 'u{1f596}',
          emoji: Emojis.hand_vulcan_salute),
      EmojiModel(
          name: 'hand_ok_hand', code: 'u{1f44c}', emoji: Emojis.hand_ok_hand),
      EmojiModel(
          name: 'hand_pinched_fingers',
          code: 'u{1f90c}',
          emoji: Emojis.hand_pinched_fingers),
      EmojiModel(
          name: 'hand_pinching_hand',
          code: 'u{1f90f}',
          emoji: Emojis.hand_pinching_hand),
      EmojiModel(
          name: 'hand_victory_hand',
          code: 'u{270c}',
          emoji: Emojis.hand_victory_hand),
      EmojiModel(
          name: 'hand_crossed_fingers',
          code: 'u{1f91e}',
          emoji: Emojis.hand_crossed_fingers),
      EmojiModel(
          name: 'hand_love_you_gesture',
          code: 'u{1f91f}',
          emoji: Emojis.hand_love_you_gesture),
      EmojiModel(
          name: 'hand_sign_of_the_horns',
          code: 'u{1f918}',
          emoji: Emojis.hand_sign_of_the_horns),
      EmojiModel(
          name: 'hand_call_me_hand',
          code: 'u{1f919}',
          emoji: Emojis.hand_call_me_hand),
      EmojiModel(
          name: 'hand_backhand_index_pointing_left',
          code: 'u{1f448}',
          emoji: Emojis.hand_backhand_index_pointing_left),
      EmojiModel(
          name: 'hand_backhand_index_pointing_right',
          code: 'u{1f449}',
          emoji: Emojis.hand_backhand_index_pointing_right),
      EmojiModel(
          name: 'hand_backhand_index_pointing_up',
          code: 'u{1f446}',
          emoji: Emojis.hand_backhand_index_pointing_up),
      EmojiModel(
          name: 'hand_middle_finger',
          code: 'u{1f595}',
          emoji: Emojis.hand_middle_finger),
      EmojiModel(
          name: 'hand_backhand_index_pointing_down',
          code: 'u{1f447}',
          emoji: Emojis.hand_backhand_index_pointing_down),
      EmojiModel(
          name: 'hand_index_pointing_up',
          code: 'u{261d}',
          emoji: Emojis.hand_index_pointing_up),
      EmojiModel(
          name: 'hand_thumbs_up',
          code: 'u{1f44d}',
          emoji: Emojis.hand_thumbs_up),
      EmojiModel(
          name: 'hand_thumbs_down',
          code: 'u{1f44e}',
          emoji: Emojis.hand_thumbs_down),
      EmojiModel(
          name: 'hand_raised_fist',
          code: 'u{270a}',
          emoji: Emojis.hand_raised_fist),
      EmojiModel(
          name: 'hand_oncoming_fist',
          code: 'u{1f44a}',
          emoji: Emojis.hand_oncoming_fist),
      EmojiModel(
          name: 'hand_left_facing_fist',
          code: 'u{1f91b}',
          emoji: Emojis.hand_left_facing_fist),
      EmojiModel(
          name: 'hand_right_facing_fist',
          code: 'u{1f91c}',
          emoji: Emojis.hand_right_facing_fist),
      EmojiModel(
          name: 'hand_clapping_hands',
          code: 'u{1f44f}',
          emoji: Emojis.hand_clapping_hands),
      EmojiModel(
          name: 'hand_raising_hands',
          code: 'u{1f64c}',
          emoji: Emojis.hand_raising_hands),
      EmojiModel(
          name: 'hand_open_hands',
          code: 'u{1f450}',
          emoji: Emojis.hand_open_hands),
      EmojiModel(
          name: 'hand_palms_up_together',
          code: 'u{1f932}',
          emoji: Emojis.hand_palms_up_together),
      EmojiModel(
          name: 'hand_handshake',
          code: 'u{1f91d}',
          emoji: Emojis.hand_handshake),
      EmojiModel(
          name: 'hand_folded_hands',
          code: 'u{1f64f}',
          emoji: Emojis.hand_folded_hands),
      EmojiModel(
          name: 'hand_writing_hand',
          code: 'u{270d}',
          emoji: Emojis.hand_writing_hand),
      EmojiModel(
          name: 'hand_nail_polish',
          code: 'u{1f485}',
          emoji: Emojis.hand_nail_polish),
      EmojiModel(
          name: 'hand_selfie', code: 'u{1f933}', emoji: Emojis.hand_selfie),
      EmojiModel(
          name: 'body_flexed_biceps',
          code: 'u{1f4aa}',
          emoji: Emojis.body_flexed_biceps),
      EmojiModel(
          name: 'body_mechanical_arm',
          code: 'u{1f9be}',
          emoji: Emojis.body_mechanical_arm),
      EmojiModel(
          name: 'body_mechanical_leg',
          code: 'u{1f9bf}',
          emoji: Emojis.body_mechanical_leg),
      EmojiModel(name: 'body_leg', code: 'u{1f9b5}', emoji: Emojis.body_leg),
      EmojiModel(name: 'body_foot', code: 'u{1f9b6}', emoji: Emojis.body_foot),
      EmojiModel(name: 'body_ear', code: 'u{1f442}', emoji: Emojis.body_ear),
      EmojiModel(
          name: 'body_ear_with_hearing_aid',
          code: 'u{1f9bb}',
          emoji: Emojis.body_ear_with_hearing_aid),
      EmojiModel(name: 'body_nose', code: 'u{1f443}', emoji: Emojis.body_nose),
      EmojiModel(
          name: 'body_brain', code: 'u{1f9e0}', emoji: Emojis.body_brain),
      EmojiModel(
          name: 'body_anatomical_heart',
          code: 'u{1fac0}',
          emoji: Emojis.body_anatomical_heart),
      EmojiModel(
          name: 'body_lungs', code: 'u{1fac1}', emoji: Emojis.body_lungs),
      EmojiModel(
          name: 'body_tooth', code: 'u{1f9b7}', emoji: Emojis.body_tooth),
      EmojiModel(name: 'body_bone', code: 'u{1f9b4}', emoji: Emojis.body_bone),
      EmojiModel(name: 'body_eyes', code: 'u{1f440}', emoji: Emojis.body_eyes),
      EmojiModel(name: 'body_eye', code: 'u{1f441}', emoji: Emojis.body_eye),
      EmojiModel(
          name: 'body_tongue', code: 'u{1f445}', emoji: Emojis.body_tongue),
      EmojiModel(
          name: 'body_mouth', code: 'u{1f444}', emoji: Emojis.body_mouth),
      EmojiModel(
          name: 'person_baby', code: 'u{1f476}', emoji: Emojis.person_baby),
      EmojiModel(
          name: 'person_child', code: 'u{1f9d2}', emoji: Emojis.person_child),
      EmojiModel(
          name: 'person_boy', code: 'u{1f466}', emoji: Emojis.person_boy),
      EmojiModel(
          name: 'person_girl', code: 'u{1f467}', emoji: Emojis.person_girl),
      EmojiModel(
          name: 'person_person', code: 'u{1f9d1}', emoji: Emojis.person_person),
      EmojiModel(
          name: 'person_person_blond_hair',
          code: 'u{1f471}',
          emoji: Emojis.person_person_blond_hair),
      EmojiModel(
          name: 'person_man', code: 'u{1f468}', emoji: Emojis.person_man),
      EmojiModel(
          name: 'person_person_beard',
          code: 'u{1f9d4}',
          emoji: Emojis.person_person_beard),
      EmojiModel(
          name: 'person_man_red_hair',
          code: 'u{200d}',
          emoji: Emojis.person_man_red_hair),
      EmojiModel(
          name: 'person_man_curly_hair',
          code: 'u{200d}',
          emoji: Emojis.person_man_curly_hair),
      EmojiModel(
          name: 'person_man_white_hair',
          code: 'u{200d}',
          emoji: Emojis.person_man_white_hair),
      EmojiModel(
          name: 'person_man_bald',
          code: 'u{200d}',
          emoji: Emojis.person_man_bald),
      EmojiModel(
          name: 'person_woman', code: 'u{1f469}', emoji: Emojis.person_woman),
      EmojiModel(
          name: 'person_woman_red_hair',
          code: 'u{200d}',
          emoji: Emojis.person_woman_red_hair),
      EmojiModel(
          name: 'person_person_red_hair',
          code: 'u{200d}',
          emoji: Emojis.person_person_red_hair),
      EmojiModel(
          name: 'person_woman_curly_hair',
          code: 'u{200d}',
          emoji: Emojis.person_woman_curly_hair),
      EmojiModel(
          name: 'person_person_curly_hair',
          code: 'u{200d}',
          emoji: Emojis.person_person_curly_hair),
      EmojiModel(
          name: 'person_woman_white_hair',
          code: 'u{200d}',
          emoji: Emojis.person_woman_white_hair),
      EmojiModel(
          name: 'person_person_white_hair',
          code: 'u{200d}',
          emoji: Emojis.person_person_white_hair),
      EmojiModel(
          name: 'person_woman_bald',
          code: 'u{200d}',
          emoji: Emojis.person_woman_bald),
      EmojiModel(
          name: 'person_person_bald',
          code: 'u{200d}',
          emoji: Emojis.person_person_bald),
      EmojiModel(
          name: 'person_woman_blond_hair',
          code: 'u{fe0f}',
          emoji: Emojis.person_woman_blond_hair),
      EmojiModel(
          name: 'person_man_blond_hair',
          code: 'u{fe0f}',
          emoji: Emojis.person_man_blond_hair),
      EmojiModel(
          name: 'person_older_person',
          code: 'u{1f9d3}',
          emoji: Emojis.person_older_person),
      EmojiModel(
          name: 'person_old_man',
          code: 'u{1f474}',
          emoji: Emojis.person_old_man),
      EmojiModel(
          name: 'person_old_woman',
          code: 'u{1f475}',
          emoji: Emojis.person_old_woman),
      EmojiModel(
          name: 'person_gesture_person_frowning',
          code: 'u{1f64d}',
          emoji: Emojis.person_gesture_person_frowning),
      EmojiModel(
          name: 'person_gesture_man_frowning',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_frowning),
      EmojiModel(
          name: 'person_gesture_woman_frowning',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_frowning),
      EmojiModel(
          name: 'person_gesture_person_pouting',
          code: 'u{1f64e}',
          emoji: Emojis.person_gesture_person_pouting),
      EmojiModel(
          name: 'person_gesture_man_pouting',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_pouting),
      EmojiModel(
          name: 'person_gesture_woman_pouting',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_pouting),
      EmojiModel(
          name: 'person_gesture_person_gesturing_no',
          code: 'u{1f645}',
          emoji: Emojis.person_gesture_person_gesturing_no),
      EmojiModel(
          name: 'person_gesture_man_gesturing_no',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_gesturing_no),
      EmojiModel(
          name: 'person_gesture_woman_gesturing_no',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_gesturing_no),
      EmojiModel(
          name: 'person_gesture_person_gesturing_ok',
          code: 'u{1f646}',
          emoji: Emojis.person_gesture_person_gesturing_ok),
      EmojiModel(
          name: 'person_gesture_man_gesturing_ok',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_gesturing_ok),
      EmojiModel(
          name: 'person_gesture_woman_gesturing_ok',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_gesturing_ok),
      EmojiModel(
          name: 'person_gesture_person_tipping_hand',
          code: 'u{1f481}',
          emoji: Emojis.person_gesture_person_tipping_hand),
      EmojiModel(
          name: 'person_gesture_man_tipping_hand',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_tipping_hand),
      EmojiModel(
          name: 'person_gesture_woman_tipping_hand',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_tipping_hand),
      EmojiModel(
          name: 'person_gesture_person_raising_hand',
          code: 'u{1f64b}',
          emoji: Emojis.person_gesture_person_raising_hand),
      EmojiModel(
          name: 'person_gesture_man_raising_hand',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_raising_hand),
      EmojiModel(
          name: 'person_gesture_woman_raising_hand',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_raising_hand),
      EmojiModel(
          name: 'person_gesture_deaf_person',
          code: 'u{1f9cf}',
          emoji: Emojis.person_gesture_deaf_person),
      EmojiModel(
          name: 'person_gesture_deaf_man',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_deaf_man),
      EmojiModel(
          name: 'person_gesture_deaf_woman',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_deaf_woman),
      EmojiModel(
          name: 'person_gesture_person_bowing',
          code: 'u{1f647}',
          emoji: Emojis.person_gesture_person_bowing),
      EmojiModel(
          name: 'person_gesture_man_bowing',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_bowing),
      EmojiModel(
          name: 'person_gesture_woman_bowing',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_bowing),
      EmojiModel(
          name: 'person_gesture_person_facepalming',
          code: 'u{1f926}',
          emoji: Emojis.person_gesture_person_facepalming),
      EmojiModel(
          name: 'person_gesture_man_facepalming',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_facepalming),
      EmojiModel(
          name: 'person_gesture_woman_facepalming',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_facepalming),
      EmojiModel(
          name: 'person_gesture_person_shrugging',
          code: 'u{1f937}',
          emoji: Emojis.person_gesture_person_shrugging),
      EmojiModel(
          name: 'person_gesture_man_shrugging',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_man_shrugging),
      EmojiModel(
          name: 'person_gesture_woman_shrugging',
          code: 'u{fe0f}',
          emoji: Emojis.person_gesture_woman_shrugging),
      EmojiModel(
          name: 'person_role_health_worker',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_health_worker),
      EmojiModel(
          name: 'person_role_man_health_worker',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_health_worker),
      EmojiModel(
          name: 'person_role_woman_health_worker',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_health_worker),
      EmojiModel(
          name: 'person_role_student',
          code: 'u{200d}',
          emoji: Emojis.person_role_student),
      EmojiModel(
          name: 'person_role_man_student',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_student),
      EmojiModel(
          name: 'person_role_woman_student',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_student),
      EmojiModel(
          name: 'person_role_teacher',
          code: 'u{200d}',
          emoji: Emojis.person_role_teacher),
      EmojiModel(
          name: 'person_role_man_teacher',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_teacher),
      EmojiModel(
          name: 'person_role_woman_teacher',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_teacher),
      EmojiModel(
          name: 'person_role_judge',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_judge),
      EmojiModel(
          name: 'person_role_man_judge',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_judge),
      EmojiModel(
          name: 'person_role_woman_judge',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_judge),
      EmojiModel(
          name: 'person_role_farmer',
          code: 'u{200d}',
          emoji: Emojis.person_role_farmer),
      EmojiModel(
          name: 'person_role_man_farmer',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_farmer),
      EmojiModel(
          name: 'person_role_woman_farmer',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_farmer),
      EmojiModel(
          name: 'person_role_cook',
          code: 'u{200d}',
          emoji: Emojis.person_role_cook),
      EmojiModel(
          name: 'person_role_man_cook',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_cook),
      EmojiModel(
          name: 'person_role_woman_cook',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_cook),
      EmojiModel(
          name: 'person_role_mechanic',
          code: 'u{200d}',
          emoji: Emojis.person_role_mechanic),
      EmojiModel(
          name: 'person_role_man_mechanic',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_mechanic),
      EmojiModel(
          name: 'person_role_woman_mechanic',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_mechanic),
      EmojiModel(
          name: 'person_role_factory_worker',
          code: 'u{200d}',
          emoji: Emojis.person_role_factory_worker),
      EmojiModel(
          name: 'person_role_man_factory_worker',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_factory_worker),
      EmojiModel(
          name: 'person_role_woman_factory_worker',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_factory_worker),
      EmojiModel(
          name: 'person_role_office_worker',
          code: 'u{200d}',
          emoji: Emojis.person_role_office_worker),
      EmojiModel(
          name: 'person_role_man_office_worker',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_office_worker),
      EmojiModel(
          name: 'person_role_woman_office_worker',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_office_worker),
      EmojiModel(
          name: 'person_role_scientist',
          code: 'u{200d}',
          emoji: Emojis.person_role_scientist),
      EmojiModel(
          name: 'person_role_man_scientist',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_scientist),
      EmojiModel(
          name: 'person_role_woman_scientist',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_scientist),
      EmojiModel(
          name: 'person_role_technologist',
          code: 'u{200d}',
          emoji: Emojis.person_role_technologist),
      EmojiModel(
          name: 'person_role_man_technologist',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_technologist),
      EmojiModel(
          name: 'person_role_woman_technologist',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_technologist),
      EmojiModel(
          name: 'person_role_singer',
          code: 'u{200d}',
          emoji: Emojis.person_role_singer),
      EmojiModel(
          name: 'person_role_man_singer',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_singer),
      EmojiModel(
          name: 'person_role_woman_singer',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_singer),
      EmojiModel(
          name: 'person_role_artist',
          code: 'u{200d}',
          emoji: Emojis.person_role_artist),
      EmojiModel(
          name: 'person_role_man_artist',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_artist),
      EmojiModel(
          name: 'person_role_woman_artist',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_artist),
      EmojiModel(
          name: 'person_role_pilot',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_pilot),
      EmojiModel(
          name: 'person_role_man_pilot',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_pilot),
      EmojiModel(
          name: 'person_role_woman_pilot',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_pilot),
      EmojiModel(
          name: 'person_role_astronaut',
          code: 'u{200d}',
          emoji: Emojis.person_role_astronaut),
      EmojiModel(
          name: 'person_role_man_astronaut',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_astronaut),
      EmojiModel(
          name: 'person_role_woman_astronaut',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_astronaut),
      EmojiModel(
          name: 'person_role_firefighter',
          code: 'u{200d}',
          emoji: Emojis.person_role_firefighter),
      EmojiModel(
          name: 'person_role_man_firefighter',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_firefighter),
      EmojiModel(
          name: 'person_role_woman_firefighter',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_firefighter),
      EmojiModel(
          name: 'person_role_police_officer',
          code: 'u{1f46e}',
          emoji: Emojis.person_role_police_officer),
      EmojiModel(
          name: 'person_role_man_police_officer',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_police_officer),
      EmojiModel(
          name: 'person_role_woman_police_officer',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_police_officer),
      EmojiModel(
          name: 'person_role_detective',
          code: 'u{1f575}',
          emoji: Emojis.person_role_detective),
      EmojiModel(
          name: 'person_role_man_detective',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_detective),
      EmojiModel(
          name: 'person_role_woman_detective',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_detective),
      EmojiModel(
          name: 'person_role_guard',
          code: 'u{1f482}',
          emoji: Emojis.person_role_guard),
      EmojiModel(
          name: 'person_role_man_guard',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_guard),
      EmojiModel(
          name: 'person_role_woman_guard',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_guard),
      EmojiModel(
          name: 'person_role_ninja',
          code: 'u{1f977}',
          emoji: Emojis.person_role_ninja),
      EmojiModel(
          name: 'person_role_construction_worker',
          code: 'u{1f477}',
          emoji: Emojis.person_role_construction_worker),
      EmojiModel(
          name: 'person_role_man_construction_worker',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_construction_worker),
      EmojiModel(
          name: 'person_role_woman_construction_worker',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_construction_worker),
      EmojiModel(
          name: 'person_role_prince',
          code: 'u{1f934}',
          emoji: Emojis.person_role_prince),
      EmojiModel(
          name: 'person_role_princess',
          code: 'u{1f478}',
          emoji: Emojis.person_role_princess),
      EmojiModel(
          name: 'person_role_person_wearing_turban',
          code: 'u{1f473}',
          emoji: Emojis.person_role_person_wearing_turban),
      EmojiModel(
          name: 'person_role_man_wearing_turban',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_wearing_turban),
      EmojiModel(
          name: 'person_role_woman_wearing_turban',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_wearing_turban),
      EmojiModel(
          name: 'person_role_person_with_skullcap',
          code: 'u{1f472}',
          emoji: Emojis.person_role_person_with_skullcap),
      EmojiModel(
          name: 'person_role_woman_with_headscarf',
          code: 'u{1f9d5}',
          emoji: Emojis.person_role_woman_with_headscarf),
      EmojiModel(
          name: 'person_role_person_in_tuxedo',
          code: 'u{1f935}',
          emoji: Emojis.person_role_person_in_tuxedo),
      EmojiModel(
          name: 'person_role_man_in_tuxedo',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_in_tuxedo),
      EmojiModel(
          name: 'person_role_woman_in_tuxedo',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_in_tuxedo),
      EmojiModel(
          name: 'person_role_person_with_veil',
          code: 'u{1f470}',
          emoji: Emojis.person_role_person_with_veil),
      EmojiModel(
          name: 'person_role_man_with_veil',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_man_with_veil),
      EmojiModel(
          name: 'person_role_woman_with_veil',
          code: 'u{fe0f}',
          emoji: Emojis.person_role_woman_with_veil),
      EmojiModel(
          name: 'person_role_pregnant_woman',
          code: 'u{1f930}',
          emoji: Emojis.person_role_pregnant_woman),
      EmojiModel(
          name: 'person_role_breast_feeding',
          code: 'u{1f931}',
          emoji: Emojis.person_role_breast_feeding),
      EmojiModel(
          name: 'person_role_woman_feeding_baby',
          code: 'u{200d}',
          emoji: Emojis.person_role_woman_feeding_baby),
      EmojiModel(
          name: 'person_role_man_feeding_baby',
          code: 'u{200d}',
          emoji: Emojis.person_role_man_feeding_baby),
      EmojiModel(
          name: 'person_role_person_feeding_baby',
          code: 'u{200d}',
          emoji: Emojis.person_role_person_feeding_baby),
      EmojiModel(
          name: 'person_fantasy_baby_angel',
          code: 'u{1f47c}',
          emoji: Emojis.person_fantasy_baby_angel),
      EmojiModel(
          name: 'person_fantasy_person_fantasy_santa_claus',
          code: 'u{1f385}',
          emoji: Emojis.person_fantasy_person_fantasy_santa_claus),
      EmojiModel(
          name: 'person_fantasy_person_fantasy_mrs_claus',
          code: 'u{1f936}',
          emoji: Emojis.person_fantasy_person_fantasy_mrs_claus),
      EmojiModel(
          name: 'person_fantasy_person_fantasy_mx_claus',
          code: 'u{200d}',
          emoji: Emojis.person_fantasy_person_fantasy_mx_claus),
      EmojiModel(
          name: 'person_fantasy_superhero',
          code: 'u{1f9b8}',
          emoji: Emojis.person_fantasy_superhero),
      EmojiModel(
          name: 'person_fantasy_man_superhero',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_superhero),
      EmojiModel(
          name: 'person_fantasy_woman_superhero',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_superhero),
      EmojiModel(
          name: 'person_fantasy_supervillain',
          code: 'u{1f9b9}',
          emoji: Emojis.person_fantasy_supervillain),
      EmojiModel(
          name: 'person_fantasy_man_supervillain',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_supervillain),
      EmojiModel(
          name: 'person_fantasy_woman_supervillain',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_supervillain),
      EmojiModel(
          name: 'person_fantasy_mage',
          code: 'u{1f9d9}',
          emoji: Emojis.person_fantasy_mage),
      EmojiModel(
          name: 'person_fantasy_man_mage',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_mage),
      EmojiModel(
          name: 'person_fantasy_woman_mage',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_mage),
      EmojiModel(
          name: 'person_fantasy_fairy',
          code: 'u{1f9da}',
          emoji: Emojis.person_fantasy_fairy),
      EmojiModel(
          name: 'person_fantasy_man_fairy',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_fairy),
      EmojiModel(
          name: 'person_fantasy_woman_fairy',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_fairy),
      EmojiModel(
          name: 'person_fantasy_vampire',
          code: 'u{1f9db}',
          emoji: Emojis.person_fantasy_vampire),
      EmojiModel(
          name: 'person_fantasy_man_vampire',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_vampire),
      EmojiModel(
          name: 'person_fantasy_woman_vampire',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_vampire),
      EmojiModel(
          name: 'person_fantasy_merperson',
          code: 'u{1f9dc}',
          emoji: Emojis.person_fantasy_merperson),
      EmojiModel(
          name: 'person_fantasy_merman',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_merman),
      EmojiModel(
          name: 'person_fantasy_mermaid',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_mermaid),
      EmojiModel(
          name: 'person_fantasy_elf',
          code: 'u{1f9dd}',
          emoji: Emojis.person_fantasy_elf),
      EmojiModel(
          name: 'person_fantasy_man_elf',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_elf),
      EmojiModel(
          name: 'person_fantasy_woman_elf',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_elf),
      EmojiModel(
          name: 'person_fantasy_genie',
          code: 'u{1f9de}',
          emoji: Emojis.person_fantasy_genie),
      EmojiModel(
          name: 'person_fantasy_man_genie',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_genie),
      EmojiModel(
          name: 'person_fantasy_woman_genie',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_genie),
      EmojiModel(
          name: 'person_fantasy_zombie',
          code: 'u{1f9df}',
          emoji: Emojis.person_fantasy_zombie),
      EmojiModel(
          name: 'person_fantasy_man_zombie',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_man_zombie),
      EmojiModel(
          name: 'person_fantasy_woman_zombie',
          code: 'u{fe0f}',
          emoji: Emojis.person_fantasy_woman_zombie),
      EmojiModel(
          name: 'person_activity_person_getting_massage',
          code: 'u{1f486}',
          emoji: Emojis.person_activity_person_getting_massage),
      EmojiModel(
          name: 'person_activity_man_getting_massage',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_getting_massage),
      EmojiModel(
          name: 'person_activity_woman_getting_massage',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_getting_massage),
      EmojiModel(
          name: 'person_activity_person_getting_haircut',
          code: 'u{1f487}',
          emoji: Emojis.person_activity_person_getting_haircut),
      EmojiModel(
          name: 'person_activity_man_getting_haircut',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_getting_haircut),
      EmojiModel(
          name: 'person_activity_woman_getting_haircut',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_getting_haircut),
      EmojiModel(
          name: 'person_activity_person_walking',
          code: 'u{1f6b6}',
          emoji: Emojis.person_activity_person_walking),
      EmojiModel(
          name: 'person_activity_man_walking',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_walking),
      EmojiModel(
          name: 'person_activity_woman_walking',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_walking),
      EmojiModel(
          name: 'person_activity_person_standing',
          code: 'u{1f9cd}',
          emoji: Emojis.person_activity_person_standing),
      EmojiModel(
          name: 'person_activity_man_standing',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_standing),
      EmojiModel(
          name: 'person_activity_woman_standing',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_standing),
      EmojiModel(
          name: 'person_activity_person_kneeling',
          code: 'u{1f9ce}',
          emoji: Emojis.person_activity_person_kneeling),
      EmojiModel(
          name: 'person_activity_man_kneeling',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_kneeling),
      EmojiModel(
          name: 'person_activity_woman_kneeling',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_kneeling),
      EmojiModel(
          name: 'person_activity_person_with_white_cane',
          code: 'u{200d}',
          emoji: Emojis.person_activity_person_with_white_cane),
      EmojiModel(
          name: 'person_activity_man_with_white_cane',
          code: 'u{200d}',
          emoji: Emojis.person_activity_man_with_white_cane),
      EmojiModel(
          name: 'person_activity_woman_with_white_cane',
          code: 'u{200d}',
          emoji: Emojis.person_activity_woman_with_white_cane),
      EmojiModel(
          name: 'person_activity_person_in_motorized_wheelchair',
          code: 'u{200d}',
          emoji: Emojis.person_activity_person_in_motorized_wheelchair),
      EmojiModel(
          name: 'person_activity_man_in_motorized_wheelchair',
          code: 'u{200d}',
          emoji: Emojis.person_activity_man_in_motorized_wheelchair),
      EmojiModel(
          name: 'person_activity_woman_in_motorized_wheelchair',
          code: 'u{200d}',
          emoji: Emojis.person_activity_woman_in_motorized_wheelchair),
      EmojiModel(
          name: 'person_activity_person_in_manual_wheelchair',
          code: 'u{200d}',
          emoji: Emojis.person_activity_person_in_manual_wheelchair),
      EmojiModel(
          name: 'person_activity_man_in_manual_wheelchair',
          code: 'u{200d}',
          emoji: Emojis.person_activity_man_in_manual_wheelchair),
      EmojiModel(
          name: 'person_activity_woman_in_manual_wheelchair',
          code: 'u{200d}',
          emoji: Emojis.person_activity_woman_in_manual_wheelchair),
      EmojiModel(
          name: 'person_activity_person_running',
          code: 'u{1f3c3}',
          emoji: Emojis.person_activity_person_running),
      EmojiModel(
          name: 'person_activity_man_running',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_running),
      EmojiModel(
          name: 'person_activity_woman_running',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_running),
      EmojiModel(
          name: 'person_activity_woman_dancing',
          code: 'u{1f483}',
          emoji: Emojis.person_activity_woman_dancing),
      EmojiModel(
          name: 'person_activity_man_dancing',
          code: 'u{1f57a}',
          emoji: Emojis.person_activity_man_dancing),
      EmojiModel(
          name: 'person_activity_person_in_suit_levitating',
          code: 'u{1f574}',
          emoji: Emojis.person_activity_person_in_suit_levitating),
      EmojiModel(
          name: 'person_activity_people_with_bunny_ears',
          code: 'u{1f46f}',
          emoji: Emojis.person_activity_people_with_bunny_ears),
      EmojiModel(
          name: 'person_activity_men_with_bunny_ears',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_men_with_bunny_ears),
      EmojiModel(
          name: 'person_activity_women_with_bunny_ears',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_women_with_bunny_ears),
      EmojiModel(
          name: 'person_activity_person_in_steamy_room',
          code: 'u{1f9d6}',
          emoji: Emojis.person_activity_person_in_steamy_room),
      EmojiModel(
          name: 'person_activity_man_in_steamy_room',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_in_steamy_room),
      EmojiModel(
          name: 'person_activity_woman_in_steamy_room',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_in_steamy_room),
      EmojiModel(
          name: 'person_activity_person_climbing',
          code: 'u{1f9d7}',
          emoji: Emojis.person_activity_person_climbing),
      EmojiModel(
          name: 'person_activity_man_climbing',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_man_climbing),
      EmojiModel(
          name: 'person_activity_woman_climbing',
          code: 'u{fe0f}',
          emoji: Emojis.person_activity_woman_climbing),
      EmojiModel(
          name: 'person_sport_person_fencing',
          code: 'u{1f93a}',
          emoji: Emojis.person_sport_person_fencing),
      EmojiModel(
          name: 'person_sport_horse_racing',
          code: 'u{1f3c7}',
          emoji: Emojis.person_sport_horse_racing),
      EmojiModel(
          name: 'person_sport_skier',
          code: 'u{26f7}',
          emoji: Emojis.person_sport_skier),
      EmojiModel(
          name: 'person_sport_snowboarder',
          code: 'u{1f3c2}',
          emoji: Emojis.person_sport_snowboarder),
      EmojiModel(
          name: 'person_sport_person_golfing',
          code: 'u{1f3cc}',
          emoji: Emojis.person_sport_person_golfing),
      EmojiModel(
          name: 'person_sport_man_golfing',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_golfing),
      EmojiModel(
          name: 'person_sport_woman_golfing',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_golfing),
      EmojiModel(
          name: 'person_sport_person_surfing',
          code: 'u{1f3c4}',
          emoji: Emojis.person_sport_person_surfing),
      EmojiModel(
          name: 'person_sport_man_surfing',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_surfing),
      EmojiModel(
          name: 'person_sport_woman_surfing',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_surfing),
      EmojiModel(
          name: 'person_sport_person_rowing_boat',
          code: 'u{1f6a3}',
          emoji: Emojis.person_sport_person_rowing_boat),
      EmojiModel(
          name: 'person_sport_man_rowing_boat',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_rowing_boat),
      EmojiModel(
          name: 'person_sport_woman_rowing_boat',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_rowing_boat),
      EmojiModel(
          name: 'person_sport_person_swimming',
          code: 'u{1f3ca}',
          emoji: Emojis.person_sport_person_swimming),
      EmojiModel(
          name: 'person_sport_man_swimming',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_swimming),
      EmojiModel(
          name: 'person_sport_woman_swimming',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_swimming),
      EmojiModel(
          name: 'person_sport_person_bouncing_ball',
          code: 'u{26f9}',
          emoji: Emojis.person_sport_person_bouncing_ball),
      EmojiModel(
          name: 'person_sport_man_bouncing_ball',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_bouncing_ball),
      EmojiModel(
          name: 'person_sport_woman_bouncing_ball',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_bouncing_ball),
      EmojiModel(
          name: 'person_sport_person_lifting_weights',
          code: 'u{1f3cb}',
          emoji: Emojis.person_sport_person_lifting_weights),
      EmojiModel(
          name: 'person_sport_man_lifting_weights',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_lifting_weights),
      EmojiModel(
          name: 'person_sport_woman_lifting_weights',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_lifting_weights),
      EmojiModel(
          name: 'person_sport_person_biking',
          code: 'u{1f6b4}',
          emoji: Emojis.person_sport_person_biking),
      EmojiModel(
          name: 'person_sport_man_biking',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_biking),
      EmojiModel(
          name: 'person_sport_woman_biking',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_biking),
      EmojiModel(
          name: 'person_sport_person_mountain_biking',
          code: 'u{1f6b5}',
          emoji: Emojis.person_sport_person_mountain_biking),
      EmojiModel(
          name: 'person_sport_man_mountain_biking',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_mountain_biking),
      EmojiModel(
          name: 'person_sport_woman_mountain_biking',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_mountain_biking),
      EmojiModel(
          name: 'person_sport_person_cartwheeling',
          code: 'u{1f938}',
          emoji: Emojis.person_sport_person_cartwheeling),
      EmojiModel(
          name: 'person_sport_man_cartwheeling',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_cartwheeling),
      EmojiModel(
          name: 'person_sport_woman_cartwheeling',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_cartwheeling),
      EmojiModel(
          name: 'person_sport_people_wrestling',
          code: 'u{1f93c}',
          emoji: Emojis.person_sport_people_wrestling),
      EmojiModel(
          name: 'person_sport_men_wrestling',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_men_wrestling),
      EmojiModel(
          name: 'person_sport_women_wrestling',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_women_wrestling),
      EmojiModel(
          name: 'person_sport_person_playing_water_polo',
          code: 'u{1f93d}',
          emoji: Emojis.person_sport_person_playing_water_polo),
      EmojiModel(
          name: 'person_sport_man_playing_water_polo',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_playing_water_polo),
      EmojiModel(
          name: 'person_sport_woman_playing_water_polo',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_playing_water_polo),
      EmojiModel(
          name: 'person_sport_person_playing_handball',
          code: 'u{1f93e}',
          emoji: Emojis.person_sport_person_playing_handball),
      EmojiModel(
          name: 'person_sport_man_playing_handball',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_playing_handball),
      EmojiModel(
          name: 'person_sport_woman_playing_handball',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_playing_handball),
      EmojiModel(
          name: 'person_sport_person_juggling',
          code: 'u{1f939}',
          emoji: Emojis.person_sport_person_juggling),
      EmojiModel(
          name: 'person_sport_man_juggling',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_man_juggling),
      EmojiModel(
          name: 'person_sport_woman_juggling',
          code: 'u{fe0f}',
          emoji: Emojis.person_sport_woman_juggling),
      EmojiModel(
          name: 'person_resting_person_in_lotus_position',
          code: 'u{1f9d8}',
          emoji: Emojis.person_resting_person_in_lotus_position),
      EmojiModel(
          name: 'person_resting_man_in_lotus_position',
          code: 'u{fe0f}',
          emoji: Emojis.person_resting_man_in_lotus_position),
      EmojiModel(
          name: 'person_resting_woman_in_lotus_position',
          code: 'u{fe0f}',
          emoji: Emojis.person_resting_woman_in_lotus_position),
      EmojiModel(
          name: 'person_resting_person_taking_bath',
          code: 'u{1f6c0}',
          emoji: Emojis.person_resting_person_taking_bath),
      EmojiModel(
          name: 'person_resting_person_in_bed',
          code: 'u{1f6cc}',
          emoji: Emojis.person_resting_person_in_bed),
      EmojiModel(
          name: 'family_women_holding_hands',
          code: 'u{1f46d}',
          emoji: Emojis.family_women_holding_hands),
      EmojiModel(
          name: 'family_woman_and_man_holding_hands',
          code: 'u{1f46b}',
          emoji: Emojis.family_woman_and_man_holding_hands),
      EmojiModel(
          name: 'family_men_holding_hands',
          code: 'u{1f46c}',
          emoji: Emojis.family_men_holding_hands),
      EmojiModel(
          name: 'family_kiss', code: 'u{1f48f}', emoji: Emojis.family_kiss),
      EmojiModel(
          name: 'family_couple_with_heart_woman',
          code: 'u{1f46a}',
          emoji: Emojis.family_couple_with_heart_woman),
      EmojiModel(
          name: 'family_family_man',
          code: 'u{200d}',
          emoji: Emojis.family_family_man),
      EmojiModel(
          name: 'family_family_woman',
          code: 'u{200d}',
          emoji: Emojis.family_family_woman),
      EmojiModel(
          name: 'person_symbol_speaking_head',
          code: 'u{1f5e3}',
          emoji: Emojis.person_symbol_speaking_head),
      EmojiModel(
          name: 'person_symbol_bust_in_silhouette',
          code: 'u{1f464}',
          emoji: Emojis.person_symbol_bust_in_silhouette),
      EmojiModel(
          name: 'person_symbol_busts_in_silhouette',
          code: 'u{1f465}',
          emoji: Emojis.person_symbol_busts_in_silhouette),
      EmojiModel(
          name: 'person_symbol_people_hugging',
          code: 'u{1fac2}',
          emoji: Emojis.person_symbol_people_hugging),
      EmojiModel(
          name: 'person_symbol_footprints',
          code: 'u{1f463}',
          emoji: Emojis.person_symbol_footprints),
      EmojiModel(
          name: 'hair_style_red_hair',
          code: 'u{1f9b0}',
          emoji: Emojis.hair_style_red_hair),
      EmojiModel(
          name: 'hair_style_curly_hair',
          code: 'u{1f9b1}',
          emoji: Emojis.hair_style_curly_hair),
      EmojiModel(
          name: 'hair_style_white_hair',
          code: 'u{1f9b3}',
          emoji: Emojis.hair_style_white_hair),
      EmojiModel(
          name: 'hair_style_bald',
          code: 'u{1f9b2}',
          emoji: Emojis.hair_style_bald),
      EmojiModel(
          name: 'animals_monkey_face',
          code: 'u{1f435}',
          emoji: Emojis.animals_monkey_face),
      EmojiModel(
          name: 'animals_monkey',
          code: 'u{1f412}',
          emoji: Emojis.animals_monkey),
      EmojiModel(
          name: 'animals_gorilla',
          code: 'u{1f98d}',
          emoji: Emojis.animals_gorilla),
      EmojiModel(
          name: 'animals_orangutan',
          code: 'u{1f9a7}',
          emoji: Emojis.animals_orangutan),
      EmojiModel(
          name: 'animals_dog_face',
          code: 'u{1f436}',
          emoji: Emojis.animals_dog_face),
      EmojiModel(
          name: 'animals_dog', code: 'u{1f415}', emoji: Emojis.animals_dog),
      EmojiModel(
          name: 'animals_guide_dog',
          code: 'u{1f9ae}',
          emoji: Emojis.animals_guide_dog),
      EmojiModel(
          name: 'animals_service_dog',
          code: 'u{200d}',
          emoji: Emojis.animals_service_dog),
      EmojiModel(
          name: 'animals_poodle',
          code: 'u{1f429}',
          emoji: Emojis.animals_poodle),
      EmojiModel(
          name: 'animals_wolf', code: 'u{1f43a}', emoji: Emojis.animals_wolf),
      EmojiModel(
          name: 'animals_fox', code: 'u{1f98a}', emoji: Emojis.animals_fox),
      EmojiModel(
          name: 'animals_raccoon',
          code: 'u{1f99d}',
          emoji: Emojis.animals_raccoon),
      EmojiModel(
          name: 'animals_cat_face',
          code: 'u{1f431}',
          emoji: Emojis.animals_cat_face),
      EmojiModel(
          name: 'animals_cat', code: 'u{1f408}', emoji: Emojis.animals_cat),
      EmojiModel(
          name: 'animals_black_cat',
          code: 'u{200d}',
          emoji: Emojis.animals_black_cat),
      EmojiModel(
          name: 'animals_lion', code: 'u{1f981}', emoji: Emojis.animals_lion),
      EmojiModel(
          name: 'animals_tiger_face',
          code: 'u{1f42f}',
          emoji: Emojis.animals_tiger_face),
      EmojiModel(
          name: 'animals_tiger', code: 'u{1f405}', emoji: Emojis.animals_tiger),
      EmojiModel(
          name: 'animals_leopard',
          code: 'u{1f406}',
          emoji: Emojis.animals_leopard),
      EmojiModel(
          name: 'animals_horse_face',
          code: 'u{1f434}',
          emoji: Emojis.animals_horse_face),
      EmojiModel(
          name: 'animals_horse', code: 'u{1f40e}', emoji: Emojis.animals_horse),
      EmojiModel(
          name: 'animals_unicorn',
          code: 'u{1f984}',
          emoji: Emojis.animals_unicorn),
      EmojiModel(
          name: 'animals_zebra', code: 'u{1f993}', emoji: Emojis.animals_zebra),
      EmojiModel(
          name: 'animals_deer', code: 'u{1f98c}', emoji: Emojis.animals_deer),
      EmojiModel(
          name: 'animals_bison', code: 'u{1f9ac}', emoji: Emojis.animals_bison),
      EmojiModel(
          name: 'animals_cow_face',
          code: 'u{1f42e}',
          emoji: Emojis.animals_cow_face),
      EmojiModel(
          name: 'animals_ox', code: 'u{1f402}', emoji: Emojis.animals_ox),
      EmojiModel(
          name: 'animals_water_buffalo',
          code: 'u{1f403}',
          emoji: Emojis.animals_water_buffalo),
      EmojiModel(
          name: 'animals_cow', code: 'u{1f404}', emoji: Emojis.animals_cow),
      EmojiModel(
          name: 'animals_pig_face',
          code: 'u{1f437}',
          emoji: Emojis.animals_pig_face),
      EmojiModel(
          name: 'animals_pig', code: 'u{1f416}', emoji: Emojis.animals_pig),
      EmojiModel(
          name: 'animals_boar', code: 'u{1f417}', emoji: Emojis.animals_boar),
      EmojiModel(
          name: 'animals_pig_nose',
          code: 'u{1f43d}',
          emoji: Emojis.animals_pig_nose),
      EmojiModel(
          name: 'animals_ram', code: 'u{1f40f}', emoji: Emojis.animals_ram),
      EmojiModel(
          name: 'animals_ewe', code: 'u{1f411}', emoji: Emojis.animals_ewe),
      EmojiModel(
          name: 'animals_goat', code: 'u{1f410}', emoji: Emojis.animals_goat),
      EmojiModel(
          name: 'animals_camel', code: 'u{1f42a}', emoji: Emojis.animals_camel),
      EmojiModel(
          name: 'animals_two_hump_camel',
          code: 'u{1f42b}',
          emoji: Emojis.animals_two_hump_camel),
      EmojiModel(
          name: 'animals_llama', code: 'u{1f999}', emoji: Emojis.animals_llama),
      EmojiModel(
          name: 'animals_giraffe',
          code: 'u{1f992}',
          emoji: Emojis.animals_giraffe),
      EmojiModel(
          name: 'animals_elephant',
          code: 'u{1f418}',
          emoji: Emojis.animals_elephant),
      EmojiModel(
          name: 'animals_mammoth',
          code: 'u{1f9a3}',
          emoji: Emojis.animals_mammoth),
      EmojiModel(
          name: 'animals_rhinoceros',
          code: 'u{1f98f}',
          emoji: Emojis.animals_rhinoceros),
      EmojiModel(
          name: 'animals_hippopotamus',
          code: 'u{1f99b}',
          emoji: Emojis.animals_hippopotamus),
      EmojiModel(
          name: 'animals_mouse_face',
          code: 'u{1f42d}',
          emoji: Emojis.animals_mouse_face),
      EmojiModel(
          name: 'animals_mouse', code: 'u{1f401}', emoji: Emojis.animals_mouse),
      EmojiModel(
          name: 'animals_rat', code: 'u{1f400}', emoji: Emojis.animals_rat),
      EmojiModel(
          name: 'animals_hamster',
          code: 'u{1f439}',
          emoji: Emojis.animals_hamster),
      EmojiModel(
          name: 'animals_rabbit_face',
          code: 'u{1f430}',
          emoji: Emojis.animals_rabbit_face),
      EmojiModel(
          name: 'animals_rabbit',
          code: 'u{1f407}',
          emoji: Emojis.animals_rabbit),
      EmojiModel(
          name: 'animals_chipmunk',
          code: 'u{1f43f}',
          emoji: Emojis.animals_chipmunk),
      EmojiModel(
          name: 'animals_beaver',
          code: 'u{1f9ab}',
          emoji: Emojis.animals_beaver),
      EmojiModel(
          name: 'animals_hedgehog',
          code: 'u{1f994}',
          emoji: Emojis.animals_hedgehog),
      EmojiModel(
          name: 'animals_bat', code: 'u{1f987}', emoji: Emojis.animals_bat),
      EmojiModel(
          name: 'animals_bear', code: 'u{1f43b}', emoji: Emojis.animals_bear),
      EmojiModel(
          name: 'animals_polar_bear',
          code: 'u{fe0f}',
          emoji: Emojis.animals_polar_bear),
      EmojiModel(
          name: 'animals_koala', code: 'u{1f428}', emoji: Emojis.animals_koala),
      EmojiModel(
          name: 'animals_panda', code: 'u{1f43c}', emoji: Emojis.animals_panda),
      EmojiModel(
          name: 'animals_sloth', code: 'u{1f9a5}', emoji: Emojis.animals_sloth),
      EmojiModel(
          name: 'animals_otter', code: 'u{1f9a6}', emoji: Emojis.animals_otter),
      EmojiModel(
          name: 'animals_skunk', code: 'u{1f9a8}', emoji: Emojis.animals_skunk),
      EmojiModel(
          name: 'animals_kangaroo',
          code: 'u{1f998}',
          emoji: Emojis.animals_kangaroo),
      EmojiModel(
          name: 'animals_badger',
          code: 'u{1f9a1}',
          emoji: Emojis.animals_badger),
      EmojiModel(
          name: 'animals_paw_prints',
          code: 'u{1f43e}',
          emoji: Emojis.animals_paw_prints),
      EmojiModel(
          name: 'animals_turkey',
          code: 'u{1f983}',
          emoji: Emojis.animals_turkey),
      EmojiModel(
          name: 'animals_chicken',
          code: 'u{1f414}',
          emoji: Emojis.animals_chicken),
      EmojiModel(
          name: 'animals_rooster',
          code: 'u{1f413}',
          emoji: Emojis.animals_rooster),
      EmojiModel(
          name: 'animals_hatching_chick',
          code: 'u{1f423}',
          emoji: Emojis.animals_hatching_chick),
      EmojiModel(
          name: 'animals_baby_chick',
          code: 'u{1f424}',
          emoji: Emojis.animals_baby_chick),
      EmojiModel(
          name: 'animals_front_facing_baby_chick',
          code: 'u{1f425}',
          emoji: Emojis.animals_front_facing_baby_chick),
      EmojiModel(
          name: 'animals_bird', code: 'u{1f426}', emoji: Emojis.animals_bird),
      EmojiModel(
          name: 'animals_penguin',
          code: 'u{1f427}',
          emoji: Emojis.animals_penguin),
      EmojiModel(
          name: 'animals_dove', code: 'u{1f54a}', emoji: Emojis.animals_dove),
      EmojiModel(
          name: 'animals_eagle', code: 'u{1f985}', emoji: Emojis.animals_eagle),
      EmojiModel(
          name: 'animals_duck', code: 'u{1f986}', emoji: Emojis.animals_duck),
      EmojiModel(
          name: 'animals_swan', code: ' u{1f9a2}', emoji: Emojis.animals_swan),
      EmojiModel(
          name: 'animals_owl', code: ' u{1f989}', emoji: Emojis.animals_owl),
      EmojiModel(
          name: 'animals_dodo', code: 'u{1f9a4}', emoji: Emojis.animals_dodo),
      EmojiModel(
          name: 'animals_feather',
          code: 'u{1fab6}',
          emoji: Emojis.animals_feather),
      EmojiModel(
          name: 'animals_flamingo',
          code: 'u{1f9a9}',
          emoji: Emojis.animals_flamingo),
      EmojiModel(
          name: 'animals_peacock',
          code: 'u{1f99a}',
          emoji: Emojis.animals_peacock),
      EmojiModel(
          name: 'animals_parrot',
          code: 'u{1f99c}',
          emoji: Emojis.animals_parrot),
      EmojiModel(
          name: 'animals_frog', code: 'u{1f438}', emoji: Emojis.animals_frog),
      EmojiModel(
          name: 'animals_crocodile',
          code: 'u{1f40a}',
          emoji: Emojis.animals_crocodile),
      EmojiModel(
          name: 'animals_turtle',
          code: 'u{1f422}',
          emoji: Emojis.animals_turtle),
      EmojiModel(
          name: 'animals_lizard',
          code: 'u{1f98e}',
          emoji: Emojis.animals_lizard),
      EmojiModel(
          name: 'animals_snake', code: 'u{1f40d}', emoji: Emojis.animals_snake),
      EmojiModel(
          name: 'animals_dragon_face',
          code: 'u{1f432}',
          emoji: Emojis.animals_dragon_face),
      EmojiModel(
          name: 'animals_dragon',
          code: 'u{1f409}',
          emoji: Emojis.animals_dragon),
      EmojiModel(
          name: 'animals_sauropod',
          code: 'u{1f995}',
          emoji: Emojis.animals_sauropod),
      EmojiModel(
          name: 'animals_t_rex', code: 'u{1f996}', emoji: Emojis.animals_t_rex),
      EmojiModel(
          name: 'animals_spouting_whale',
          code: 'u{1f433}',
          emoji: Emojis.animals_spouting_whale),
      EmojiModel(
          name: 'animals_whale', code: 'u{1f40b}', emoji: Emojis.animals_whale),
      EmojiModel(
          name: 'animals_dolphin',
          code: 'u{1f42c}',
          emoji: Emojis.animals_dolphin),
      EmojiModel(
          name: 'animals_seal', code: 'u{1f9ad}', emoji: Emojis.animals_seal),
      EmojiModel(
          name: 'animals_fish', code: 'u{1f41f}', emoji: Emojis.animals_fish),
      EmojiModel(
          name: 'animals_tropical_fish',
          code: 'u{1f420}',
          emoji: Emojis.animals_tropical_fish),
      EmojiModel(
          name: 'animals_blowfish',
          code: 'u{1f421}',
          emoji: Emojis.animals_blowfish),
      EmojiModel(
          name: 'animals_shark', code: 'u{1f988}', emoji: Emojis.animals_shark),
      EmojiModel(
          name: 'animals_octopus',
          code: 'u{1f419}',
          emoji: Emojis.animals_octopus),
      EmojiModel(
          name: 'animals_spiral_shell',
          code: 'u{1f41a}',
          emoji: Emojis.animals_spiral_shell),
      EmojiModel(
          name: 'animals_snail', code: 'u{1f40c}', emoji: Emojis.animals_snail),
      EmojiModel(
          name: 'animals_butterfly',
          code: 'u{1f98b}',
          emoji: Emojis.animals_butterfly),
      EmojiModel(
          name: 'animals_bug', code: 'u{1f41b}', emoji: Emojis.animals_bug),
      EmojiModel(
          name: 'animals_ant', code: 'u{1f41c}', emoji: Emojis.animals_ant),
      EmojiModel(
          name: 'animals_honeybee',
          code: 'u{1f41d}',
          emoji: Emojis.animals_honeybee),
      EmojiModel(
          name: 'animals_beetle',
          code: 'u{1fab2}',
          emoji: Emojis.animals_beetle),
      EmojiModel(
          name: 'animals_lady_beetle',
          code: 'u{1f41e}',
          emoji: Emojis.animals_lady_beetle),
      EmojiModel(
          name: 'animals_cricket',
          code: 'u{1f997}',
          emoji: Emojis.animals_cricket),
      EmojiModel(
          name: 'animals_cockroach',
          code: 'u{1fab3}',
          emoji: Emojis.animals_cockroach),
      EmojiModel(
          name: 'animals_spider',
          code: 'u{1f577}',
          emoji: Emojis.animals_spider),
      EmojiModel(
          name: 'animals_spider_web',
          code: 'u{1f578}',
          emoji: Emojis.animals_spider_web),
      EmojiModel(
          name: 'animals_scorpion',
          code: 'u{1f982}',
          emoji: Emojis.animals_scorpion),
      EmojiModel(
          name: 'animals_mosquito',
          code: 'u{1f99f}',
          emoji: Emojis.animals_mosquito),
      EmojiModel(
          name: 'animals_fly', code: 'u{1fab0}', emoji: Emojis.animals_fly),
      EmojiModel(
          name: 'animals_worm', code: 'u{1fab1}', emoji: Emojis.animals_worm),
      EmojiModel(
          name: 'animals_microbe',
          code: 'u{1f9a0}',
          emoji: Emojis.animals_microbe),
      EmojiModel(
          name: 'flower_bouquet',
          code: 'u{1f490}',
          emoji: Emojis.flower_bouquet),
      EmojiModel(
          name: 'flower_cherry_blossom',
          code: 'u{1f338}',
          emoji: Emojis.flower_cherry_blossom),
      EmojiModel(
          name: 'flower_white_flower',
          code: 'u{1f4ae}',
          emoji: Emojis.flower_white_flower),
      EmojiModel(
          name: 'flower_rosette',
          code: 'u{1f3f5}',
          emoji: Emojis.flower_rosette),
      EmojiModel(
          name: 'flower_rose', code: 'u{1f339}', emoji: Emojis.flower_rose),
      EmojiModel(
          name: 'flower_wilted_flower',
          code: 'u{1f940}',
          emoji: Emojis.flower_wilted_flower),
      EmojiModel(
          name: 'flower_hibiscus',
          code: 'u{1f33a}',
          emoji: Emojis.flower_hibiscus),
      EmojiModel(
          name: 'flower_sunflower',
          code: 'u{1f33b}',
          emoji: Emojis.flower_sunflower),
      EmojiModel(
          name: 'flower_blossom',
          code: 'u{1f33c}',
          emoji: Emojis.flower_blossom),
      EmojiModel(
          name: 'flower_tulip', code: 'u{1f337}', emoji: Emojis.flower_tulip),
      EmojiModel(
          name: 'plant_seedling',
          code: 'u{1f331}',
          emoji: Emojis.plant_seedling),
      EmojiModel(
          name: 'plant_potted_plant',
          code: 'u{1fab4}',
          emoji: Emojis.plant_potted_plant),
      EmojiModel(
          name: 'plant_evergreen_tree',
          code: 'u{1f332}',
          emoji: Emojis.plant_evergreen_tree),
      EmojiModel(
          name: 'plant_deciduous_tree',
          code: 'u{1f333}',
          emoji: Emojis.plant_deciduous_tree),
      EmojiModel(
          name: 'plant_palm_tree',
          code: 'u{1f334}',
          emoji: Emojis.plant_palm_tree),
      EmojiModel(
          name: 'plant_cactus', code: 'u{1f335}', emoji: Emojis.plant_cactus),
      EmojiModel(
          name: 'plant_sheaf_of_rice',
          code: 'u{1f33e}',
          emoji: Emojis.plant_sheaf_of_rice),
      EmojiModel(
          name: 'plant_herb', code: 'u{1f33f}', emoji: Emojis.plant_herb),
      EmojiModel(
          name: 'plant_shamrock',
          code: 'u{2618}',
          emoji: Emojis.plant_shamrock),
      EmojiModel(
          name: 'plant_four_leaf_clover',
          code: 'u{1f340}',
          emoji: Emojis.plant_four_leaf_clover),
      EmojiModel(
          name: 'plant_maple_leaf',
          code: 'u{1f341}',
          emoji: Emojis.plant_maple_leaf),
      EmojiModel(
          name: 'plant_fallen_leaf',
          code: 'u{1f342}',
          emoji: Emojis.plant_fallen_leaf),
      EmojiModel(
          name: 'plant_leaf_fluttering_in_wind',
          code: 'u{1f343}',
          emoji: Emojis.plant_leaf_fluttering_in_wind),
      EmojiModel(
          name: 'food_grapes', code: 'u{1f347}', emoji: Emojis.food_grapes),
      EmojiModel(
          name: 'food_melon', code: 'u{1f348}', emoji: Emojis.food_melon),
      EmojiModel(
          name: 'food_watermelon',
          code: 'u{1f349}',
          emoji: Emojis.food_watermelon),
      EmojiModel(
          name: 'food_tangerine',
          code: 'u{1f34a}',
          emoji: Emojis.food_tangerine),
      EmojiModel(
          name: 'food_lemon', code: 'u{1f34b}', emoji: Emojis.food_lemon),
      EmojiModel(
          name: 'food_banana', code: 'u{1f34c}', emoji: Emojis.food_banana),
      EmojiModel(
          name: 'food_pineapple',
          code: 'u{1f34d}',
          emoji: Emojis.food_pineapple),
      EmojiModel(
          name: 'food_mango', code: 'u{1f96d}', emoji: Emojis.food_mango),
      EmojiModel(
          name: 'food_red_apple',
          code: 'u{1f34e}',
          emoji: Emojis.food_red_apple),
      EmojiModel(
          name: 'food_green_apple',
          code: 'u{1f34f}',
          emoji: Emojis.food_green_apple),
      EmojiModel(name: 'food_pear', code: 'u{1f350}', emoji: Emojis.food_pear),
      EmojiModel(
          name: 'food_peach', code: 'u{1f351}', emoji: Emojis.food_peach),
      EmojiModel(
          name: 'food_cherries', code: 'u{1f352}', emoji: Emojis.food_cherries),
      EmojiModel(
          name: 'food_strawberry',
          code: 'u{1f353}',
          emoji: Emojis.food_strawberry),
      EmojiModel(
          name: 'food_blueberries',
          code: 'u{1fad0}',
          emoji: Emojis.food_blueberries),
      EmojiModel(
          name: 'food_kiwi_fruit',
          code: 'u{1f95d}',
          emoji: Emojis.food_kiwi_fruit),
      EmojiModel(
          name: 'food_tomato', code: 'u{1f345}', emoji: Emojis.food_tomato),
      EmojiModel(
          name: 'food_olive', code: 'u{1fad2}', emoji: Emojis.food_olive),
      EmojiModel(
          name: 'food_coconut', code: 'u{1f965}', emoji: Emojis.food_coconut),
      EmojiModel(
          name: 'food_avocado', code: 'u{1f951}', emoji: Emojis.food_avocado),
      EmojiModel(
          name: 'food_eggplant', code: 'u{1f346}', emoji: Emojis.food_eggplant),
      EmojiModel(
          name: 'food_potato', code: 'u{1f954}', emoji: Emojis.food_potato),
      EmojiModel(
          name: 'food_carrot', code: 'u{1f955}', emoji: Emojis.food_carrot),
      EmojiModel(
          name: 'food_ear_of_corn',
          code: 'u{1f33d}',
          emoji: Emojis.food_ear_of_corn),
      EmojiModel(
          name: 'food_hot_pepper',
          code: 'u{1f336}',
          emoji: Emojis.food_hot_pepper),
      EmojiModel(
          name: 'food_bell_pepper',
          code: 'u{1fad1}',
          emoji: Emojis.food_bell_pepper),
      EmojiModel(
          name: 'food_cucumber', code: 'u{1f952}', emoji: Emojis.food_cucumber),
      EmojiModel(
          name: 'food_leafy_green',
          code: 'u{1f96c}',
          emoji: Emojis.food_leafy_green),
      EmojiModel(
          name: 'food_broccoli', code: 'u{1f966}', emoji: Emojis.food_broccoli),
      EmojiModel(
          name: 'food_garlic', code: 'u{1f9c4}', emoji: Emojis.food_garlic),
      EmojiModel(
          name: 'food_onion', code: 'u{1f9c5}', emoji: Emojis.food_onion),
      EmojiModel(
          name: 'food_mushroom', code: 'u{1f344}', emoji: Emojis.food_mushroom),
      EmojiModel(
          name: 'food_peanuts', code: 'u{1f95c}', emoji: Emojis.food_peanuts),
      EmojiModel(
          name: 'food_chestnut', code: 'u{1f330}', emoji: Emojis.food_chestnut),
      EmojiModel(
          name: 'food_bread', code: 'u{1f35e}', emoji: Emojis.food_bread),
      EmojiModel(
          name: 'food_croissant',
          code: 'u{1f950}',
          emoji: Emojis.food_croissant),
      EmojiModel(
          name: 'food_baguette_bread',
          code: 'u{1f956}',
          emoji: Emojis.food_baguette_bread),
      EmojiModel(
          name: 'food_flatbread',
          code: 'u{1fad3}',
          emoji: Emojis.food_flatbread),
      EmojiModel(
          name: 'food_pretzel', code: 'u{1f968}', emoji: Emojis.food_pretzel),
      EmojiModel(
          name: 'food_bagel', code: 'u{1f96f}', emoji: Emojis.food_bagel),
      EmojiModel(
          name: 'food_pancakes', code: 'u{1f95e}', emoji: Emojis.food_pancakes),
      EmojiModel(
          name: 'food_waffle', code: 'u{1f9c7}', emoji: Emojis.food_waffle),
      EmojiModel(
          name: 'food_cheese_wedge',
          code: 'u{1f9c0}',
          emoji: Emojis.food_cheese_wedge),
      EmojiModel(
          name: 'food_meat_on_bone',
          code: 'u{1f356}',
          emoji: Emojis.food_meat_on_bone),
      EmojiModel(
          name: 'food_poultry_leg',
          code: 'u{1f357}',
          emoji: Emojis.food_poultry_leg),
      EmojiModel(
          name: 'food_cut_of_meat',
          code: 'u{1f969}',
          emoji: Emojis.food_cut_of_meat),
      EmojiModel(
          name: 'food_bacon', code: 'u{1f953}', emoji: Emojis.food_bacon),
      EmojiModel(
          name: 'food_hamburger',
          code: 'u{1f354}',
          emoji: Emojis.food_hamburger),
      EmojiModel(
          name: 'food_french_fries',
          code: 'u{1f35f}',
          emoji: Emojis.food_french_fries),
      EmojiModel(
          name: 'food_pizza', code: 'u{1f355}', emoji: Emojis.food_pizza),
      EmojiModel(
          name: 'food_hot_dog', code: 'u{1f32d}', emoji: Emojis.food_hot_dog),
      EmojiModel(
          name: 'food_sandwich', code: 'u{1f96a}', emoji: Emojis.food_sandwich),
      EmojiModel(name: 'food_taco', code: 'u{1f32e}', emoji: Emojis.food_taco),
      EmojiModel(
          name: 'food_burrito', code: 'u{1f32f}', emoji: Emojis.food_burrito),
      EmojiModel(
          name: 'food_tamale', code: 'u{1fad4}', emoji: Emojis.food_tamale),
      EmojiModel(
          name: 'food_stuffed_flatbread',
          code: 'u{1f959}',
          emoji: Emojis.food_stuffed_flatbread),
      EmojiModel(
          name: 'food_falafel', code: 'u{1f9c6}', emoji: Emojis.food_falafel),
      EmojiModel(name: 'food_egg', code: 'u{1f95a}', emoji: Emojis.food_egg),
      EmojiModel(
          name: 'food_cooking', code: 'u{1f373}', emoji: Emojis.food_cooking),
      EmojiModel(
          name: 'food_shallow_pan_of_food',
          code: 'u{1f958}',
          emoji: Emojis.food_shallow_pan_of_food),
      EmojiModel(
          name: 'food_pot_of_food',
          code: 'u{1f372}',
          emoji: Emojis.food_pot_of_food),
      EmojiModel(
          name: 'food_fondue', code: 'u{1fad5}', emoji: Emojis.food_fondue),
      EmojiModel(
          name: 'food_bowl_with_spoon',
          code: 'u{1f963}',
          emoji: Emojis.food_bowl_with_spoon),
      EmojiModel(
          name: 'food_green_salad',
          code: 'u{1f957}',
          emoji: Emojis.food_green_salad),
      EmojiModel(
          name: 'food_popcorn', code: 'u{1f37f}', emoji: Emojis.food_popcorn),
      EmojiModel(
          name: 'food_butter', code: 'u{1f9c8}', emoji: Emojis.food_butter),
      EmojiModel(name: 'food_salt', code: 'u{1f9c2}', emoji: Emojis.food_salt),
      EmojiModel(
          name: 'food_canned_food',
          code: 'u{1f96b}',
          emoji: Emojis.food_canned_food),
      EmojiModel(
          name: 'food_bento_box',
          code: 'u{1f371}',
          emoji: Emojis.food_bento_box),
      EmojiModel(
          name: 'food_rice_cracker',
          code: 'u{1f358}',
          emoji: Emojis.food_rice_cracker),
      EmojiModel(
          name: 'food_rice_ball',
          code: 'u{1f359}',
          emoji: Emojis.food_rice_ball),
      EmojiModel(
          name: 'food_cooked_rice',
          code: 'u{1f35a}',
          emoji: Emojis.food_cooked_rice),
      EmojiModel(
          name: 'food_curry_rice',
          code: 'u{1f35b}',
          emoji: Emojis.food_curry_rice),
      EmojiModel(
          name: 'food_steaming_bowl',
          code: 'u{1f35c}',
          emoji: Emojis.food_steaming_bowl),
      EmojiModel(
          name: 'food_spaghetti',
          code: 'u{1f35d}',
          emoji: Emojis.food_spaghetti),
      EmojiModel(
          name: 'food_roasted_sweet_potato',
          code: 'u{1f360}',
          emoji: Emojis.food_roasted_sweet_potato),
      EmojiModel(name: 'food_oden', code: 'u{1f362}', emoji: Emojis.food_oden),
      EmojiModel(
          name: 'food_sushi', code: 'u{1f363}', emoji: Emojis.food_sushi),
      EmojiModel(
          name: 'food_fried_shrimp',
          code: 'u{1f364}',
          emoji: Emojis.food_fried_shrimp),
      EmojiModel(
          name: 'food_fish_cake_with_swirl',
          code: 'u{1f365}',
          emoji: Emojis.food_fish_cake_with_swirl),
      EmojiModel(
          name: 'food_moon_cake',
          code: 'u{1f96e}',
          emoji: Emojis.food_moon_cake),
      EmojiModel(
          name: 'food_dango', code: 'u{1f361}', emoji: Emojis.food_dango),
      EmojiModel(
          name: 'food_dumpling', code: 'u{1f95f}', emoji: Emojis.food_dumpling),
      EmojiModel(
          name: 'food_fortune_cookie',
          code: 'u{1f960}',
          emoji: Emojis.food_fortune_cookie),
      EmojiModel(
          name: 'food_takeout_box',
          code: 'u{1f961}',
          emoji: Emojis.food_takeout_box),
      EmojiModel(name: 'food_crab', code: 'u{1f980}', emoji: Emojis.food_crab),
      EmojiModel(
          name: 'food_lobster', code: 'u{1f99e}', emoji: Emojis.food_lobster),
      EmojiModel(
          name: 'food_shrimp', code: 'u{1f990}', emoji: Emojis.food_shrimp),
      EmojiModel(
          name: 'food_squid', code: 'u{1f991}', emoji: Emojis.food_squid),
      EmojiModel(
          name: 'food_oyster', code: 'u{1f9aa}', emoji: Emojis.food_oyster),
      EmojiModel(
          name: 'food_soft_ice_cream',
          code: 'u{1f366}',
          emoji: Emojis.food_soft_ice_cream),
      EmojiModel(
          name: 'food_shaved_ice',
          code: 'u{1f367}',
          emoji: Emojis.food_shaved_ice),
      EmojiModel(
          name: 'food_ice_cream',
          code: 'u{1f368}',
          emoji: Emojis.food_ice_cream),
      EmojiModel(
          name: 'food_doughnut', code: 'u{1f369}', emoji: Emojis.food_doughnut),
      EmojiModel(
          name: 'food_cookie', code: 'u{1f36a}', emoji: Emojis.food_cookie),
      EmojiModel(
          name: 'food_birthday_cake',
          code: 'u{1f382}',
          emoji: Emojis.food_birthday_cake),
      EmojiModel(
          name: 'food_shortcake',
          code: 'u{1f370}',
          emoji: Emojis.food_shortcake),
      EmojiModel(
          name: 'food_cupcake', code: 'u{1f9c1}', emoji: Emojis.food_cupcake),
      EmojiModel(name: 'food_pie', code: 'u{1f967}', emoji: Emojis.food_pie),
      EmojiModel(
          name: 'food_chocolate_bar',
          code: 'u{1f36b}',
          emoji: Emojis.food_chocolate_bar),
      EmojiModel(
          name: 'food_candy', code: 'u{1f36c}', emoji: Emojis.food_candy),
      EmojiModel(
          name: 'food_lollipop', code: 'u{1f36d}', emoji: Emojis.food_lollipop),
      EmojiModel(
          name: 'food_custard', code: 'u{1f36e}', emoji: Emojis.food_custard),
      EmojiModel(
          name: 'food_honey_pot',
          code: 'u{1f36f}',
          emoji: Emojis.food_honey_pot),
      EmojiModel(
          name: 'food_baby_bottle',
          code: 'u{1f37c}',
          emoji: Emojis.food_baby_bottle),
      EmojiModel(
          name: 'food_glass_of_milk',
          code: 'u{1f95b}',
          emoji: Emojis.food_glass_of_milk),
      EmojiModel(
          name: 'food_hot_beverage',
          code: 'u{2615}',
          emoji: Emojis.food_hot_beverage),
      EmojiModel(
          name: 'food_teapot', code: 'u{1fad6}', emoji: Emojis.food_teapot),
      EmojiModel(
          name: 'food_teacup_without_handle',
          code: 'u{1f375}',
          emoji: Emojis.food_teacup_without_handle),
      EmojiModel(name: 'food_sake', code: 'u{1f376}', emoji: Emojis.food_sake),
      EmojiModel(
          name: 'food_bottle_with_popping_cork',
          code: 'u{1f37e}',
          emoji: Emojis.food_bottle_with_popping_cork),
      EmojiModel(
          name: 'food_wine_glass',
          code: 'u{1f377}',
          emoji: Emojis.food_wine_glass),
      EmojiModel(
          name: 'food_cocktail_glass',
          code: 'u{1f378}',
          emoji: Emojis.food_cocktail_glass),
      EmojiModel(
          name: 'food_tropical_drink',
          code: 'u{1f379}',
          emoji: Emojis.food_tropical_drink),
      EmojiModel(
          name: 'food_beer_mug', code: 'u{1f37a}', emoji: Emojis.food_beer_mug),
      EmojiModel(
          name: 'food_clinking_beer_mugs',
          code: 'u{1f37b}',
          emoji: Emojis.food_clinking_beer_mugs),
      EmojiModel(
          name: 'food_clinking_glasses',
          code: 'u{1f942}',
          emoji: Emojis.food_clinking_glasses),
      EmojiModel(
          name: 'food_tumbler_glass',
          code: 'u{1f943}',
          emoji: Emojis.food_tumbler_glass),
      EmojiModel(
          name: 'food_cup_with_straw',
          code: 'u{1f964}',
          emoji: Emojis.food_cup_with_straw),
      EmojiModel(
          name: 'food_bubble_tea',
          code: 'u{1f9cb}',
          emoji: Emojis.food_bubble_tea),
      EmojiModel(
          name: 'food_beverage_box',
          code: 'u{1f9c3}',
          emoji: Emojis.food_beverage_box),
      EmojiModel(name: 'food_mate', code: 'u{1f9c9}', emoji: Emojis.food_mate),
      EmojiModel(name: 'food_ice', code: 'u{1f9ca}', emoji: Emojis.food_ice),
      EmojiModel(
          name: 'dishware_chopsticks',
          code: 'u{1f962}',
          emoji: Emojis.dishware_chopsticks),
      EmojiModel(
          name: 'dishware_fork_and_knife_with_plate',
          code: 'u{1f37d}',
          emoji: Emojis.dishware_fork_and_knife_with_plate),
      EmojiModel(
          name: 'dishware_fork_and_knife',
          code: 'u{1f374}',
          emoji: Emojis.dishware_fork_and_knife),
      EmojiModel(
          name: 'dishware_spoon',
          code: 'u{1f944}',
          emoji: Emojis.dishware_spoon),
      EmojiModel(
          name: 'dishware_kitchen_knife',
          code: 'u{1f52a}',
          emoji: Emojis.dishware_kitchen_knife),
      EmojiModel(
          name: 'dishware_amphora',
          code: 'u{1f3fa}',
          emoji: Emojis.dishware_amphora),
      EmojiModel(
          name: 'map_globe_showing_europe_africa',
          code: 'u{1f30d}',
          emoji: Emojis.map_globe_showing_europe_africa),
      EmojiModel(
          name: 'map_globe_showing_americas',
          code: 'u{1f30e}',
          emoji: Emojis.map_globe_showing_americas),
      EmojiModel(
          name: 'map_globe_showing_asia_australia',
          code: 'u{1f30f}',
          emoji: Emojis.map_globe_showing_asia_australia),
      EmojiModel(
          name: 'map_globe_with_meridians',
          code: 'u{1f310}',
          emoji: Emojis.map_globe_with_meridians),
      EmojiModel(
          name: 'map_world_map', code: 'u{1f5fa}', emoji: Emojis.map_world_map),
      EmojiModel(
          name: 'map_map_of_japan',
          code: 'u{1f5fe}',
          emoji: Emojis.map_map_of_japan),
      EmojiModel(
          name: 'map_compass', code: 'u{1f9ed}', emoji: Emojis.map_compass),
      EmojiModel(
          name: 'geographic_snow_capped_mountain',
          code: 'u{1f3d4}',
          emoji: Emojis.geographic_snow_capped_mountain),
      EmojiModel(
          name: 'geographic_mountain',
          code: 'u{26f0}',
          emoji: Emojis.geographic_mountain),
      EmojiModel(
          name: 'geographic_volcano',
          code: 'u{1f30b}',
          emoji: Emojis.geographic_volcano),
      EmojiModel(
          name: 'geographic_mount_fuji',
          code: 'u{1f5fb}',
          emoji: Emojis.geographic_mount_fuji),
      EmojiModel(
          name: 'geographic_camping',
          code: 'u{1f3d5}',
          emoji: Emojis.geographic_camping),
      EmojiModel(
          name: 'geographic_beach_with_umbrella',
          code: 'u{1f3d6}',
          emoji: Emojis.geographic_beach_with_umbrella),
      EmojiModel(
          name: 'geographic_desert',
          code: 'u{1f3dc}',
          emoji: Emojis.geographic_desert),
      EmojiModel(
          name: 'geographic_desert_island',
          code: 'u{1f3dd}',
          emoji: Emojis.geographic_desert_island),
      EmojiModel(
          name: 'geographic_national_park',
          code: 'u{1f3de}',
          emoji: Emojis.geographic_national_park),
      EmojiModel(
          name: 'building_stadium',
          code: 'u{1f3df}',
          emoji: Emojis.building_stadium),
      EmojiModel(
          name: 'building_classical_building',
          code: 'u{1f3db}',
          emoji: Emojis.building_classical_building),
      EmojiModel(
          name: 'building_building_construction',
          code: 'u{1f3d7}',
          emoji: Emojis.building_building_construction),
      EmojiModel(
          name: 'building_brick',
          code: 'u{1f9f1}',
          emoji: Emojis.building_brick),
      EmojiModel(
          name: 'building_rock', code: 'u{1faa8}', emoji: Emojis.building_rock),
      EmojiModel(
          name: 'building_wood', code: 'u{1fab5}', emoji: Emojis.building_wood),
      EmojiModel(
          name: 'building_hut', code: 'u{1f6d6}', emoji: Emojis.building_hut),
      EmojiModel(
          name: 'building_houses',
          code: 'u{1f3d8}',
          emoji: Emojis.building_houses),
      EmojiModel(
          name: 'building_derelict_house',
          code: 'u{1f3da}',
          emoji: Emojis.building_derelict_house),
      EmojiModel(
          name: 'building_house',
          code: 'u{1f3e0}',
          emoji: Emojis.building_house),
      EmojiModel(
          name: 'building_house_with_garden',
          code: 'u{1f3e1}',
          emoji: Emojis.building_house_with_garden),
      EmojiModel(
          name: 'building_office_building',
          code: 'u{1f3e2}',
          emoji: Emojis.building_office_building),
      EmojiModel(
          name: 'building_japanese_post_office',
          code: 'u{1f3e3}',
          emoji: Emojis.building_japanese_post_office),
      EmojiModel(
          name: 'building_post_office',
          code: 'u{1f3e4}',
          emoji: Emojis.building_post_office),
      EmojiModel(
          name: 'building_hospital',
          code: 'u{1f3e5}',
          emoji: Emojis.building_hospital),
      EmojiModel(
          name: 'building_bank', code: 'u{1f3e6}', emoji: Emojis.building_bank),
      EmojiModel(
          name: 'building_hotel',
          code: 'u{1f3e8}',
          emoji: Emojis.building_hotel),
      EmojiModel(
          name: 'building_love_hotel',
          code: 'u{1f3e9}',
          emoji: Emojis.building_love_hotel),
      EmojiModel(
          name: 'building_convenience_store',
          code: 'u{1f3ea}',
          emoji: Emojis.building_convenience_store),
      EmojiModel(
          name: 'building_school',
          code: 'u{1f3eb}',
          emoji: Emojis.building_school),
      EmojiModel(
          name: 'building_department_store',
          code: 'u{1f3ec}',
          emoji: Emojis.building_department_store),
      EmojiModel(
          name: 'building_factory',
          code: 'u{1f3ed}',
          emoji: Emojis.building_factory),
      EmojiModel(
          name: 'building_japanese_castle',
          code: 'u{1f3ef}',
          emoji: Emojis.building_japanese_castle),
      EmojiModel(
          name: 'building_castle',
          code: 'u{1f3f0}',
          emoji: Emojis.building_castle),
      EmojiModel(
          name: 'building_wedding',
          code: 'u{1f492}',
          emoji: Emojis.building_wedding),
      EmojiModel(
          name: 'building_tokyo_tower',
          code: 'u{1f5fc}',
          emoji: Emojis.building_tokyo_tower),
      EmojiModel(
          name: 'building_statue_of_liberty',
          code: 'u{1f5fd}',
          emoji: Emojis.building_statue_of_liberty),
      EmojiModel(
          name: 'building_church',
          code: 'u{26ea}',
          emoji: Emojis.building_church),
      EmojiModel(
          name: 'building_mosque',
          code: 'u{1f54c}',
          emoji: Emojis.building_mosque),
      EmojiModel(
          name: 'building_hindu_temple',
          code: 'u{1f6d5}',
          emoji: Emojis.building_hindu_temple),
      EmojiModel(
          name: 'building_synagogue',
          code: 'u{1f54d}',
          emoji: Emojis.building_synagogue),
      EmojiModel(
          name: 'building_shinto_shrine',
          code: 'u{26e9}',
          emoji: Emojis.building_shinto_shrine),
      EmojiModel(
          name: 'building_kaaba',
          code: 'u{1f54b}',
          emoji: Emojis.building_kaaba),
      EmojiModel(
          name: 'building_fountain',
          code: 'u{26f2}',
          emoji: Emojis.building_fountain),
      EmojiModel(
          name: 'building_tent', code: 'u{26fa}', emoji: Emojis.building_tent),
      EmojiModel(
          name: 'building_foggy',
          code: 'u{1f301}',
          emoji: Emojis.building_foggy),
      EmojiModel(
          name: 'building_night_with_stars',
          code: 'u{1f303}',
          emoji: Emojis.building_night_with_stars),
      EmojiModel(
          name: 'building_cityscape',
          code: 'u{1f3d9}',
          emoji: Emojis.building_cityscape),
      EmojiModel(
          name: 'building_sunrise_over_mountains',
          code: 'u{1f304}',
          emoji: Emojis.building_sunrise_over_mountains),
      EmojiModel(
          name: 'building_sunrise',
          code: 'u{1f305}',
          emoji: Emojis.building_sunrise),
      EmojiModel(
          name: 'building_cityscape_at_dusk',
          code: 'u{1f306}',
          emoji: Emojis.building_cityscape_at_dusk),
      EmojiModel(
          name: 'building_sunset',
          code: 'u{1f307}',
          emoji: Emojis.building_sunset),
      EmojiModel(
          name: 'building_bridge_at_night',
          code: 'u{1f309}',
          emoji: Emojis.building_bridge_at_night),
      EmojiModel(
          name: 'building_hot_springs',
          code: 'u{2668}',
          emoji: Emojis.building_hot_springs),
      EmojiModel(
          name: 'building_carousel_horse',
          code: 'u{1f3a0}',
          emoji: Emojis.building_carousel_horse),
      EmojiModel(
          name: 'building_ferris_wheel',
          code: 'u{1f3a1}',
          emoji: Emojis.building_ferris_wheel),
      EmojiModel(
          name: 'building_roller_coaster',
          code: 'u{1f3a2}',
          emoji: Emojis.building_roller_coaster),
      EmojiModel(
          name: 'building_barber_pole',
          code: 'u{1f488}',
          emoji: Emojis.building_barber_pole),
      EmojiModel(
          name: 'building_circus_tent',
          code: 'u{1f3aa}',
          emoji: Emojis.building_circus_tent),
      EmojiModel(
          name: 'transport_locomotive',
          code: 'u{1f682}',
          emoji: Emojis.transport_locomotive),
      EmojiModel(
          name: 'transport_railway_car',
          code: 'u{1f683}',
          emoji: Emojis.transport_railway_car),
      EmojiModel(
          name: 'transport_high_speed_train',
          code: 'u{1f684}',
          emoji: Emojis.transport_high_speed_train),
      EmojiModel(
          name: 'transport_bullet_train',
          code: 'u{1f685}',
          emoji: Emojis.transport_bullet_train),
      EmojiModel(
          name: 'transport_train',
          code: 'u{1f686}',
          emoji: Emojis.transport_train),
      EmojiModel(
          name: 'transport_metro',
          code: 'u{1f687}',
          emoji: Emojis.transport_metro),
      EmojiModel(
          name: 'transport_light_rail',
          code: 'u{1f688}',
          emoji: Emojis.transport_light_rail),
      EmojiModel(
          name: 'transport_station',
          code: 'u{1f689}',
          emoji: Emojis.transport_station),
      EmojiModel(
          name: 'transport_tram',
          code: 'u{1f68a}',
          emoji: Emojis.transport_tram),
      EmojiModel(
          name: 'transport_monorail',
          code: 'u{1f69d}',
          emoji: Emojis.transport_monorail),
      EmojiModel(
          name: 'transport_mountain_railway',
          code: 'u{1f69e}',
          emoji: Emojis.transport_mountain_railway),
      EmojiModel(
          name: 'transport_tram_car',
          code: 'u{1f68b}',
          emoji: Emojis.transport_tram_car),
      EmojiModel(
          name: 'transport_bus', code: 'u{1f68c}', emoji: Emojis.transport_bus),
      EmojiModel(
          name: 'transport_oncoming_bus',
          code: 'u{1f68d}',
          emoji: Emojis.transport_oncoming_bus),
      EmojiModel(
          name: 'transport_trolleybus',
          code: 'u{1f68e}',
          emoji: Emojis.transport_trolleybus),
      EmojiModel(
          name: 'transport_minibus',
          code: 'u{1f690}',
          emoji: Emojis.transport_minibus),
      EmojiModel(
          name: 'transport_ambulance',
          code: 'u{1f691}',
          emoji: Emojis.transport_ambulance),
      EmojiModel(
          name: 'transport_fire_engine',
          code: 'u{1f692}',
          emoji: Emojis.transport_fire_engine),
      EmojiModel(
          name: 'transport_police_car',
          code: 'u{1f693}',
          emoji: Emojis.transport_police_car),
      EmojiModel(
          name: 'transport_oncoming_police_car',
          code: 'u{1f694}',
          emoji: Emojis.transport_oncoming_police_car),
      EmojiModel(
          name: 'transport_taxi',
          code: 'u{1f695}',
          emoji: Emojis.transport_taxi),
      EmojiModel(
          name: 'transport_oncoming_taxi',
          code: 'u{1f696}',
          emoji: Emojis.transport_oncoming_taxi),
      EmojiModel(
          name: 'transport_automobile',
          code: 'u{1f697}',
          emoji: Emojis.transport_automobile),
      EmojiModel(
          name: 'transport_oncoming_automobile',
          code: 'u{1f698}',
          emoji: Emojis.transport_oncoming_automobile),
      EmojiModel(
          name: 'transport_sport_utility_vehicle',
          code: 'u{1f699}',
          emoji: Emojis.transport_sport_utility_vehicle),
      EmojiModel(
          name: 'transport_pickup_truck',
          code: 'u{1f6fb}',
          emoji: Emojis.transport_pickup_truck),
      EmojiModel(
          name: 'transport_delivery_truck',
          code: 'u{1f69a}',
          emoji: Emojis.transport_delivery_truck),
      EmojiModel(
          name: 'transport_articulated_lorry',
          code: 'u{1f69b}',
          emoji: Emojis.transport_articulated_lorry),
      EmojiModel(
          name: 'transport_tractor',
          code: 'u{1f69c}',
          emoji: Emojis.transport_tractor),
      EmojiModel(
          name: 'transport_racing_car',
          code: 'u{1f3ce}',
          emoji: Emojis.transport_racing_car),
      EmojiModel(
          name: 'transport_motorcycle',
          code: 'u{1f3cd}',
          emoji: Emojis.transport_motorcycle),
      EmojiModel(
          name: 'transport_motor_scooter',
          code: 'u{1f6f5}',
          emoji: Emojis.transport_motor_scooter),
      EmojiModel(
          name: 'transport_manual_wheelchair',
          code: 'u{1f9bd}',
          emoji: Emojis.transport_manual_wheelchair),
      EmojiModel(
          name: 'transport_motorized_wheelchair',
          code: 'u{1f9bc}',
          emoji: Emojis.transport_motorized_wheelchair),
      EmojiModel(
          name: 'transport_auto_rickshaw',
          code: 'u{1f6fa}',
          emoji: Emojis.transport_auto_rickshaw),
      EmojiModel(
          name: 'transport_bicycle',
          code: 'u{1f6b2}',
          emoji: Emojis.transport_bicycle),
      EmojiModel(
          name: 'transport_kick_scooter',
          code: 'u{1f6f4}',
          emoji: Emojis.transport_kick_scooter),
      EmojiModel(
          name: 'transport_skateboard',
          code: 'u{1f6f9}',
          emoji: Emojis.transport_skateboard),
      EmojiModel(
          name: 'transport_roller_skate',
          code: 'u{1f6fc}',
          emoji: Emojis.transport_roller_skate),
      EmojiModel(
          name: 'transport_bus_stop',
          code: 'u{1f68f}',
          emoji: Emojis.transport_bus_stop),
      EmojiModel(
          name: 'transport_motorway',
          code: 'u{1f6e3}',
          emoji: Emojis.transport_motorway),
      EmojiModel(
          name: 'transport_railway_track',
          code: 'u{1f6e4}',
          emoji: Emojis.transport_railway_track),
      EmojiModel(
          name: 'transport_oil_drum',
          code: 'u{1f6e2}',
          emoji: Emojis.transport_oil_drum),
      EmojiModel(
          name: 'transport_fuel_pump',
          code: 'u{26fd}',
          emoji: Emojis.transport_fuel_pump),
      EmojiModel(
          name: 'transport_police_car_light',
          code: 'u{1f6a8}',
          emoji: Emojis.transport_police_car_light),
      EmojiModel(
          name: 'transport_horizontal_traffic_light',
          code: 'u{1f6a5}',
          emoji: Emojis.transport_horizontal_traffic_light),
      EmojiModel(
          name: 'transport_vertical_traffic_light',
          code: 'u{1f6a6}',
          emoji: Emojis.transport_vertical_traffic_light),
      EmojiModel(
          name: 'transport_stop_sign',
          code: 'u{1f6d1}',
          emoji: Emojis.transport_stop_sign),
      EmojiModel(
          name: 'transport_construction',
          code: 'u{1f6a7}',
          emoji: Emojis.transport_construction),
      EmojiModel(
          name: 'transport_water_anchor',
          code: 'u{2693}',
          emoji: Emojis.transport_water_anchor),
      EmojiModel(
          name: 'transport_water_sailboat',
          code: 'u{26f5}',
          emoji: Emojis.transport_water_sailboat),
      EmojiModel(
          name: 'transport_water_canoe',
          code: 'u{1f6f6}',
          emoji: Emojis.transport_water_canoe),
      EmojiModel(
          name: 'transport_water_speedboat',
          code: 'u{1f6a4}',
          emoji: Emojis.transport_water_speedboat),
      EmojiModel(
          name: 'transport_water_passenger_ship',
          code: 'u{1f6f3}',
          emoji: Emojis.transport_water_passenger_ship),
      EmojiModel(
          name: 'transport_water_ferry',
          code: 'u{26f4}',
          emoji: Emojis.transport_water_ferry),
      EmojiModel(
          name: 'transport_water_motor_boat',
          code: 'u{1f6e5}',
          emoji: Emojis.transport_water_motor_boat),
      EmojiModel(
          name: 'transport_water_ship',
          code: 'u{1f6a2}',
          emoji: Emojis.transport_water_ship),
      EmojiModel(
          name: 'transport_air_airplane',
          code: 'u{2708}',
          emoji: Emojis.transport_air_airplane),
      EmojiModel(
          name: 'transport_air_small_airplane',
          code: 'u{1f6e9}',
          emoji: Emojis.transport_air_small_airplane),
      EmojiModel(
          name: 'transport_air_airplane_departure',
          code: 'u{1f6eb}',
          emoji: Emojis.transport_air_airplane_departure),
      EmojiModel(
          name: 'transport_air_airplane_arrival',
          code: 'u{1f6ec}',
          emoji: Emojis.transport_air_airplane_arrival),
      EmojiModel(
          name: 'transport_air_parachute',
          code: 'u{1fa82}',
          emoji: Emojis.transport_air_parachute),
      EmojiModel(
          name: 'transport_air_seat',
          code: 'u{1f4ba}',
          emoji: Emojis.transport_air_seat),
      EmojiModel(
          name: 'transport_air_helicopter',
          code: 'u{1f681}',
          emoji: Emojis.transport_air_helicopter),
      EmojiModel(
          name: 'transport_air_suspension_railway',
          code: 'u{1f69f}',
          emoji: Emojis.transport_air_suspension_railway),
      EmojiModel(
          name: 'transport_air_mountain_cableway',
          code: 'u{1f6a0}',
          emoji: Emojis.transport_air_mountain_cableway),
      EmojiModel(
          name: 'transport_air_aerial_tramway',
          code: 'u{1f6a1}',
          emoji: Emojis.transport_air_aerial_tramway),
      EmojiModel(
          name: 'transport_air_satellite',
          code: 'u{1f6f0}',
          emoji: Emojis.transport_air_satellite),
      EmojiModel(
          name: 'transport_air_rocket',
          code: 'u{1f680}',
          emoji: Emojis.transport_air_rocket),
      EmojiModel(
          name: 'transport_air_flying_saucer',
          code: 'u{1F6F8}',
          emoji: Emojis.transport_air_flying_saucer),
      EmojiModel(
          name: 'hotel_bellhop_bell',
          code: 'u{1f6ce}',
          emoji: Emojis.hotel_bellhop_bell),
      EmojiModel(
          name: 'hotel_luggage', code: 'u{1f9f3}', emoji: Emojis.hotel_luggage),
      EmojiModel(
          name: 'time_hourglass_done',
          code: 'u{231b}',
          emoji: Emojis.time_hourglass_done),
      EmojiModel(
          name: 'time_hourglass_not_done',
          code: 'u{23f3}',
          emoji: Emojis.time_hourglass_not_done),
      EmojiModel(name: 'time_watch', code: 'u{231a}', emoji: Emojis.time_watch),
      EmojiModel(
          name: 'time_alarm_clock',
          code: 'u{23f0}',
          emoji: Emojis.time_alarm_clock),
      EmojiModel(
          name: 'time_stopwatch',
          code: 'u{23f1}',
          emoji: Emojis.time_stopwatch),
      EmojiModel(
          name: 'time_timer_clock',
          code: 'u{23f2}',
          emoji: Emojis.time_timer_clock),
      EmojiModel(
          name: 'time_mantelpiece_clock',
          code: 'u{1f570}',
          emoji: Emojis.time_mantelpiece_clock),
      EmojiModel(
          name: 'time_twelve_o_clock',
          code: 'u{1f55b}',
          emoji: Emojis.time_twelve_o_clock),
      EmojiModel(
          name: 'time_twelve_thirty',
          code: 'u{1f567}',
          emoji: Emojis.time_twelve_thirty),
      EmojiModel(
          name: 'time_one_o_clock',
          code: 'u{1f550}',
          emoji: Emojis.time_one_o_clock),
      EmojiModel(
          name: 'time_one_thirty',
          code: 'u{1f55c}',
          emoji: Emojis.time_one_thirty),
      EmojiModel(
          name: 'time_two_o_clock',
          code: 'u{1f551}',
          emoji: Emojis.time_two_o_clock),
      EmojiModel(
          name: 'time_two_thirty',
          code: 'u{1f55d}',
          emoji: Emojis.time_two_thirty),
      EmojiModel(
          name: 'time_three_o_clock',
          code: 'u{1f552}',
          emoji: Emojis.time_three_o_clock),
      EmojiModel(
          name: 'time_three_thirty',
          code: 'u{1f55e}',
          emoji: Emojis.time_three_thirty),
      EmojiModel(
          name: 'time_four_o_clock',
          code: 'u{1f553}',
          emoji: Emojis.time_four_o_clock),
      EmojiModel(
          name: 'time_four_thirty',
          code: 'u{1f55f}',
          emoji: Emojis.time_four_thirty),
      EmojiModel(
          name: 'time_five_o_clock',
          code: 'u{1f554}',
          emoji: Emojis.time_five_o_clock),
      EmojiModel(
          name: 'time_five_thirty',
          code: 'u{1f560}',
          emoji: Emojis.time_five_thirty),
      EmojiModel(
          name: 'time_six_o_clock',
          code: 'u{1f555}',
          emoji: Emojis.time_six_o_clock),
      EmojiModel(
          name: 'time_six_thirty',
          code: 'u{1f561}',
          emoji: Emojis.time_six_thirty),
      EmojiModel(
          name: 'time_seven_o_clock',
          code: 'u{1f556}',
          emoji: Emojis.time_seven_o_clock),
      EmojiModel(
          name: 'time_seven_thirty',
          code: 'u{1f562}',
          emoji: Emojis.time_seven_thirty),
      EmojiModel(
          name: 'time_eight_o_clock',
          code: 'u{1f557}',
          emoji: Emojis.time_eight_o_clock),
      EmojiModel(
          name: 'time_eight_thirty',
          code: 'u{1f563}',
          emoji: Emojis.time_eight_thirty),
      EmojiModel(
          name: 'time_nine_o_clock',
          code: 'u{1f558}',
          emoji: Emojis.time_nine_o_clock),
      EmojiModel(
          name: 'time_nine_thirty',
          code: 'u{1f564}',
          emoji: Emojis.time_nine_thirty),
      EmojiModel(
          name: 'time_ten_o_clock',
          code: 'u{1f559}',
          emoji: Emojis.time_ten_o_clock),
      EmojiModel(
          name: 'time_ten_thirty',
          code: 'u{1f565}',
          emoji: Emojis.time_ten_thirty),
      EmojiModel(
          name: 'time_eleven_o_clock',
          code: 'u{1f55a}',
          emoji: Emojis.time_eleven_o_clock),
      EmojiModel(
          name: 'time_eleven_thirty',
          code: 'u{1f566}',
          emoji: Emojis.time_eleven_thirty),
      EmojiModel(
          name: 'moon_new_moon', code: 'u{1f311}', emoji: Emojis.moon_new_moon),
      EmojiModel(
          name: 'moon_waxing_crescent_moon',
          code: 'u{1f312}',
          emoji: Emojis.moon_waxing_crescent_moon),
      EmojiModel(
          name: 'moon_first_quarter_moon',
          code: 'u{1f313}',
          emoji: Emojis.moon_first_quarter_moon),
      EmojiModel(
          name: 'moon_waxing_gibbous_moon',
          code: 'u{1f314}',
          emoji: Emojis.moon_waxing_gibbous_moon),
      EmojiModel(
          name: 'moon_full_moon',
          code: 'u{1f315}',
          emoji: Emojis.moon_full_moon),
      EmojiModel(
          name: 'moon_waning_gibbous_moon',
          code: 'u{1f316}',
          emoji: Emojis.moon_waning_gibbous_moon),
      EmojiModel(
          name: 'moon_last_quarter_moon',
          code: 'u{1f317}',
          emoji: Emojis.moon_last_quarter_moon),
      EmojiModel(
          name: 'moon_waning_crescent_moon',
          code: 'u{1f318}',
          emoji: Emojis.moon_waning_crescent_moon),
      EmojiModel(
          name: 'moon_crescent_moon',
          code: 'u{1f319}',
          emoji: Emojis.moon_crescent_moon),
      EmojiModel(
          name: 'moon_new_moon_face',
          code: 'u{1f31a}',
          emoji: Emojis.moon_new_moon_face),
      EmojiModel(
          name: 'moon_first_quarter_moon_face',
          code: 'u{1f31b}',
          emoji: Emojis.moon_first_quarter_moon_face),
      EmojiModel(
          name: 'moon_last_quarter_moon_face',
          code: 'u{1f31c}',
          emoji: Emojis.moon_last_quarter_moon_face),
      EmojiModel(
          name: 'wheater_thermometer',
          code: 'u{1f321}',
          emoji: Emojis.wheater_thermometer),
      EmojiModel(name: 'sun', code: 'u{2600}', emoji: Emojis.sun),
      EmojiModel(
          name: 'sun_full_moon_face',
          code: 'u{1f31d}',
          emoji: Emojis.sun_full_moon_face),
      EmojiModel(
          name: 'sun_sun_with_face',
          code: 'u{1f31e}',
          emoji: Emojis.sun_sun_with_face),
      EmojiModel(
          name: 'sun_ringed_planet',
          code: 'u{1fa90}',
          emoji: Emojis.sun_ringed_planet),
      EmojiModel(name: 'sky_star', code: 'u{2b50}', emoji: Emojis.sky_star),
      EmojiModel(
          name: 'sky_glowing_star',
          code: 'u{1f31f}',
          emoji: Emojis.sky_glowing_star),
      EmojiModel(
          name: 'sky_shooting_star',
          code: 'u{1f320}',
          emoji: Emojis.sky_shooting_star),
      EmojiModel(
          name: 'sky_milky_way', code: 'u{1f30c}', emoji: Emojis.sky_milky_way),
      EmojiModel(name: 'sky_cloud', code: 'u{2601}', emoji: Emojis.sky_cloud),
      EmojiModel(
          name: 'sky_sun_behind_cloud',
          code: 'u{26c5}',
          emoji: Emojis.sky_sun_behind_cloud),
      EmojiModel(
          name: 'sky_cloud_with_lightning_and_rain',
          code: 'u{26c8}',
          emoji: Emojis.sky_cloud_with_lightning_and_rain),
      EmojiModel(
          name: 'sky_sun_behind_small_cloud',
          code: 'u{1f324}',
          emoji: Emojis.sky_sun_behind_small_cloud),
      EmojiModel(
          name: 'sky_sun_behind_large_cloud',
          code: 'u{1f325}',
          emoji: Emojis.sky_sun_behind_large_cloud),
      EmojiModel(
          name: 'sky_sun_behind_rain_cloud',
          code: 'u{1f326}',
          emoji: Emojis.sky_sun_behind_rain_cloud),
      EmojiModel(
          name: 'sky_cloud_with_rain',
          code: 'u{1f327}',
          emoji: Emojis.sky_cloud_with_rain),
      EmojiModel(
          name: 'sky_cloud_with_snow',
          code: 'u{1f328}',
          emoji: Emojis.sky_cloud_with_snow),
      EmojiModel(
          name: 'sky_cloud_with_lightning',
          code: 'u{1f329}',
          emoji: Emojis.sky_cloud_with_lightning),
      EmojiModel(
          name: 'sky_tornado', code: 'u{1f32a}', emoji: Emojis.sky_tornado),
      EmojiModel(name: 'sky_fog', code: 'u{1f32b}', emoji: Emojis.sky_fog),
      EmojiModel(
          name: 'sky_wind_face', code: 'u{1f32c}', emoji: Emojis.sky_wind_face),
      EmojiModel(
          name: 'sky_cyclone', code: 'u{1f300}', emoji: Emojis.sky_cyclone),
      EmojiModel(
          name: 'sky_rainbow', code: 'u{1f308}', emoji: Emojis.sky_rainbow),
      EmojiModel(
          name: 'wheater_closed_umbrella',
          code: 'u{1f302}',
          emoji: Emojis.wheater_closed_umbrella),
      EmojiModel(
          name: 'wheater_umbrella',
          code: 'u{2602}',
          emoji: Emojis.wheater_umbrella),
      EmojiModel(
          name: 'wheater_umbrella_with_rain_drops',
          code: 'u{2614}',
          emoji: Emojis.wheater_umbrella_with_rain_drops),
      EmojiModel(
          name: 'wheater_umbrella_on_ground',
          code: 'u{26f1}',
          emoji: Emojis.wheater_umbrella_on_ground),
      EmojiModel(
          name: 'wheater_high_voltage',
          code: 'u{26a1}',
          emoji: Emojis.wheater_high_voltage),
      EmojiModel(
          name: 'wheater_snowflake',
          code: 'u{2744}',
          emoji: Emojis.wheater_snowflake),
      EmojiModel(
          name: 'wheater_snowman',
          code: 'u{2603}',
          emoji: Emojis.wheater_snowman),
      EmojiModel(
          name: 'wheater_snowman_without_snow',
          code: 'u{26c4}',
          emoji: Emojis.wheater_snowman_without_snow),
      EmojiModel(
          name: 'wheater_comet', code: 'u{2604}', emoji: Emojis.wheater_comet),
      EmojiModel(
          name: 'wheater_fire', code: 'u{1f525}', emoji: Emojis.wheater_fire),
      EmojiModel(
          name: 'wheater_droplet',
          code: 'u{1f4a7}',
          emoji: Emojis.wheater_droplet),
      EmojiModel(
          name: 'wheater_water_wave',
          code: 'u{1f30a}',
          emoji: Emojis.wheater_water_wave),
      EmojiModel(
          name: 'activites_jack_o_lantern',
          code: 'u{1f383}',
          emoji: Emojis.activites_jack_o_lantern),
      EmojiModel(
          name: 'activites_christmas_tree',
          code: 'u{1f384}',
          emoji: Emojis.activites_christmas_tree),
      EmojiModel(
          name: 'activites_fireworks',
          code: 'u{1f386}',
          emoji: Emojis.activites_fireworks),
      EmojiModel(
          name: 'activites_sparkler',
          code: 'u{1f387}',
          emoji: Emojis.activites_sparkler),
      EmojiModel(
          name: 'activites_firecracker',
          code: 'u{1f9e8}',
          emoji: Emojis.activites_firecracker),
      EmojiModel(
          name: 'activites_sparkles',
          code: 'u{2728}',
          emoji: Emojis.activites_sparkles),
      EmojiModel(
          name: 'activites_balloon',
          code: 'u{1f388}',
          emoji: Emojis.activites_balloon),
      EmojiModel(
          name: 'activites_party_popper',
          code: 'u{1f389}',
          emoji: Emojis.activites_party_popper),
      EmojiModel(
          name: 'activites_confetti_ball',
          code: 'u{1f38a}',
          emoji: Emojis.activites_confetti_ball),
      EmojiModel(
          name: 'activites_tanabata_tree',
          code: 'u{1f38b}',
          emoji: Emojis.activites_tanabata_tree),
      EmojiModel(
          name: 'activites_pine_decoration',
          code: 'u{1f38d}',
          emoji: Emojis.activites_pine_decoration),
      EmojiModel(
          name: 'activites_japanese_dolls',
          code: 'u{1f38e}',
          emoji: Emojis.activites_japanese_dolls),
      EmojiModel(
          name: 'activites_carp_streamer',
          code: 'u{1f38f}',
          emoji: Emojis.activites_carp_streamer),
      EmojiModel(
          name: 'activites_wind_chime',
          code: 'u{1f390}',
          emoji: Emojis.activites_wind_chime),
      EmojiModel(
          name: 'activites_moon_viewing_ceremony',
          code: 'u{1f391}',
          emoji: Emojis.activites_moon_viewing_ceremony),
      EmojiModel(
          name: 'activites_red_envelope',
          code: 'u{1f9e7}',
          emoji: Emojis.activites_red_envelope),
      EmojiModel(
          name: 'activites_ribbon',
          code: 'u{1f380}',
          emoji: Emojis.activites_ribbon),
      EmojiModel(
          name: 'activites_wrapped_gift',
          code: 'u{1f381}',
          emoji: Emojis.activites_wrapped_gift),
      EmojiModel(
          name: 'activites_reminder_ribbon',
          code: 'u{1f397}',
          emoji: Emojis.activites_reminder_ribbon),
      EmojiModel(
          name: 'activites_admission_tickets',
          code: 'u{1f39f}',
          emoji: Emojis.activites_admission_tickets),
      EmojiModel(
          name: 'activites_ticket',
          code: 'u{1f3ab}',
          emoji: Emojis.activites_ticket),
      EmojiModel(
          name: 'award_military_medal',
          code: 'u{1f396}',
          emoji: Emojis.award_military_medal),
      EmojiModel(
          name: 'award_trophy', code: 'u{1f3c6}', emoji: Emojis.award_trophy),
      EmojiModel(
          name: 'award_sports_medal',
          code: 'u{1f3c5}',
          emoji: Emojis.award_sports_medal),
      EmojiModel(
          name: 'award_medal_1st_place',
          code: 'u{1f947}',
          emoji: Emojis.award_medal_1st_place),
      EmojiModel(
          name: 'award_medal_2nd_place',
          code: 'u{1f948}',
          emoji: Emojis.award_medal_2nd_place),
      EmojiModel(
          name: 'award_medal_3rd_place',
          code: 'u{1f949}',
          emoji: Emojis.award_medal_3rd_place),
      EmojiModel(
          name: 'sport_soccer_ball',
          code: 'u{26bd}',
          emoji: Emojis.sport_soccer_ball),
      EmojiModel(
          name: 'sport_baseball',
          code: 'u{26be}',
          emoji: Emojis.sport_baseball),
      EmojiModel(
          name: 'sport_softball',
          code: 'u{1f94e}',
          emoji: Emojis.sport_softball),
      EmojiModel(
          name: 'sport_basketball',
          code: 'u{1f3c0}',
          emoji: Emojis.sport_basketball),
      EmojiModel(
          name: 'sport_volleyball',
          code: 'u{1f3d0}',
          emoji: Emojis.sport_volleyball),
      EmojiModel(
          name: 'sport_american_football',
          code: 'u{1f3c8}',
          emoji: Emojis.sport_american_football),
      EmojiModel(
          name: 'sport_rugby_football',
          code: 'u{1f3c9}',
          emoji: Emojis.sport_rugby_football),
      EmojiModel(
          name: 'sport_tennis', code: 'u{1f3be}', emoji: Emojis.sport_tennis),
      EmojiModel(
          name: 'sport_flying_disc',
          code: 'u{1f94f}',
          emoji: Emojis.sport_flying_disc),
      EmojiModel(
          name: 'sport_bowling', code: 'u{1f3b3}', emoji: Emojis.sport_bowling),
      EmojiModel(
          name: 'sport_cricket_game',
          code: 'u{1f3cf}',
          emoji: Emojis.sport_cricket_game),
      EmojiModel(
          name: 'sport_field_hockey',
          code: 'u{1f3d1}',
          emoji: Emojis.sport_field_hockey),
      EmojiModel(
          name: 'sport_ice_hockey',
          code: 'u{1f3d2}',
          emoji: Emojis.sport_ice_hockey),
      EmojiModel(
          name: 'sport_lacrosse',
          code: 'u{1f94d}',
          emoji: Emojis.sport_lacrosse),
      EmojiModel(
          name: 'sport_ping_pong',
          code: 'u{1f3d3}',
          emoji: Emojis.sport_ping_pong),
      EmojiModel(
          name: 'sport_badminton',
          code: 'u{1f3f8}',
          emoji: Emojis.sport_badminton),
      EmojiModel(
          name: 'sport_boxing_glove',
          code: 'u{1f94a}',
          emoji: Emojis.sport_boxing_glove),
      EmojiModel(
          name: 'sport_martial_arts_uniform',
          code: 'u{1f94b}',
          emoji: Emojis.sport_martial_arts_uniform),
      EmojiModel(
          name: 'sport_goal_net',
          code: 'u{1f945}',
          emoji: Emojis.sport_goal_net),
      EmojiModel(
          name: 'sport_flag_in_hole',
          code: 'u{26f3}',
          emoji: Emojis.sport_flag_in_hole),
      EmojiModel(
          name: 'sport_ice_skate',
          code: 'u{26f8}',
          emoji: Emojis.sport_ice_skate),
      EmojiModel(
          name: 'sport_fishing_pole',
          code: 'u{1f3a3}',
          emoji: Emojis.sport_fishing_pole),
      EmojiModel(
          name: 'sport_diving_mask',
          code: 'u{1f93f}',
          emoji: Emojis.sport_diving_mask),
      EmojiModel(
          name: 'sport_running_shirt',
          code: 'u{1f3bd}',
          emoji: Emojis.sport_running_shirt),
      EmojiModel(
          name: 'sport_skis', code: 'u{1f3bf}', emoji: Emojis.sport_skis),
      EmojiModel(
          name: 'sport_sled', code: 'u{1f6f7}', emoji: Emojis.sport_sled),
      EmojiModel(
          name: 'sport_curling_stone',
          code: 'u{1f94c}',
          emoji: Emojis.sport_curling_stone),
      EmojiModel(
          name: 'game_bullseye', code: 'u{1f3af}', emoji: Emojis.game_bullseye),
      EmojiModel(
          name: 'game_yo_yo', code: 'u{1fa80}', emoji: Emojis.game_yo_yo),
      EmojiModel(name: 'game_kite', code: 'u{1fa81}', emoji: Emojis.game_kite),
      EmojiModel(
          name: 'game_pool_8_ball',
          code: 'u{1f3b1}',
          emoji: Emojis.game_pool_8_ball),
      EmojiModel(
          name: 'game_crystal_ball',
          code: 'u{1f52e}',
          emoji: Emojis.game_crystal_ball),
      EmojiModel(
          name: 'game_magic_wand',
          code: 'u{1fa84}',
          emoji: Emojis.game_magic_wand),
      EmojiModel(
          name: 'game_nazar_amulet',
          code: 'u{1f9ff}',
          emoji: Emojis.game_nazar_amulet),
      EmojiModel(
          name: 'game_video_game',
          code: 'u{1f3ae}',
          emoji: Emojis.game_video_game),
      EmojiModel(
          name: 'game_joystick', code: 'u{1f579}', emoji: Emojis.game_joystick),
      EmojiModel(
          name: 'game_slot_machine',
          code: 'u{1f3b0}',
          emoji: Emojis.game_slot_machine),
      EmojiModel(
          name: 'game_game_die', code: 'u{1f3b2}', emoji: Emojis.game_game_die),
      EmojiModel(
          name: 'game_puzzle_piece',
          code: 'u{1f9e9}',
          emoji: Emojis.game_puzzle_piece),
      EmojiModel(
          name: 'game_teddy_bear',
          code: 'u{1f9f8}',
          emoji: Emojis.game_teddy_bear),
      EmojiModel(
          name: 'game_pinata', code: 'u{1fa85}', emoji: Emojis.game_pinata),
      EmojiModel(
          name: 'game_nesting_dolls',
          code: 'u{1fa86}',
          emoji: Emojis.game_nesting_dolls),
      EmojiModel(
          name: 'game_spade_suit',
          code: 'u{2660}',
          emoji: Emojis.game_spade_suit),
      EmojiModel(
          name: 'game_heart_suit',
          code: 'u{2665}',
          emoji: Emojis.game_heart_suit),
      EmojiModel(
          name: 'game_diamond_suit',
          code: 'u{2666}',
          emoji: Emojis.game_diamond_suit),
      EmojiModel(
          name: 'game_club_suit',
          code: 'u{2663}',
          emoji: Emojis.game_club_suit),
      EmojiModel(
          name: 'game_chess_pawn',
          code: 'u{265f}',
          emoji: Emojis.game_chess_pawn),
      EmojiModel(
          name: 'game_joker', code: 'u{1f0cf}', emoji: Emojis.game_joker),
      EmojiModel(
          name: 'game_mahjong_red_dragon',
          code: 'u{1f004}',
          emoji: Emojis.game_mahjong_red_dragon),
      EmojiModel(
          name: 'game_flower_playing_cards',
          code: 'u{1f3b4}',
          emoji: Emojis.game_flower_playing_cards),
      EmojiModel(
          name: 'art_performing_arts',
          code: 'u{1f3ad}',
          emoji: Emojis.art_performing_arts),
      EmojiModel(
          name: 'art_framed_picture',
          code: 'u{1f5bc}',
          emoji: Emojis.art_framed_picture),
      EmojiModel(
          name: 'art_artist_palette',
          code: 'u{1f3a8}',
          emoji: Emojis.art_artist_palette),
      EmojiModel(
          name: 'art_thread', code: 'u{1f9f5}', emoji: Emojis.art_thread),
      EmojiModel(
          name: 'art_sewing_needle',
          code: 'u{1faa1}',
          emoji: Emojis.art_sewing_needle),
      EmojiModel(name: 'art_yarn', code: 'u{1f9f6}', emoji: Emojis.art_yarn),
      EmojiModel(name: 'art_knot', code: 'u{1faa2}', emoji: Emojis.art_knot),
      EmojiModel(
          name: 'clothing_glasses',
          code: 'u{1f453}',
          emoji: Emojis.clothing_glasses),
      EmojiModel(
          name: 'clothing_sunglasses',
          code: 'u{1f576}',
          emoji: Emojis.clothing_sunglasses),
      EmojiModel(
          name: 'clothing_goggles',
          code: 'u{1f97d}',
          emoji: Emojis.clothing_goggles),
      EmojiModel(
          name: 'clothing_lab_coat',
          code: 'u{1f97c}',
          emoji: Emojis.clothing_lab_coat),
      EmojiModel(
          name: 'clothing_safety_vest',
          code: 'u{1f9ba}',
          emoji: Emojis.clothing_safety_vest),
      EmojiModel(
          name: 'clothing_necktie',
          code: 'u{1f454}',
          emoji: Emojis.clothing_necktie),
      EmojiModel(
          name: 'clothing_t_shirt',
          code: 'u{1f455}',
          emoji: Emojis.clothing_t_shirt),
      EmojiModel(
          name: 'clothing_jeans',
          code: 'u{1f456}',
          emoji: Emojis.clothing_jeans),
      EmojiModel(
          name: 'clothing_scarf',
          code: 'u{1f9e3}',
          emoji: Emojis.clothing_scarf),
      EmojiModel(
          name: 'clothing_gloves',
          code: 'u{1f9e4}',
          emoji: Emojis.clothing_gloves),
      EmojiModel(
          name: 'clothing_coat', code: 'u{1f9e5}', emoji: Emojis.clothing_coat),
      EmojiModel(
          name: 'clothing_socks',
          code: 'u{1f9e6}',
          emoji: Emojis.clothing_socks),
      EmojiModel(
          name: 'clothing_dress',
          code: 'u{1f457}',
          emoji: Emojis.clothing_dress),
      EmojiModel(
          name: 'clothing_kimono',
          code: 'u{1f458}',
          emoji: Emojis.clothing_kimono),
      EmojiModel(
          name: 'clothing_sari', code: 'u{1f97b}', emoji: Emojis.clothing_sari),
      EmojiModel(
          name: 'clothing_one_piece_swimsuit',
          code: 'u{1fa71}',
          emoji: Emojis.clothing_one_piece_swimsuit),
      EmojiModel(
          name: 'clothing_briefs',
          code: 'u{1fa72}',
          emoji: Emojis.clothing_briefs),
      EmojiModel(
          name: 'clothing_shorts',
          code: 'u{1fa73}',
          emoji: Emojis.clothing_shorts),
      EmojiModel(
          name: 'clothing_bikini',
          code: 'u{1f459}',
          emoji: Emojis.clothing_bikini),
      EmojiModel(
          name: 'clothing_woman_s_clothes',
          code: 'u{1f45a}',
          emoji: Emojis.clothing_woman_s_clothes),
      EmojiModel(
          name: 'clothing_purse',
          code: 'u{1f45b}',
          emoji: Emojis.clothing_purse),
      EmojiModel(
          name: 'clothing_handbag',
          code: 'u{1f45c}',
          emoji: Emojis.clothing_handbag),
      EmojiModel(
          name: 'clothing_clutch_bag',
          code: 'u{1f45d}',
          emoji: Emojis.clothing_clutch_bag),
      EmojiModel(
          name: 'clothing_shopping_bags',
          code: 'u{1f6cd}',
          emoji: Emojis.clothing_shopping_bags),
      EmojiModel(
          name: 'clothing_backpack',
          code: 'u{1f392}',
          emoji: Emojis.clothing_backpack),
      EmojiModel(
          name: 'clothing_thong_sandal',
          code: 'u{1fa74}',
          emoji: Emojis.clothing_thong_sandal),
      EmojiModel(
          name: 'clothing_man_s_shoe',
          code: 'u{1f45e}',
          emoji: Emojis.clothing_man_s_shoe),
      EmojiModel(
          name: 'clothing_running_shoe',
          code: 'u{1f45f}',
          emoji: Emojis.clothing_running_shoe),
      EmojiModel(
          name: 'clothing_hiking_boot',
          code: 'u{1f97e}',
          emoji: Emojis.clothing_hiking_boot),
      EmojiModel(
          name: 'clothing_flat_shoe',
          code: 'u{1f97f}',
          emoji: Emojis.clothing_flat_shoe),
      EmojiModel(
          name: 'clothing_high_heeled_shoe',
          code: 'u{1f460}',
          emoji: Emojis.clothing_high_heeled_shoe),
      EmojiModel(
          name: 'clothing_woman_s_sandal',
          code: 'u{1f461}',
          emoji: Emojis.clothing_woman_s_sandal),
      EmojiModel(
          name: 'clothing_ballet_shoes',
          code: 'u{1fa70}',
          emoji: Emojis.clothing_ballet_shoes),
      EmojiModel(
          name: 'clothing_woman_s_boot',
          code: 'u{1f462}',
          emoji: Emojis.clothing_woman_s_boot),
      EmojiModel(
          name: 'clothing_crown',
          code: 'u{1f451}',
          emoji: Emojis.clothing_crown),
      EmojiModel(
          name: 'clothing_woman_s_hat',
          code: 'u{1f452}',
          emoji: Emojis.clothing_woman_s_hat),
      EmojiModel(
          name: 'clothing_top_hat',
          code: 'u{1f3a9}',
          emoji: Emojis.clothing_top_hat),
      EmojiModel(
          name: 'clothing_graduation_cap',
          code: 'u{1f393}',
          emoji: Emojis.clothing_graduation_cap),
      EmojiModel(
          name: 'clothing_billed_cap',
          code: 'u{1f9e2}',
          emoji: Emojis.clothing_billed_cap),
      EmojiModel(
          name: 'clothing_military_helmet',
          code: 'u{1fa96}',
          emoji: Emojis.clothing_military_helmet),
      EmojiModel(
          name: 'clothing_rescue_worker_s_helmet',
          code: 'u{26d1}',
          emoji: Emojis.clothing_rescue_worker_s_helmet),
      EmojiModel(
          name: 'clothing_prayer_beads',
          code: 'u{1f4ff}',
          emoji: Emojis.clothing_prayer_beads),
      EmojiModel(
          name: 'clothing_lipstick',
          code: 'u{1f484}',
          emoji: Emojis.clothing_lipstick),
      EmojiModel(
          name: 'clothing_ring', code: 'u{1f48d}', emoji: Emojis.clothing_ring),
      EmojiModel(
          name: 'clothing_gem_stone',
          code: 'u{1f48e}',
          emoji: Emojis.clothing_gem_stone),
      EmojiModel(
          name: 'sound_muted_speaker',
          code: 'u{1f507}',
          emoji: Emojis.sound_muted_speaker),
      EmojiModel(
          name: 'sound_speaker_low_volume',
          code: 'u{1f508}',
          emoji: Emojis.sound_speaker_low_volume),
      EmojiModel(
          name: 'sound_speaker_medium_volume',
          code: 'u{1f509}',
          emoji: Emojis.sound_speaker_medium_volume),
      EmojiModel(
          name: 'sound_speaker_high_volume',
          code: 'u{1f50a}',
          emoji: Emojis.sound_speaker_high_volume),
      EmojiModel(
          name: 'sound_loudspeaker',
          code: 'u{1f4e2}',
          emoji: Emojis.sound_loudspeaker),
      EmojiModel(
          name: 'sound_megaphone',
          code: 'u{1f4e3}',
          emoji: Emojis.sound_megaphone),
      EmojiModel(
          name: 'sound_postal_horn',
          code: 'u{1f4ef}',
          emoji: Emojis.sound_postal_horn),
      EmojiModel(
          name: 'sound_bell', code: 'u{1f514}', emoji: Emojis.sound_bell),
      EmojiModel(
          name: 'sound_bell_with_slash',
          code: 'u{1f515}',
          emoji: Emojis.sound_bell_with_slash),
      EmojiModel(
          name: 'music_musical_score',
          code: 'u{1f3bc}',
          emoji: Emojis.music_musical_score),
      EmojiModel(
          name: 'music_musical_note',
          code: 'u{1f3b5}',
          emoji: Emojis.music_musical_note),
      EmojiModel(
          name: 'music_musical_notes',
          code: 'u{1f3b6}',
          emoji: Emojis.music_musical_notes),
      EmojiModel(
          name: 'music_studio_microphone',
          code: 'u{1f399}',
          emoji: Emojis.music_studio_microphone),
      EmojiModel(
          name: 'music_level_slider',
          code: 'u{1f39a}',
          emoji: Emojis.music_level_slider),
      EmojiModel(
          name: 'music_control_knobs',
          code: 'u{1f39b}',
          emoji: Emojis.music_control_knobs),
      EmojiModel(
          name: 'music_microphone',
          code: 'u{1f3a4}',
          emoji: Emojis.music_microphone),
      EmojiModel(
          name: 'music_headphone',
          code: 'u{1f3a7}',
          emoji: Emojis.music_headphone),
      EmojiModel(
          name: 'music_radio', code: 'u{1f4fb}', emoji: Emojis.music_radio),
      EmojiModel(
          name: 'music_saxophone',
          code: 'u{1f3b7}',
          emoji: Emojis.music_saxophone),
      EmojiModel(
          name: 'music_accordion',
          code: 'u{1fa97}',
          emoji: Emojis.music_accordion),
      EmojiModel(
          name: 'music_guitar', code: 'u{1f3b8}', emoji: Emojis.music_guitar),
      EmojiModel(
          name: 'music_musical_keyboard',
          code: 'u{1f3b9}',
          emoji: Emojis.music_musical_keyboard),
      EmojiModel(
          name: 'music_trumpet', code: 'u{1f3ba}', emoji: Emojis.music_trumpet),
      EmojiModel(
          name: 'music_violin', code: 'u{1f3bb}', emoji: Emojis.music_violin),
      EmojiModel(
          name: 'music_banjo', code: 'u{1fa95}', emoji: Emojis.music_banjo),
      EmojiModel(
          name: 'music_drum', code: 'u{1f941}', emoji: Emojis.music_drum),
      EmojiModel(
          name: 'music_long_drum',
          code: 'u{1fa98}',
          emoji: Emojis.music_long_drum),
      EmojiModel(
          name: 'phone_mobile_phone',
          code: 'u{1f4f1}',
          emoji: Emojis.phone_mobile_phone),
      EmojiModel(
          name: 'phone_mobile_phone_with_arrow',
          code: 'u{1f4f2}',
          emoji: Emojis.phone_mobile_phone_with_arrow),
      EmojiModel(
          name: 'phone_telephone',
          code: 'u{260e}',
          emoji: Emojis.phone_telephone),
      EmojiModel(
          name: 'phone_telephone_receiver',
          code: 'u{1f4de}',
          emoji: Emojis.phone_telephone_receiver),
      EmojiModel(
          name: 'phone_pager', code: 'u{1f4df}', emoji: Emojis.phone_pager),
      EmojiModel(
          name: 'phone_fax_machine',
          code: 'u{1f4e0}',
          emoji: Emojis.phone_fax_machine),
      EmojiModel(
          name: 'computer_battery',
          code: 'u{1f50b}',
          emoji: Emojis.computer_battery),
      EmojiModel(
          name: 'computer_electric_plug',
          code: 'u{1f50c}',
          emoji: Emojis.computer_electric_plug),
      EmojiModel(
          name: 'computer_laptop',
          code: 'u{1f4bb}',
          emoji: Emojis.computer_laptop),
      EmojiModel(
          name: 'computer_desktop_computer',
          code: 'u{1f5a5}',
          emoji: Emojis.computer_desktop_computer),
      EmojiModel(
          name: 'computer_printer',
          code: 'u{1f5a8}',
          emoji: Emojis.computer_printer),
      EmojiModel(
          name: 'computer_keyboard',
          code: 'u{2328}',
          emoji: Emojis.computer_keyboard),
      EmojiModel(
          name: 'computer_computer_mouse',
          code: 'u{1f5b1}',
          emoji: Emojis.computer_computer_mouse),
      EmojiModel(
          name: 'computer_trackball',
          code: 'u{1f5b2}',
          emoji: Emojis.computer_trackball),
      EmojiModel(
          name: 'computer_computer_disk',
          code: 'u{1f4bd}',
          emoji: Emojis.computer_computer_disk),
      EmojiModel(
          name: 'computer_floppy_disk',
          code: 'u{1f4be}',
          emoji: Emojis.computer_floppy_disk),
      EmojiModel(
          name: 'computer_optical_disk',
          code: 'u{1f4bf}',
          emoji: Emojis.computer_optical_disk),
      EmojiModel(
          name: 'computer_dvd', code: 'u{1f4c0}', emoji: Emojis.computer_dvd),
      EmojiModel(
          name: 'computer_abacus',
          code: 'u{1f9ee}',
          emoji: Emojis.computer_abacus),
      EmojiModel(
          name: 'video_movie_camera',
          code: 'u{1f3a5}',
          emoji: Emojis.video_movie_camera),
      EmojiModel(
          name: 'video_film_frames',
          code: 'u{1f39e}',
          emoji: Emojis.video_film_frames),
      EmojiModel(
          name: 'video_film_projector',
          code: 'u{1f4fd}',
          emoji: Emojis.video_film_projector),
      EmojiModel(
          name: 'video_clapper_board',
          code: 'u{1f3ac}',
          emoji: Emojis.video_clapper_board),
      EmojiModel(
          name: 'video_television',
          code: 'u{1f4fa}',
          emoji: Emojis.video_television),
      EmojiModel(
          name: 'video_camera', code: 'u{1f4f7}', emoji: Emojis.video_camera),
      EmojiModel(
          name: 'video_camera_with_flash',
          code: 'u{1f4f8}',
          emoji: Emojis.video_camera_with_flash),
      EmojiModel(
          name: 'video_video_camera',
          code: 'u{1f4f9}',
          emoji: Emojis.video_video_camera),
      EmojiModel(
          name: 'video_videocassette',
          code: 'u{1f4fc}',
          emoji: Emojis.video_videocassette),
      EmojiModel(
          name: 'light_magnifying_glass_tilted_left',
          code: 'u{1f50d}',
          emoji: Emojis.light_magnifying_glass_tilted_left),
      EmojiModel(
          name: 'light_magnifying_glass_tilted_right',
          code: 'u{1f50e}',
          emoji: Emojis.light_magnifying_glass_tilted_right),
      EmojiModel(
          name: 'light_candle', code: 'u{1f56f}', emoji: Emojis.light_candle),
      EmojiModel(
          name: 'light_light_bulb',
          code: 'u{1f4a1}',
          emoji: Emojis.light_light_bulb),
      EmojiModel(
          name: 'light_flashlight',
          code: 'u{1f526}',
          emoji: Emojis.light_flashlight),
      EmojiModel(
          name: 'light_red_paper_lantern',
          code: 'u{1f3ee}',
          emoji: Emojis.light_red_paper_lantern),
      EmojiModel(
          name: 'light_diya_lamp',
          code: 'u{1fa94}',
          emoji: Emojis.light_diya_lamp),
      EmojiModel(
          name: 'paper_notebook_with_decorative_cover',
          code: 'u{1f4d4}',
          emoji: Emojis.paper_notebook_with_decorative_cover),
      EmojiModel(
          name: 'paper_closed_book',
          code: 'u{1f4d5}',
          emoji: Emojis.paper_closed_book),
      EmojiModel(
          name: 'paper_open_book',
          code: 'u{1f4d6}',
          emoji: Emojis.paper_open_book),
      EmojiModel(
          name: 'paper_green_book',
          code: 'u{1f4d7}',
          emoji: Emojis.paper_green_book),
      EmojiModel(
          name: 'paper_blue_book',
          code: 'u{1f4d8}',
          emoji: Emojis.paper_blue_book),
      EmojiModel(
          name: 'paper_orange_book',
          code: 'u{1f4d9}',
          emoji: Emojis.paper_orange_book),
      EmojiModel(
          name: 'paper_books', code: 'u{1f4da}', emoji: Emojis.paper_books),
      EmojiModel(
          name: 'paper_notebook',
          code: 'u{1f4d3}',
          emoji: Emojis.paper_notebook),
      EmojiModel(
          name: 'paper_ledger', code: 'u{1f4d2}', emoji: Emojis.paper_ledger),
      EmojiModel(
          name: 'paper_page_with_curl',
          code: 'u{1f4c3}',
          emoji: Emojis.paper_page_with_curl),
      EmojiModel(
          name: 'paper_scroll', code: 'u{1f4dc}', emoji: Emojis.paper_scroll),
      EmojiModel(
          name: 'paper_page_facing_up',
          code: 'u{1f4c4}',
          emoji: Emojis.paper_page_facing_up),
      EmojiModel(
          name: 'paper_newspaper',
          code: 'u{1f4f0}',
          emoji: Emojis.paper_newspaper),
      EmojiModel(
          name: 'paper_rolled_up_newspaper',
          code: 'u{1f5de}',
          emoji: Emojis.paper_rolled_up_newspaper),
      EmojiModel(
          name: 'paper_bookmark_tabs',
          code: 'u{1f4d1}',
          emoji: Emojis.paper_bookmark_tabs),
      EmojiModel(
          name: 'paper_bookmark',
          code: 'u{1f516}',
          emoji: Emojis.paper_bookmark),
      EmojiModel(
          name: 'paper_label', code: 'u{1f3f7}', emoji: Emojis.paper_label),
      EmojiModel(
          name: 'money_money_bag',
          code: 'u{1f4b0}',
          emoji: Emojis.money_money_bag),
      EmojiModel(
          name: 'money_coin', code: 'u{1fa99}', emoji: Emojis.money_coin),
      EmojiModel(
          name: 'money_yen_banknote',
          code: 'u{1f4b4}',
          emoji: Emojis.money_yen_banknote),
      EmojiModel(
          name: 'money_dollar_banknote',
          code: 'u{1f4b5}',
          emoji: Emojis.money_dollar_banknote),
      EmojiModel(
          name: 'money_euro_banknote',
          code: 'u{1f4b6}',
          emoji: Emojis.money_euro_banknote),
      EmojiModel(
          name: 'money_pound_banknote',
          code: 'u{1f4b7}',
          emoji: Emojis.money_pound_banknote),
      EmojiModel(
          name: 'money_money_with_wings',
          code: 'u{1f4b8}',
          emoji: Emojis.money_money_with_wings),
      EmojiModel(
          name: 'money_credit_card',
          code: 'u{1f4b3}',
          emoji: Emojis.money_credit_card),
      EmojiModel(
          name: 'money_receipt', code: 'u{1f9fe}', emoji: Emojis.money_receipt),
      EmojiModel(
          name: 'money_chart_increasing_with_yen',
          code: 'u{1f4b9}',
          emoji: Emojis.money_chart_increasing_with_yen),
      EmojiModel(
          name: 'mail_envelope', code: 'u{2709}', emoji: Emojis.mail_envelope),
      EmojiModel(
          name: 'mail_e_mail', code: 'u{1f4e7}', emoji: Emojis.mail_e_mail),
      EmojiModel(
          name: 'mail_incoming_envelope',
          code: 'u{1f4e8}',
          emoji: Emojis.mail_incoming_envelope),
      EmojiModel(
          name: 'mail_envelope_with_arrow',
          code: 'u{1f4e9}',
          emoji: Emojis.mail_envelope_with_arrow),
      EmojiModel(
          name: 'mail_outbox_tray',
          code: 'u{1f4e4}',
          emoji: Emojis.mail_outbox_tray),
      EmojiModel(
          name: 'mail_inbox_tray',
          code: 'u{1f4e5}',
          emoji: Emojis.mail_inbox_tray),
      EmojiModel(
          name: 'mail_package', code: 'u{1f4e6}', emoji: Emojis.mail_package),
      EmojiModel(
          name: 'mail_closed_mailbox_with_raised_flag',
          code: 'u{1f4eb}',
          emoji: Emojis.mail_closed_mailbox_with_raised_flag),
      EmojiModel(
          name: 'mail_closed_mailbox_with_lowered_flag',
          code: 'u{1f4ea}',
          emoji: Emojis.mail_closed_mailbox_with_lowered_flag),
      EmojiModel(
          name: 'mail_open_mailbox_with_raised_flag',
          code: 'u{1f4ec}',
          emoji: Emojis.mail_open_mailbox_with_raised_flag),
      EmojiModel(
          name: 'mail_open_mailbox_with_lowered_flag',
          code: 'u{1f4ed}',
          emoji: Emojis.mail_open_mailbox_with_lowered_flag),
      EmojiModel(
          name: 'mail_postbox', code: 'u{1f4ee}', emoji: Emojis.mail_postbox),
      EmojiModel(
          name: 'mail_ballot_box_with_ballot',
          code: 'u{1f5f3}',
          emoji: Emojis.mail_ballot_box_with_ballot),
      EmojiModel(
          name: 'office_pencil', code: 'u{270f}', emoji: Emojis.office_pencil),
      EmojiModel(
          name: 'office_black_nib',
          code: 'u{2712}',
          emoji: Emojis.office_black_nib),
      EmojiModel(
          name: 'office_fountain_pen',
          code: 'u{1f58b}',
          emoji: Emojis.office_fountain_pen),
      EmojiModel(
          name: 'office_pen', code: 'u{1f58a}', emoji: Emojis.office_pen),
      EmojiModel(
          name: 'office_paintbrush',
          code: 'u{1f58c}',
          emoji: Emojis.office_paintbrush),
      EmojiModel(
          name: 'office_crayon', code: 'u{1f58d}', emoji: Emojis.office_crayon),
      EmojiModel(
          name: 'office_memo', code: 'u{1f4dd}', emoji: Emojis.office_memo),
      EmojiModel(
          name: 'office_briefcase',
          code: 'u{1f4bc}',
          emoji: Emojis.office_briefcase),
      EmojiModel(
          name: 'office_file_folder',
          code: 'u{1f4c1}',
          emoji: Emojis.office_file_folder),
      EmojiModel(
          name: 'office_open_file_folder',
          code: 'u{1f4c2}',
          emoji: Emojis.office_open_file_folder),
      EmojiModel(
          name: 'office_card_index_dividers',
          code: 'u{1f5c2}',
          emoji: Emojis.office_card_index_dividers),
      EmojiModel(
          name: 'office_calendar',
          code: 'u{1f4c5}',
          emoji: Emojis.office_calendar),
      EmojiModel(
          name: 'office_tear_off_calendar',
          code: 'u{1f4c6}',
          emoji: Emojis.office_tear_off_calendar),
      EmojiModel(
          name: 'office_spiral_notepad',
          code: 'u{1f5d2}',
          emoji: Emojis.office_spiral_notepad),
      EmojiModel(
          name: 'office_spiral_calendar',
          code: 'u{1f5d3}',
          emoji: Emojis.office_spiral_calendar),
      EmojiModel(
          name: 'office_card_index',
          code: 'u{1f4c7}',
          emoji: Emojis.office_card_index),
      EmojiModel(
          name: 'office_chart_increasing',
          code: 'u{1f4c8}',
          emoji: Emojis.office_chart_increasing),
      EmojiModel(
          name: 'office_chart_decreasing',
          code: 'u{1f4c9}',
          emoji: Emojis.office_chart_decreasing),
      EmojiModel(
          name: 'office_bar_chart',
          code: 'u{1f4ca}',
          emoji: Emojis.office_bar_chart),
      EmojiModel(
          name: 'office_clipboard',
          code: 'u{1f4cb}',
          emoji: Emojis.office_clipboard),
      EmojiModel(
          name: 'office_pushpin',
          code: 'u{1f4cc}',
          emoji: Emojis.office_pushpin),
      EmojiModel(
          name: 'office_round_pushpin',
          code: 'u{1f4cd}',
          emoji: Emojis.office_round_pushpin),
      EmojiModel(
          name: 'office_paperclip',
          code: 'u{1f4ce}',
          emoji: Emojis.office_paperclip),
      EmojiModel(
          name: 'office_linked_paperclips',
          code: 'u{1f587}',
          emoji: Emojis.office_linked_paperclips),
      EmojiModel(
          name: 'office_straight_ruler',
          code: 'u{1f4cf}',
          emoji: Emojis.office_straight_ruler),
      EmojiModel(
          name: 'office_triangular_ruler',
          code: 'u{1f4d0}',
          emoji: Emojis.office_triangular_ruler),
      EmojiModel(
          name: 'office_scissors',
          code: 'u{2702}',
          emoji: Emojis.office_scissors),
      EmojiModel(
          name: 'office_card_file_box',
          code: 'u{1f5c3}',
          emoji: Emojis.office_card_file_box),
      EmojiModel(
          name: 'office_file_cabinet',
          code: 'u{1f5c4}',
          emoji: Emojis.office_file_cabinet),
      EmojiModel(
          name: 'office_wastebasket',
          code: 'u{1f5d1}',
          emoji: Emojis.office_wastebasket),
      EmojiModel(
          name: 'lock_locked', code: 'u{1f512}', emoji: Emojis.lock_locked),
      EmojiModel(
          name: 'lock_unlocked', code: 'u{1f513}', emoji: Emojis.lock_unlocked),
      EmojiModel(
          name: 'lock_locked_with_pen',
          code: 'u{1f50f}',
          emoji: Emojis.lock_locked_with_pen),
      EmojiModel(
          name: 'lock_locked_with_key',
          code: 'u{1f510}',
          emoji: Emojis.lock_locked_with_key),
      EmojiModel(name: 'lock_key', code: 'u{1f511}', emoji: Emojis.lock_key),
      EmojiModel(
          name: 'lock_old_key', code: 'u{1f5dd}', emoji: Emojis.lock_old_key),
      EmojiModel(
          name: 'tool_hammer', code: 'u{1f528}', emoji: Emojis.tool_hammer),
      EmojiModel(name: 'tool_axe', code: 'u{1fa93}', emoji: Emojis.tool_axe),
      EmojiModel(name: 'tool_pick', code: 'u{26cf}', emoji: Emojis.tool_pick),
      EmojiModel(
          name: 'tool_hammer_and_pick',
          code: 'u{2692}',
          emoji: Emojis.tool_hammer_and_pick),
      EmojiModel(
          name: 'tool_hammer_and_wrench',
          code: 'u{1f6e0}',
          emoji: Emojis.tool_hammer_and_wrench),
      EmojiModel(
          name: 'tool_dagger', code: 'u{1f5e1}', emoji: Emojis.tool_dagger),
      EmojiModel(
          name: 'tool_crossed_swords',
          code: 'u{2694}',
          emoji: Emojis.tool_crossed_swords),
      EmojiModel(
          name: 'tool_water_pistol',
          code: 'u{1f52b}',
          emoji: Emojis.tool_water_pistol),
      EmojiModel(
          name: 'tool_boomerang',
          code: 'u{1fa83}',
          emoji: Emojis.tool_boomerang),
      EmojiModel(
          name: 'tool_bow_and_arrow',
          code: 'u{1f3f9}',
          emoji: Emojis.tool_bow_and_arrow),
      EmojiModel(
          name: 'tool_shield', code: 'u{1f6e1}', emoji: Emojis.tool_shield),
      EmojiModel(
          name: 'tool_carpentry_saw',
          code: 'u{1fa9a}',
          emoji: Emojis.tool_carpentry_saw),
      EmojiModel(
          name: 'tool_wrench', code: 'u{1f527}', emoji: Emojis.tool_wrench),
      EmojiModel(
          name: 'tool_screwdriver',
          code: 'u{1fa9b}',
          emoji: Emojis.tool_screwdriver),
      EmojiModel(
          name: 'tool_nut_and_bolt',
          code: 'u{1f529}',
          emoji: Emojis.tool_nut_and_bolt),
      EmojiModel(name: 'tool_gear', code: 'u{2699}', emoji: Emojis.tool_gear),
      EmojiModel(
          name: 'tool_clamp', code: 'u{1f5dc}', emoji: Emojis.tool_clamp),
      EmojiModel(
          name: 'tool_balance_scale',
          code: 'u{2696}',
          emoji: Emojis.tool_balance_scale),
      EmojiModel(
          name: 'tool_white_cane',
          code: 'u{1f9af}',
          emoji: Emojis.tool_white_cane),
      EmojiModel(name: 'tool_link', code: 'u{1f517}', emoji: Emojis.tool_link),
      EmojiModel(
          name: 'tool_chains', code: 'u{26d3}', emoji: Emojis.tool_chains),
      EmojiModel(name: 'tool_hook', code: 'u{1fa9d}', emoji: Emojis.tool_hook),
      EmojiModel(
          name: 'tool_toolbox', code: 'u{1f9f0}', emoji: Emojis.tool_toolbox),
      EmojiModel(
          name: 'tool_magnet', code: 'u{1f9f2}', emoji: Emojis.tool_magnet),
      EmojiModel(
          name: 'tool_ladder', code: 'u{1fa9c}', emoji: Emojis.tool_ladder),
      EmojiModel(
          name: 'tool_alembic', code: 'u{2697}', emoji: Emojis.tool_alembic),
      EmojiModel(
          name: 'science_test_tube',
          code: 'u{1f9ea}',
          emoji: Emojis.science_test_tube),
      EmojiModel(
          name: 'science_petri_dish',
          code: 'u{1f9eb}',
          emoji: Emojis.science_petri_dish),
      EmojiModel(
          name: 'science_dna', code: 'u{1f9ec}', emoji: Emojis.science_dna),
      EmojiModel(
          name: 'science_microscope',
          code: 'u{1f52c}',
          emoji: Emojis.science_microscope),
      EmojiModel(
          name: 'science_telescope',
          code: 'u{1f52d}',
          emoji: Emojis.science_telescope),
      EmojiModel(
          name: 'science_satellite_antenna',
          code: 'u{1f4e1}',
          emoji: Emojis.science_satellite_antenna),
      EmojiModel(
          name: 'medical_syringe',
          code: 'u{1f489}',
          emoji: Emojis.medical_syringe),
      EmojiModel(
          name: 'medical_drop_of_blood',
          code: 'u{1fa78}',
          emoji: Emojis.medical_drop_of_blood),
      EmojiModel(
          name: 'medical_pill', code: 'u{1f48a}', emoji: Emojis.medical_pill),
      EmojiModel(
          name: 'medical_adhesive_bandage',
          code: 'u{1fa79}',
          emoji: Emojis.medical_adhesive_bandage),
      EmojiModel(
          name: 'medical_stethoscope',
          code: 'u{1fa7a}',
          emoji: Emojis.medical_stethoscope),
      EmojiModel(
          name: 'household_door',
          code: 'u{1f6aa}',
          emoji: Emojis.household_door),
      EmojiModel(
          name: 'household_elevator',
          code: 'u{1f6d7}',
          emoji: Emojis.household_elevator),
      EmojiModel(
          name: 'household_mirror',
          code: 'u{1fa9e}',
          emoji: Emojis.household_mirror),
      EmojiModel(
          name: 'household_window',
          code: 'u{1fa9f}',
          emoji: Emojis.household_window),
      EmojiModel(
          name: 'household_bed', code: 'u{1f6cf}', emoji: Emojis.household_bed),
      EmojiModel(
          name: 'household_couch_and_lamp',
          code: 'u{1f6cb}',
          emoji: Emojis.household_couch_and_lamp),
      EmojiModel(
          name: 'household_chair',
          code: 'u{1fa91}',
          emoji: Emojis.household_chair),
      EmojiModel(
          name: 'household_toilet',
          code: 'u{1f6bd}',
          emoji: Emojis.household_toilet),
      EmojiModel(
          name: 'household_plunger',
          code: 'u{1faa0}',
          emoji: Emojis.household_plunger),
      EmojiModel(
          name: 'household_shower',
          code: 'u{1f6bf}',
          emoji: Emojis.household_shower),
      EmojiModel(
          name: 'household_bathtub',
          code: 'u{1f6c1}',
          emoji: Emojis.household_bathtub),
      EmojiModel(
          name: 'household_mouse_trap',
          code: 'u{1faa4}',
          emoji: Emojis.household_mouse_trap),
      EmojiModel(
          name: 'household_razor',
          code: 'u{1fa92}',
          emoji: Emojis.household_razor),
      EmojiModel(
          name: 'household_lotion_bottle',
          code: 'u{1f9f4}',
          emoji: Emojis.household_lotion_bottle),
      EmojiModel(
          name: 'household_safety_pin',
          code: 'u{1f9f7}',
          emoji: Emojis.household_safety_pin),
      EmojiModel(
          name: 'household_broom',
          code: 'u{1f9f9}',
          emoji: Emojis.household_broom),
      EmojiModel(
          name: 'household_basket',
          code: 'u{1f9fa}',
          emoji: Emojis.household_basket),
      EmojiModel(
          name: 'household_roll_of_paper',
          code: 'u{1f9fb}',
          emoji: Emojis.household_roll_of_paper),
      EmojiModel(
          name: 'household_bucket',
          code: 'u{1faa3}',
          emoji: Emojis.household_bucket),
      EmojiModel(
          name: 'household_soap',
          code: 'u{1f9fc}',
          emoji: Emojis.household_soap),
      EmojiModel(
          name: 'household_toothbrush',
          code: 'u{1faa5}',
          emoji: Emojis.household_toothbrush),
      EmojiModel(
          name: 'household_sponge',
          code: 'u{1f9fd}',
          emoji: Emojis.household_sponge),
      EmojiModel(
          name: 'household_fire_extinguisher',
          code: 'u{1f9ef}',
          emoji: Emojis.household_fire_extinguisher),
      EmojiModel(
          name: 'household_shopping_cart',
          code: 'u{1f6d2}',
          emoji: Emojis.household_shopping_cart),
      EmojiModel(
          name: 'object_cigarette',
          code: 'u{1f6ac}',
          emoji: Emojis.object_cigarette),
      EmojiModel(
          name: 'object_coffin', code: 'u{26b0}', emoji: Emojis.object_coffin),
      EmojiModel(
          name: 'object_headstone',
          code: 'u{1faa6}',
          emoji: Emojis.object_headstone),
      EmojiModel(
          name: 'object_funeral_urn',
          code: 'u{26b1}',
          emoji: Emojis.object_funeral_urn),
      EmojiModel(
          name: 'object_moai', code: 'u{1f5ff}', emoji: Emojis.object_moai),
      EmojiModel(
          name: 'object_placard',
          code: 'u{1faa7}',
          emoji: Emojis.object_placard),
      EmojiModel(
          name: 'symbols_atm_sign',
          code: 'u{1f3e7}',
          emoji: Emojis.symbols_atm_sign),
      EmojiModel(
          name: 'symbols_litter_in_bin_sign',
          code: 'u{1f6ae}',
          emoji: Emojis.symbols_litter_in_bin_sign),
      EmojiModel(
          name: 'symbols_potable_water',
          code: 'u{1f6b0}',
          emoji: Emojis.symbols_potable_water),
      EmojiModel(
          name: 'symbols_wheelchair_symbol',
          code: 'u{267f}',
          emoji: Emojis.symbols_wheelchair_symbol),
      EmojiModel(
          name: 'symbols_men_s_room',
          code: 'u{1f6b9}',
          emoji: Emojis.symbols_men_s_room),
      EmojiModel(
          name: 'symbols_women_s_room',
          code: 'u{1f6ba}',
          emoji: Emojis.symbols_women_s_room),
      EmojiModel(
          name: 'symbols_restroom',
          code: 'u{1f6bb}',
          emoji: Emojis.symbols_restroom),
      EmojiModel(
          name: 'symbols_baby_symbol',
          code: 'u{1f6bc}',
          emoji: Emojis.symbols_baby_symbol),
      EmojiModel(
          name: 'symbols_water_closet',
          code: 'u{1f6be}',
          emoji: Emojis.symbols_water_closet),
      EmojiModel(
          name: 'symbols_passport_control',
          code: 'u{1f6c2}',
          emoji: Emojis.symbols_passport_control),
      EmojiModel(
          name: 'symbols_customs',
          code: 'u{1f6c3}',
          emoji: Emojis.symbols_customs),
      EmojiModel(
          name: 'symbols_baggage_claim',
          code: 'u{1f6c4}',
          emoji: Emojis.symbols_baggage_claim),
      EmojiModel(
          name: 'symbols_left_luggage',
          code: 'u{1f6c5}',
          emoji: Emojis.symbols_left_luggage),
      EmojiModel(
          name: 'symbols_warning',
          code: 'u{26a0}',
          emoji: Emojis.symbols_warning),
      EmojiModel(
          name: 'symbols_children_crossing',
          code: 'u{1f6b8}',
          emoji: Emojis.symbols_children_crossing),
      EmojiModel(
          name: 'symbols_no_entry',
          code: 'u{26d4}',
          emoji: Emojis.symbols_no_entry),
      EmojiModel(
          name: 'symbols_prohibited',
          code: 'u{1f6ab}',
          emoji: Emojis.symbols_prohibited),
      EmojiModel(
          name: 'symbols_no_bicycles',
          code: 'u{1f6b3}',
          emoji: Emojis.symbols_no_bicycles),
      EmojiModel(
          name: 'symbols_no_smoking',
          code: 'u{1f6ad}',
          emoji: Emojis.symbols_no_smoking),
      EmojiModel(
          name: 'symbols_no_littering',
          code: 'u{1f6af}',
          emoji: Emojis.symbols_no_littering),
      EmojiModel(
          name: 'symbols_non_potable_water',
          code: 'u{1f6b1}',
          emoji: Emojis.symbols_non_potable_water),
      EmojiModel(
          name: 'symbols_no_pedestrians',
          code: 'u{1f6b7}',
          emoji: Emojis.symbols_no_pedestrians),
      EmojiModel(
          name: 'symbols_no_mobile_phones',
          code: 'u{1f4f5}',
          emoji: Emojis.symbols_no_mobile_phones),
      EmojiModel(
          name: 'symbols_no_one_under_eighteen',
          code: 'u{1f51e}',
          emoji: Emojis.symbols_no_one_under_eighteen),
      EmojiModel(
          name: 'symbols_radioactive',
          code: 'u{2622}',
          emoji: Emojis.symbols_radioactive),
      EmojiModel(
          name: 'symbols_biohazard',
          code: 'u{2623}',
          emoji: Emojis.symbols_biohazard),
      EmojiModel(
          name: 'symbols_up_arrow',
          code: 'u{2b06}',
          emoji: Emojis.symbols_up_arrow),
      EmojiModel(
          name: 'symbols_up_right_arrow',
          code: 'u{2197}',
          emoji: Emojis.symbols_up_right_arrow),
      EmojiModel(
          name: 'symbols_right_arrow',
          code: 'u{27a1}',
          emoji: Emojis.symbols_right_arrow),
      EmojiModel(
          name: 'symbols_down_right_arrow',
          code: 'u{2198}',
          emoji: Emojis.symbols_down_right_arrow),
      EmojiModel(
          name: 'symbols_down_arrow',
          code: 'u{2b07}',
          emoji: Emojis.symbols_down_arrow),
      EmojiModel(
          name: 'symbols_down_left_arrow',
          code: 'u{2199}',
          emoji: Emojis.symbols_down_left_arrow),
      EmojiModel(
          name: 'symbols_left_arrow',
          code: 'u{2b05}',
          emoji: Emojis.symbols_left_arrow),
      EmojiModel(
          name: 'symbols_up_left_arrow',
          code: 'u{2196}',
          emoji: Emojis.symbols_up_left_arrow),
      EmojiModel(
          name: 'symbols_up_down_arrow',
          code: 'u{2195}',
          emoji: Emojis.symbols_up_down_arrow),
      EmojiModel(
          name: 'symbols_left_right_arrow',
          code: 'u{2194}',
          emoji: Emojis.symbols_left_right_arrow),
      EmojiModel(
          name: 'symbols_right_arrow_curving_left',
          code: 'u{21a9}',
          emoji: Emojis.symbols_right_arrow_curving_left),
      EmojiModel(
          name: 'symbols_left_arrow_curving_right',
          code: 'u{21aa}',
          emoji: Emojis.symbols_left_arrow_curving_right),
      EmojiModel(
          name: 'symbols_right_arrow_curving_up',
          code: 'u{2934}',
          emoji: Emojis.symbols_right_arrow_curving_up),
      EmojiModel(
          name: 'symbols_right_arrow_curving_down',
          code: 'u{2935}',
          emoji: Emojis.symbols_right_arrow_curving_down),
      EmojiModel(
          name: 'symbols_clockwise_vertical_arrows',
          code: 'u{1f503}',
          emoji: Emojis.symbols_clockwise_vertical_arrows),
      EmojiModel(
          name: 'symbols_counterclockwise_arrows_button',
          code: 'u{1f504}',
          emoji: Emojis.symbols_counterclockwise_arrows_button),
      EmojiModel(
          name: 'symbols_back_arrow',
          code: 'u{1f519}',
          emoji: Emojis.symbols_back_arrow),
      EmojiModel(
          name: 'symbols_end_arrow',
          code: 'u{1f51a}',
          emoji: Emojis.symbols_end_arrow),
      EmojiModel(
          name: 'symbols_on_arrow',
          code: 'u{1f51b}',
          emoji: Emojis.symbols_on_arrow),
      EmojiModel(
          name: 'symbols_soon_arrow',
          code: 'u{1f51c}',
          emoji: Emojis.symbols_soon_arrow),
      EmojiModel(
          name: 'symbols_top_arrow',
          code: 'u{1f51d}',
          emoji: Emojis.symbols_top_arrow),
      EmojiModel(
          name: 'symbols_place_of_worship',
          code: 'u{1f6d0}',
          emoji: Emojis.symbols_place_of_worship),
      EmojiModel(
          name: 'symbols_atom_symbol',
          code: 'u{269b}',
          emoji: Emojis.symbols_atom_symbol),
      EmojiModel(
          name: 'symbols_om', code: 'u{1f549}', emoji: Emojis.symbols_om),
      EmojiModel(
          name: 'symbols_star_of_david',
          code: 'u{2721}',
          emoji: Emojis.symbols_star_of_david),
      EmojiModel(
          name: 'symbols_wheel_of_dharma',
          code: 'u{2638}',
          emoji: Emojis.symbols_wheel_of_dharma),
      EmojiModel(
          name: 'symbols_yin_yang',
          code: 'u{262f}',
          emoji: Emojis.symbols_yin_yang),
      EmojiModel(
          name: 'symbols_latin_cross',
          code: 'u{271d}',
          emoji: Emojis.symbols_latin_cross),
      EmojiModel(
          name: 'symbols_orthodox_cross',
          code: 'u{2626}',
          emoji: Emojis.symbols_orthodox_cross),
      EmojiModel(
          name: 'symbols_star_and_crescent',
          code: 'u{262a}',
          emoji: Emojis.symbols_star_and_crescent),
      EmojiModel(
          name: 'symbols_peace_symbol',
          code: 'u{262e}',
          emoji: Emojis.symbols_peace_symbol),
      EmojiModel(
          name: 'symbols_menorah',
          code: 'u{1f54e}',
          emoji: Emojis.symbols_menorah),
      EmojiModel(
          name: 'symbols_dotted_six_pointed_star',
          code: 'u{1f52f}',
          emoji: Emojis.symbols_dotted_six_pointed_star),
      EmojiModel(
          name: 'zodiac_aries', code: 'u{2648}', emoji: Emojis.zodiac_aries),
      EmojiModel(
          name: 'zodiac_taurus', code: 'u{2649}', emoji: Emojis.zodiac_taurus),
      EmojiModel(
          name: 'zodiac_gemini', code: 'u{264a}', emoji: Emojis.zodiac_gemini),
      EmojiModel(
          name: 'zodiac_cancer', code: 'u{264b}', emoji: Emojis.zodiac_cancer),
      EmojiModel(name: 'zodiac_leo', code: 'u{264c}', emoji: Emojis.zodiac_leo),
      EmojiModel(
          name: 'zodiac_virgo', code: 'u{264d}', emoji: Emojis.zodiac_virgo),
      EmojiModel(
          name: 'zodiac_libra', code: 'u{264e}', emoji: Emojis.zodiac_libra),
      EmojiModel(
          name: 'zodiac_scorpio',
          code: 'u{264f}',
          emoji: Emojis.zodiac_scorpio),
      EmojiModel(
          name: 'zodiac_sagittarius',
          code: 'u{2650}',
          emoji: Emojis.zodiac_sagittarius),
      EmojiModel(
          name: 'zodiac_capricorn',
          code: 'u{2651}',
          emoji: Emojis.zodiac_capricorn),
      EmojiModel(
          name: 'zodiac_aquarius',
          code: 'u{2652}',
          emoji: Emojis.zodiac_aquarius),
      EmojiModel(
          name: 'zodiac_pisces', code: 'u{2653}', emoji: Emojis.zodiac_pisces),
      EmojiModel(
          name: 'zodiac_ophiuchus',
          code: 'u{26ce}',
          emoji: Emojis.zodiac_ophiuchus),
      EmojiModel(
          name: 'symbols_shuffle_tracks_button',
          code: 'u{1f500}',
          emoji: Emojis.symbols_shuffle_tracks_button),
      EmojiModel(
          name: 'symbols_repeat_button',
          code: 'u{1f501}',
          emoji: Emojis.symbols_repeat_button),
      EmojiModel(
          name: 'symbols_repeat_single_button',
          code: 'u{1f502}',
          emoji: Emojis.symbols_repeat_single_button),
      EmojiModel(
          name: 'symbols_play_button',
          code: 'u{25b6}',
          emoji: Emojis.symbols_play_button),
      EmojiModel(
          name: 'symbols_fast_forward_button',
          code: 'u{23e9}',
          emoji: Emojis.symbols_fast_forward_button),
      EmojiModel(
          name: 'symbols_next_track_button',
          code: 'u{23ed}',
          emoji: Emojis.symbols_next_track_button),
      EmojiModel(
          name: 'symbols_play_or_pause_button',
          code: 'u{23ef}',
          emoji: Emojis.symbols_play_or_pause_button),
      EmojiModel(
          name: 'symbols_reverse_button',
          code: 'u{25c0}',
          emoji: Emojis.symbols_reverse_button),
      EmojiModel(
          name: 'symbols_fast_reverse_button',
          code: 'u{23ea}',
          emoji: Emojis.symbols_fast_reverse_button),
      EmojiModel(
          name: 'symbols_last_track_button',
          code: 'u{23ee}',
          emoji: Emojis.symbols_last_track_button),
      EmojiModel(
          name: 'symbols_upwards_button',
          code: 'u{1f53c}',
          emoji: Emojis.symbols_upwards_button),
      EmojiModel(
          name: 'symbols_fast_up_button',
          code: 'u{23eb}',
          emoji: Emojis.symbols_fast_up_button),
      EmojiModel(
          name: 'symbols_downwards_button',
          code: 'u{1f53d}',
          emoji: Emojis.symbols_downwards_button),
      EmojiModel(
          name: 'symbols_fast_down_button',
          code: 'u{23ec}',
          emoji: Emojis.symbols_fast_down_button),
      EmojiModel(
          name: 'symbols_pause_button',
          code: 'u{23f8}',
          emoji: Emojis.symbols_pause_button),
      EmojiModel(
          name: 'symbols_stop_button',
          code: 'u{23f9}',
          emoji: Emojis.symbols_stop_button),
      EmojiModel(
          name: 'symbols_record_button',
          code: 'u{23fa}',
          emoji: Emojis.symbols_record_button),
      EmojiModel(
          name: 'symbols_eject_button',
          code: 'u{23cf}',
          emoji: Emojis.symbols_eject_button),
      EmojiModel(
          name: 'symbols_cinema',
          code: 'u{1f3a6}',
          emoji: Emojis.symbols_cinema),
      EmojiModel(
          name: 'symbols_dim_button',
          code: 'u{1f505}',
          emoji: Emojis.symbols_dim_button),
      EmojiModel(
          name: 'symbols_bright_button',
          code: 'u{1f506}',
          emoji: Emojis.symbols_bright_button),
      EmojiModel(
          name: 'symbols_antenna_bars',
          code: 'u{1f4f6}',
          emoji: Emojis.symbols_antenna_bars),
      EmojiModel(
          name: 'symbols_vibration_mode',
          code: 'u{1f4f3}',
          emoji: Emojis.symbols_vibration_mode),
      EmojiModel(
          name: 'symbols_mobile_phone_off',
          code: 'u{1f4f4}',
          emoji: Emojis.symbols_mobile_phone_off),
      EmojiModel(
          name: 'symbols_female_sign',
          code: 'u{2640}',
          emoji: Emojis.symbols_female_sign),
      EmojiModel(
          name: 'symbols_male_sign',
          code: 'u{2642}',
          emoji: Emojis.symbols_male_sign),
      EmojiModel(
          name: 'symbols_transgender_symbol',
          code: 'u{26a7}',
          emoji: Emojis.symbols_transgender_symbol),
      EmojiModel(
          name: 'symbols_multiply',
          code: 'u{2716}',
          emoji: Emojis.symbols_multiply),
      EmojiModel(
          name: 'symbols_plus', code: 'u{2795}', emoji: Emojis.symbols_plus),
      EmojiModel(
          name: 'symbols_minus', code: 'u{2796}', emoji: Emojis.symbols_minus),
      EmojiModel(
          name: 'symbols_divide',
          code: 'u{2797}',
          emoji: Emojis.symbols_divide),
      EmojiModel(
          name: 'symbols_infinity',
          code: 'u{267e}',
          emoji: Emojis.symbols_infinity),
      EmojiModel(
          name: 'symbols_double_exclamation_mark',
          code: 'u{203c}',
          emoji: Emojis.symbols_double_exclamation_mark),
      EmojiModel(
          name: 'symbols_exclamation_question_mark',
          code: 'u{2049}',
          emoji: Emojis.symbols_exclamation_question_mark),
      EmojiModel(
          name: 'symbols_red_question_mark',
          code: 'u{2753}',
          emoji: Emojis.symbols_red_question_mark),
      EmojiModel(
          name: 'symbols_white_question_mark',
          code: 'u{2754}',
          emoji: Emojis.symbols_white_question_mark),
      EmojiModel(
          name: 'symbols_white_exclamation_mark',
          code: 'u{2755}',
          emoji: Emojis.symbols_white_exclamation_mark),
      EmojiModel(
          name: 'symbols_red_exclamation_mark',
          code: 'u{2757}',
          emoji: Emojis.symbols_red_exclamation_mark),
      EmojiModel(
          name: 'symbols_wavy_dash',
          code: 'u{3030}',
          emoji: Emojis.symbols_wavy_dash),
      EmojiModel(
          name: 'symbols_currency_exchange',
          code: 'u{1f4b1}',
          emoji: Emojis.symbols_currency_exchange),
      EmojiModel(
          name: 'symbols_heavy_dollar_sign',
          code: 'u{1f4b2}',
          emoji: Emojis.symbols_heavy_dollar_sign),
      EmojiModel(
          name: 'symbols_medical_symbol',
          code: 'u{2695}',
          emoji: Emojis.symbols_medical_symbol),
      EmojiModel(
          name: 'symbols_recycling_symbol',
          code: 'u{267b}',
          emoji: Emojis.symbols_recycling_symbol),
      EmojiModel(
          name: 'symbols_fleur_de_lis',
          code: 'u{269c}',
          emoji: Emojis.symbols_fleur_de_lis),
      EmojiModel(
          name: 'symbols_trident_emblem',
          code: 'u{1f531}',
          emoji: Emojis.symbols_trident_emblem),
      EmojiModel(
          name: 'symbols_name_badge',
          code: 'u{1f4db}',
          emoji: Emojis.symbols_name_badge),
      EmojiModel(
          name: 'symbols_japanese_symbol_for_beginner',
          code: 'u{1f530}',
          emoji: Emojis.symbols_japanese_symbol_for_beginner),
      EmojiModel(
          name: 'symbols_hollow_red_circle',
          code: 'u{2b55}',
          emoji: Emojis.symbols_hollow_red_circle),
      EmojiModel(
          name: 'symbols_check_mark_button',
          code: 'u{2705}',
          emoji: Emojis.symbols_check_mark_button),
      EmojiModel(
          name: 'symbols_check_box_with_check',
          code: 'u{2611}',
          emoji: Emojis.symbols_check_box_with_check),
      EmojiModel(
          name: 'symbols_check_mark',
          code: 'u{2714}',
          emoji: Emojis.symbols_check_mark),
      EmojiModel(
          name: 'symbols_cross_mark',
          code: 'u{274c}',
          emoji: Emojis.symbols_cross_mark),
      EmojiModel(
          name: 'symbols_cross_mark_button',
          code: 'u{274e}',
          emoji: Emojis.symbols_cross_mark_button),
      EmojiModel(
          name: 'symbols_curly_loop',
          code: 'u{27b0}',
          emoji: Emojis.symbols_curly_loop),
      EmojiModel(
          name: 'symbols_double_curly_loop',
          code: 'u{27bf}',
          emoji: Emojis.symbols_double_curly_loop),
      EmojiModel(
          name: 'symbols_part_alternation_mark',
          code: 'u{303d}',
          emoji: Emojis.symbols_part_alternation_mark),
      EmojiModel(
          name: 'symbols_eight_spoked_asterisk',
          code: 'u{2733}',
          emoji: Emojis.symbols_eight_spoked_asterisk),
      EmojiModel(
          name: 'symbols_eight_pointed_star',
          code: 'u{2734}',
          emoji: Emojis.symbols_eight_pointed_star),
      EmojiModel(
          name: 'symbols_sparkle',
          code: 'u{2747}',
          emoji: Emojis.symbols_sparkle),
      EmojiModel(
          name: 'symbols_copyright',
          code: 'u{00a9}',
          emoji: Emojis.symbols_copyright),
      EmojiModel(
          name: 'symbols_registered',
          code: 'u{00ae}',
          emoji: Emojis.symbols_registered),
      EmojiModel(
          name: 'symbols_trade_mark',
          code: 'u{2122}',
          emoji: Emojis.symbols_trade_mark),
      EmojiModel(
          name: 'symbols_keycap',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap),
      EmojiModel(
          name: 'symbols_keycap_0',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_0),
      EmojiModel(
          name: 'symbols_keycap_1',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_1),
      EmojiModel(
          name: 'symbols_keycap_2',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_2),
      EmojiModel(
          name: 'symbols_keycap_3',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_3),
      EmojiModel(
          name: 'symbols_keycap_4',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_4),
      EmojiModel(
          name: 'symbols_keycap_5',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_5),
      EmojiModel(
          name: 'symbols_keycap_6',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_6),
      EmojiModel(
          name: 'symbols_keycap_7',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_7),
      EmojiModel(
          name: 'symbols_keycap_8',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_8),
      EmojiModel(
          name: 'symbols_keycap_9',
          code: 'u{fe0f}',
          emoji: Emojis.symbols_keycap_9),
      EmojiModel(
          name: 'symbols_keycap_10',
          code: 'u{1f51f}',
          emoji: Emojis.symbols_keycap_10),
      EmojiModel(
          name: 'symbols_input_latin_uppercase',
          code: 'u{1f520}',
          emoji: Emojis.symbols_input_latin_uppercase),
      EmojiModel(
          name: 'symbols_input_latin_lowercase',
          code: 'u{1f521}',
          emoji: Emojis.symbols_input_latin_lowercase),
      EmojiModel(
          name: 'symbols_input_numbers',
          code: 'u{1f522}',
          emoji: Emojis.symbols_input_numbers),
      EmojiModel(
          name: 'symbols_input_symbols',
          code: 'u{1f523}',
          emoji: Emojis.symbols_input_symbols),
      EmojiModel(
          name: 'symbols_input_latin_letters',
          code: 'u{1f524}',
          emoji: Emojis.symbols_input_latin_letters),
      EmojiModel(
          name: 'symbols_a_blood_type',
          code: 'u{1f170}',
          emoji: Emojis.symbols_a_blood_type),
      EmojiModel(
          name: 'symbols_ab_blood_type',
          code: 'u{1f18e}',
          emoji: Emojis.symbols_ab_blood_type),
      EmojiModel(
          name: 'symbols_b_blood_type',
          code: 'u{1f171}',
          emoji: Emojis.symbols_b_blood_type),
      EmojiModel(
          name: 'symbols_cl_button',
          code: 'u{1f191}',
          emoji: Emojis.symbols_cl_button),
      EmojiModel(
          name: 'symbols_cool_button',
          code: 'u{1f192}',
          emoji: Emojis.symbols_cool_button),
      EmojiModel(
          name: 'symbols_free_button',
          code: 'u{1f193}',
          emoji: Emojis.symbols_free_button),
      EmojiModel(
          name: 'symbols_information',
          code: 'u{2139}',
          emoji: Emojis.symbols_information),
      EmojiModel(
          name: 'symbols_id_button',
          code: 'u{1f194}',
          emoji: Emojis.symbols_id_button),
      EmojiModel(
          name: 'symbols_circled_m',
          code: 'u{24c2}',
          emoji: Emojis.symbols_circled_m),
      EmojiModel(
          name: 'symbols_new_button',
          code: 'u{1f195}',
          emoji: Emojis.symbols_new_button),
      EmojiModel(
          name: 'symbols_ng_button',
          code: 'u{1f196}',
          emoji: Emojis.symbols_ng_button),
      EmojiModel(
          name: 'symbols_o_button',
          code: 'u{1f17e}',
          emoji: Emojis.symbols_o_button),
      EmojiModel(
          name: 'symbols_ok_button',
          code: 'u{1f197}',
          emoji: Emojis.symbols_ok_button),
      EmojiModel(
          name: 'symbols_p_button',
          code: 'u{1f17f}',
          emoji: Emojis.symbols_p_button),
      EmojiModel(
          name: 'symbols_sos_button',
          code: 'u{1f198}',
          emoji: Emojis.symbols_sos_button),
      EmojiModel(
          name: 'symbols_up_button',
          code: 'u{1f199}',
          emoji: Emojis.symbols_up_button),
      EmojiModel(
          name: 'symbols_vs_button',
          code: 'u{1f19a}',
          emoji: Emojis.symbols_vs_button),
      EmojiModel(
          name: 'japanese_here_button',
          code: 'u{1f201}',
          emoji: Emojis.japanese_here_button),
      EmojiModel(
          name: 'japanese_service_charge_button',
          code: 'u{1f202}',
          emoji: Emojis.japanese_service_charge_button),
      EmojiModel(
          name: 'japanese_monthly_amount_button',
          code: 'u{1f237}',
          emoji: Emojis.japanese_monthly_amount_button),
      EmojiModel(
          name: 'japanese_not_free_of_charge_button',
          code: 'u{1f236}',
          emoji: Emojis.japanese_not_free_of_charge_button),
      EmojiModel(
          name: 'japanese_reserved_button',
          code: 'u{1f22f}',
          emoji: Emojis.japanese_reserved_button),
      EmojiModel(
          name: 'japanese_bargain_button',
          code: 'u{1f250}',
          emoji: Emojis.japanese_bargain_button),
      EmojiModel(
          name: 'japanese_discount_button',
          code: 'u{1f239}',
          emoji: Emojis.japanese_discount_button),
      EmojiModel(
          name: 'japanese_free_of_charge_button',
          code: 'u{1f21a}',
          emoji: Emojis.japanese_free_of_charge_button),
      EmojiModel(
          name: 'japanese_prohibited_button',
          code: 'u{1f232}',
          emoji: Emojis.japanese_prohibited_button),
      EmojiModel(
          name: 'japanese_acceptable_button',
          code: 'u{1f251}',
          emoji: Emojis.japanese_acceptable_button),
      EmojiModel(
          name: 'japanese_application_button',
          code: 'u{1f238}',
          emoji: Emojis.japanese_application_button),
      EmojiModel(
          name: 'japanese_passing_grade_button',
          code: 'u{1f234}',
          emoji: Emojis.japanese_passing_grade_button),
      EmojiModel(
          name: 'japanese_vacancy_button',
          code: 'u{1f233}',
          emoji: Emojis.japanese_vacancy_button),
      EmojiModel(
          name: 'japanese_congratulations_button',
          code: 'u{3297}',
          emoji: Emojis.japanese_congratulations_button),
      EmojiModel(
          name: 'japanese_secret_button',
          code: 'u{3299}',
          emoji: Emojis.japanese_secret_button),
      EmojiModel(
          name: 'japanese_open_for_business_button',
          code: 'u{1f23a}',
          emoji: Emojis.japanese_open_for_business_button),
      EmojiModel(
          name: 'japanese_no_vacancy_button',
          code: 'u{1f235}',
          emoji: Emojis.japanese_no_vacancy_button),
      EmojiModel(
          name: 'shape_red_circle',
          code: 'u{1f534}',
          emoji: Emojis.shape_red_circle),
      EmojiModel(
          name: 'shape_orange_circle',
          code: 'u{1f7e0}',
          emoji: Emojis.shape_orange_circle),
      EmojiModel(
          name: 'shape_yellow_circle',
          code: 'u{1f7e1}',
          emoji: Emojis.shape_yellow_circle),
      EmojiModel(
          name: 'shape_green_circle',
          code: 'u{1f7e2}',
          emoji: Emojis.shape_green_circle),
      EmojiModel(
          name: 'shape_blue_circle',
          code: 'u{1f535}',
          emoji: Emojis.shape_blue_circle),
      EmojiModel(
          name: 'shape_purple_circle',
          code: 'u{1f7e3}',
          emoji: Emojis.shape_purple_circle),
      EmojiModel(
          name: 'shape_brown_circle',
          code: 'u{1f7e4}',
          emoji: Emojis.shape_brown_circle),
      EmojiModel(
          name: 'shape_black_circle',
          code: 'u{26ab}',
          emoji: Emojis.shape_black_circle),
      EmojiModel(
          name: 'shape_white_circle',
          code: 'u{26aa}',
          emoji: Emojis.shape_white_circle),
      EmojiModel(
          name: 'shape_red_square',
          code: 'u{1f7e5}',
          emoji: Emojis.shape_red_square),
      EmojiModel(
          name: 'shape_orange_square',
          code: 'u{1f7e7}',
          emoji: Emojis.shape_orange_square),
      EmojiModel(
          name: 'shape_yellow_square',
          code: 'u{1f7e8}',
          emoji: Emojis.shape_yellow_square),
      EmojiModel(
          name: 'shape_green_square',
          code: 'u{1f7e9}',
          emoji: Emojis.shape_green_square),
      EmojiModel(
          name: 'shape_blue_square',
          code: 'u{1f7e6}',
          emoji: Emojis.shape_blue_square),
      EmojiModel(
          name: 'shape_purple_square',
          code: 'u{1f7ea}',
          emoji: Emojis.shape_purple_square),
      EmojiModel(
          name: 'shape_brown_square',
          code: 'u{1f7eb}',
          emoji: Emojis.shape_brown_square),
      EmojiModel(
          name: 'shape_black_large_square',
          code: 'u{2b1b}',
          emoji: Emojis.shape_black_large_square),
      EmojiModel(
          name: 'shape_white_large_square',
          code: 'u{2b1c}',
          emoji: Emojis.shape_white_large_square),
      EmojiModel(
          name: 'shape_black_medium_square',
          code: 'u{25fc}',
          emoji: Emojis.shape_black_medium_square),
      EmojiModel(
          name: 'shape_white_medium_square',
          code: 'u{25fb}',
          emoji: Emojis.shape_white_medium_square),
      EmojiModel(
          name: 'shape_black_medium_small_square',
          code: 'u{25fe}',
          emoji: Emojis.shape_black_medium_small_square),
      EmojiModel(
          name: 'shape_white_medium_small_square',
          code: 'u{25fd}',
          emoji: Emojis.shape_white_medium_small_square),
      EmojiModel(
          name: 'shape_black_small_square',
          code: 'u{25aa}',
          emoji: Emojis.shape_black_small_square),
      EmojiModel(
          name: 'shape_white_small_square',
          code: 'u{25ab}',
          emoji: Emojis.shape_white_small_square),
      EmojiModel(
          name: 'shape_large_orange_diamond',
          code: 'u{1f536}',
          emoji: Emojis.shape_large_orange_diamond),
      EmojiModel(
          name: 'shape_large_blue_diamond',
          code: 'u{1f537}',
          emoji: Emojis.shape_large_blue_diamond),
      EmojiModel(
          name: 'shape_small_orange_diamond',
          code: 'u{1f538}',
          emoji: Emojis.shape_small_orange_diamond),
      EmojiModel(
          name: 'shape_small_blue_diamond',
          code: 'u{1f539}',
          emoji: Emojis.shape_small_blue_diamond),
      EmojiModel(
          name: 'shape_red_triangle_pointed_up',
          code: 'u{1f53a}',
          emoji: Emojis.shape_red_triangle_pointed_up),
      EmojiModel(
          name: 'shape_red_triangle_pointed_down',
          code: 'u{1f53b}',
          emoji: Emojis.shape_red_triangle_pointed_down),
      EmojiModel(
          name: 'shape_diamond_with_a_dot',
          code: 'u{1f4a0}',
          emoji: Emojis.shape_diamond_with_a_dot),
      EmojiModel(
          name: 'shape_radio_button',
          code: 'u{1f518}',
          emoji: Emojis.shape_radio_button),
      EmojiModel(
          name: 'shape_white_square_button',
          code: 'u{1f533}',
          emoji: Emojis.shape_white_square_button),
      EmojiModel(
          name: 'shape_black_square_button',
          code: 'u{1f532}',
          emoji: Emojis.shape_black_square_button),
      EmojiModel(
          name: 'flag_chequered_flag',
          code: 'u{1f3c1}',
          emoji: Emojis.flag_chequered_flag),
      EmojiModel(
          name: 'flag_triangular_flag',
          code: 'u{1f6a9}',
          emoji: Emojis.flag_triangular_flag),
      EmojiModel(
          name: 'flag_crossed_flags',
          code: 'u{1f38c}',
          emoji: Emojis.flag_crossed_flags),
      EmojiModel(
          name: 'flag_black_flag',
          code: 'u{1f3f4}',
          emoji: Emojis.flag_black_flag),
      EmojiModel(
          name: 'flag_white_flag',
          code: 'u{1f3f3}',
          emoji: Emojis.flag_white_flag),
      EmojiModel(
          name: 'flag_transgender_flag',
          code: 'u{fe0f}',
          emoji: Emojis.flag_transgender_flag),
      EmojiModel(
          name: 'flag_pirate_flag',
          code: 'u{fe0f}',
          emoji: Emojis.flag_pirate_flag),
      EmojiModel(
          name: 'flag_ascension_island',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_ascension_island),
      EmojiModel(
          name: 'flag_andorra', code: 'u{1f1e6}', emoji: Emojis.flag_andorra),
      EmojiModel(
          name: 'flag_united_arab_emirates',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_united_arab_emirates),
      EmojiModel(
          name: 'flag_afghanistan',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_afghanistan),
      EmojiModel(
          name: 'flag_antigua_barbuda',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_antigua_barbuda),
      EmojiModel(
          name: 'flag_anguilla', code: 'u{1f1e6}', emoji: Emojis.flag_anguilla),
      EmojiModel(
          name: 'flag_albania', code: 'u{1f1e6}', emoji: Emojis.flag_albania),
      EmojiModel(
          name: 'flag_armenia', code: 'u{1f1e6}', emoji: Emojis.flag_armenia),
      EmojiModel(
          name: 'flag_angola', code: 'u{1f1e6}', emoji: Emojis.flag_angola),
      EmojiModel(
          name: 'flag_antarctica',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_antarctica),
      EmojiModel(
          name: 'flag_argentina',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_argentina),
      EmojiModel(
          name: 'flag_american_samoa',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_american_samoa),
      EmojiModel(
          name: 'flag_austria', code: 'u{1f1e6}', emoji: Emojis.flag_austria),
      EmojiModel(
          name: 'flag_australia',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_australia),
      EmojiModel(
          name: 'flag_aruba', code: 'u{1f1e6}', emoji: Emojis.flag_aruba),
      EmojiModel(
          name: 'flag_aland_islands',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_aland_islands),
      EmojiModel(
          name: 'flag_azerbaijan',
          code: 'u{1f1e6}',
          emoji: Emojis.flag_azerbaijan),
      EmojiModel(
          name: 'flag_bosnia_herzegovina',
          code: 'u{1f1e7}',
          emoji: Emojis.flag_bosnia_herzegovina),
      EmojiModel(
          name: 'flag_barbados', code: 'u{1f1e7}', emoji: Emojis.flag_barbados),
      EmojiModel(
          name: 'flag_bangladesh',
          code: 'u{1f1e7}',
          emoji: Emojis.flag_bangladesh),
      EmojiModel(
          name: 'flag_belgium', code: 'u{1f1e7}', emoji: Emojis.flag_belgium),
      EmojiModel(
          name: 'flag_burkina_faso',
          code: 'u{1f1e7}',
          emoji: Emojis.flag_burkina_faso),
      EmojiModel(
          name: 'flag_bulgaria', code: 'u{1f1e7}', emoji: Emojis.flag_bulgaria),
      EmojiModel(
          name: 'flag_bahrain', code: 'u{1f1e7}', emoji: Emojis.flag_bahrain),
      EmojiModel(
          name: 'flag_burundi', code: 'u{1f1e7}', emoji: Emojis.flag_burundi),
      EmojiModel(
          name: 'flag_benin', code: 'u{1f1e7}', emoji: Emojis.flag_benin),
      EmojiModel(
          name: 'flag_st_barthelemy',
          code: 'u{1f1e7}',
          emoji: Emojis.flag_st_barthelemy),
      EmojiModel(
          name: 'flag_bermuda', code: 'u{1f1e7}', emoji: Emojis.flag_bermuda),
      EmojiModel(
          name: 'flag_brunei', code: 'u{1f1e7}', emoji: Emojis.flag_brunei),
      EmojiModel(
          name: 'flag_bolivia', code: 'u{1f1e7}', emoji: Emojis.flag_bolivia),
      EmojiModel(
          name: 'flag_caribbean_netherlands',
          code: 'u{1f1e7}',
          emoji: Emojis.flag_caribbean_netherlands),
      EmojiModel(
          name: 'flag_brazil', code: 'u{1f1e7}', emoji: Emojis.flag_brazil),
      EmojiModel(
          name: 'flag_bahamas', code: 'u{1f1e7}', emoji: Emojis.flag_bahamas),
      EmojiModel(
          name: 'flag_bhutan', code: 'u{1f1e7}', emoji: Emojis.flag_bhutan),
      EmojiModel(
          name: 'flag_bouvet_island',
          code: 'u{1f1e7}',
          emoji: Emojis.flag_bouvet_island),
      EmojiModel(
          name: 'flag_botswana', code: 'u{1f1e7}', emoji: Emojis.flag_botswana),
      EmojiModel(
          name: 'flag_belarus', code: 'u{1f1e7}', emoji: Emojis.flag_belarus),
      EmojiModel(
          name: 'flag_belize', code: 'u{1f1e7}', emoji: Emojis.flag_belize),
      EmojiModel(
          name: 'flag_canada', code: 'u{1f1e8}', emoji: Emojis.flag_canada),
      EmojiModel(
          name: 'flag_cocos_keeling_islands',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_cocos_keeling_islands),
      EmojiModel(
          name: 'flag_congo_kinshasa',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_congo_kinshasa),
      EmojiModel(
          name: 'flag_central_african_republic',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_central_african_republic),
      EmojiModel(
          name: 'flag_congo_brazzaville',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_congo_brazzaville),
      EmojiModel(
          name: 'flag_switzerland',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_switzerland),
      EmojiModel(
          name: 'flag_cote_d_ivoire',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_cote_d_ivoire),
      EmojiModel(
          name: 'flag_cook_islands',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_cook_islands),
      EmojiModel(
          name: 'flag_chile', code: 'u{1f1e8}', emoji: Emojis.flag_chile),
      EmojiModel(
          name: 'flag_cameroon', code: 'u{1f1e8}', emoji: Emojis.flag_cameroon),
      EmojiModel(
          name: 'flag_china', code: 'u{1f1e8}', emoji: Emojis.flag_china),
      EmojiModel(
          name: 'flag_colombia', code: 'u{1f1e8}', emoji: Emojis.flag_colombia),
      EmojiModel(
          name: 'flag_clipperton_island',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_clipperton_island),
      EmojiModel(
          name: 'flag_costa_rica',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_costa_rica),
      EmojiModel(name: 'flag_cuba', code: 'u{1f1e8}', emoji: Emojis.flag_cuba),
      EmojiModel(
          name: 'flag_cape_verde',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_cape_verde),
      EmojiModel(
          name: 'flag_curacao', code: 'u{1f1e8}', emoji: Emojis.flag_curacao),
      EmojiModel(
          name: 'flag_christmas_island',
          code: 'u{1f1e8}',
          emoji: Emojis.flag_christmas_island),
      EmojiModel(
          name: 'flag_cyprus', code: 'u{1f1e8}', emoji: Emojis.flag_cyprus),
      EmojiModel(
          name: 'flag_czechia', code: 'u{1f1e8}', emoji: Emojis.flag_czechia),
      EmojiModel(
          name: 'flag_germany', code: 'u{1f1e9}', emoji: Emojis.flag_germany),
      EmojiModel(
          name: 'flag_diego_garcia',
          code: 'u{1f1e9}',
          emoji: Emojis.flag_diego_garcia),
      EmojiModel(
          name: 'flag_djibouti', code: 'u{1f1e9}', emoji: Emojis.flag_djibouti),
      EmojiModel(
          name: 'flag_denmark', code: 'u{1f1e9}', emoji: Emojis.flag_denmark),
      EmojiModel(
          name: 'flag_dominica', code: 'u{1f1e9}', emoji: Emojis.flag_dominica),
      EmojiModel(
          name: 'flag_dominican_republic',
          code: 'u{1f1e9}',
          emoji: Emojis.flag_dominican_republic),
      EmojiModel(
          name: 'flag_algeria', code: 'u{1f1e9}', emoji: Emojis.flag_algeria),
      EmojiModel(
          name: 'flag_ceuta_melilla',
          code: 'u{1f1ea}',
          emoji: Emojis.flag_ceuta_melilla),
      EmojiModel(
          name: 'flag_ecuador', code: 'u{1f1ea}', emoji: Emojis.flag_ecuador),
      EmojiModel(
          name: 'flag_estonia', code: 'u{1f1ea}', emoji: Emojis.flag_estonia),
      EmojiModel(
          name: 'flag_egypt', code: 'u{1f1ea}', emoji: Emojis.flag_egypt),
      EmojiModel(
          name: 'flag_western_sahara',
          code: 'u{1f1ea}',
          emoji: Emojis.flag_western_sahara),
      EmojiModel(
          name: 'flag_eritrea', code: 'u{1f1ea}', emoji: Emojis.flag_eritrea),
      EmojiModel(
          name: 'flag_spain', code: 'u{1f1ea}', emoji: Emojis.flag_spain),
      EmojiModel(
          name: 'flag_ethiopia', code: 'u{1f1ea}', emoji: Emojis.flag_ethiopia),
      EmojiModel(
          name: 'flag_european_union',
          code: 'u{1f1ea}',
          emoji: Emojis.flag_european_union),
      EmojiModel(
          name: 'flag_finland', code: 'u{1f1eb}', emoji: Emojis.flag_finland),
      EmojiModel(name: 'flag_fiji', code: 'u{1f1eb}', emoji: Emojis.flag_fiji),
      EmojiModel(
          name: 'flag_falkland_islands',
          code: 'u{1f1eb}',
          emoji: Emojis.flag_falkland_islands),
      EmojiModel(
          name: 'flag_micronesia',
          code: 'u{1f1eb}',
          emoji: Emojis.flag_micronesia),
      EmojiModel(
          name: 'flag_faroe_islands',
          code: 'u{1f1eb}',
          emoji: Emojis.flag_faroe_islands),
      EmojiModel(
          name: 'flag_france', code: 'u{1f1eb}', emoji: Emojis.flag_france),
      EmojiModel(
          name: 'flag_gabon', code: 'u{1f1ec}', emoji: Emojis.flag_gabon),
      EmojiModel(
          name: 'flag_united_kingdom',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_united_kingdom),
      EmojiModel(
          name: 'flag_grenada', code: 'u{1f1ec}', emoji: Emojis.flag_grenada),
      EmojiModel(
          name: 'flag_georgia', code: 'u{1f1ec}', emoji: Emojis.flag_georgia),
      EmojiModel(
          name: 'flag_french_guiana',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_french_guiana),
      EmojiModel(
          name: 'flag_guernsey', code: 'u{1f1ec}', emoji: Emojis.flag_guernsey),
      EmojiModel(
          name: 'flag_ghana', code: 'u{1f1ec}', emoji: Emojis.flag_ghana),
      EmojiModel(
          name: 'flag_gibraltar',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_gibraltar),
      EmojiModel(
          name: 'flag_greenland',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_greenland),
      EmojiModel(
          name: 'flag_gambia', code: 'u{1f1ec}', emoji: Emojis.flag_gambia),
      EmojiModel(
          name: 'flag_guinea', code: 'u{1f1ec}', emoji: Emojis.flag_guinea),
      EmojiModel(
          name: 'flag_guadeloupe',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_guadeloupe),
      EmojiModel(
          name: 'flag_equatorial_guinea',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_equatorial_guinea),
      EmojiModel(
          name: 'flag_greece', code: 'u{1f1ec}', emoji: Emojis.flag_greece),
      EmojiModel(
          name: 'flag_south_georgia_south_sandwich_islands',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_south_georgia_south_sandwich_islands),
      EmojiModel(
          name: 'flag_guatemala',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_guatemala),
      EmojiModel(name: 'flag_guam', code: 'u{1f1ec}', emoji: Emojis.flag_guam),
      EmojiModel(
          name: 'flag_guinea_bissau',
          code: 'u{1f1ec}',
          emoji: Emojis.flag_guinea_bissau),
      EmojiModel(
          name: 'flag_guyana', code: 'u{1f1ec}', emoji: Emojis.flag_guyana),
      EmojiModel(
          name: 'flag_hong_kong_sar_china',
          code: 'u{1f1ed}',
          emoji: Emojis.flag_hong_kong_sar_china),
      EmojiModel(
          name: 'flag_heard_mcdonald_islands',
          code: 'u{1f1ed}',
          emoji: Emojis.flag_heard_mcdonald_islands),
      EmojiModel(
          name: 'flag_honduras', code: 'u{1f1ed}', emoji: Emojis.flag_honduras),
      EmojiModel(
          name: 'flag_croatia', code: 'u{1f1ed}', emoji: Emojis.flag_croatia),
      EmojiModel(
          name: 'flag_haiti', code: 'u{1f1ed}', emoji: Emojis.flag_haiti),
      EmojiModel(
          name: 'flag_hungary', code: 'u{1f1ed}', emoji: Emojis.flag_hungary),
      EmojiModel(
          name: 'flag_canary_islands',
          code: 'u{1f1ee}',
          emoji: Emojis.flag_canary_islands),
      EmojiModel(
          name: 'flag_indonesia',
          code: 'u{1f1ee}',
          emoji: Emojis.flag_indonesia),
      EmojiModel(
          name: 'flag_ireland', code: 'u{1f1ee}', emoji: Emojis.flag_ireland),
      EmojiModel(
          name: 'flag_israel', code: 'u{1f1ee}', emoji: Emojis.flag_israel),
      EmojiModel(
          name: 'flag_isle_of_man',
          code: 'u{1f1ee}',
          emoji: Emojis.flag_isle_of_man),
      EmojiModel(
          name: 'flag_india', code: 'u{1f1ee}', emoji: Emojis.flag_india),
      EmojiModel(
          name: 'flag_british_indian_ocean_territory',
          code: 'u{1f1ee}',
          emoji: Emojis.flag_british_indian_ocean_territory),
      EmojiModel(name: 'flag_iraq', code: 'u{1f1ee}', emoji: Emojis.flag_iraq),
      EmojiModel(name: 'flag_iran', code: 'u{1f1ee}', emoji: Emojis.flag_iran),
      EmojiModel(
          name: 'flag_iceland', code: 'u{1f1ee}', emoji: Emojis.flag_iceland),
      EmojiModel(
          name: 'flag_italy', code: 'u{1f1ee}', emoji: Emojis.flag_italy),
      EmojiModel(
          name: 'flag_jersey', code: 'u{1f1ef}', emoji: Emojis.flag_jersey),
      EmojiModel(
          name: 'flag_jamaica', code: 'u{1f1ef}', emoji: Emojis.flag_jamaica),
      EmojiModel(
          name: 'flag_jordan', code: 'u{1f1ef}', emoji: Emojis.flag_jordan),
      EmojiModel(
          name: 'flag_japan', code: 'u{1f1ef}', emoji: Emojis.flag_japan),
      EmojiModel(
          name: 'flag_kenya', code: 'u{1f1f0}', emoji: Emojis.flag_kenya),
      EmojiModel(
          name: 'flag_kyrgyzstan',
          code: 'u{1f1f0}',
          emoji: Emojis.flag_kyrgyzstan),
      EmojiModel(
          name: 'flag_cambodia', code: 'u{1f1f0}', emoji: Emojis.flag_cambodia),
      EmojiModel(
          name: 'flag_kiribati', code: 'u{1f1f0}', emoji: Emojis.flag_kiribati),
      EmojiModel(
          name: 'flag_comoros', code: 'u{1f1f0}', emoji: Emojis.flag_comoros),
      EmojiModel(
          name: 'flag_st_kitts_nevis',
          code: 'u{1f1f0}',
          emoji: Emojis.flag_st_kitts_nevis),
      EmojiModel(
          name: 'flag_north_korea',
          code: 'u{1f1f0}',
          emoji: Emojis.flag_north_korea),
      EmojiModel(
          name: 'flag_south_korea',
          code: 'u{1f1f0}',
          emoji: Emojis.flag_south_korea),
      EmojiModel(
          name: 'flag_kuwait', code: 'u{1f1f0}', emoji: Emojis.flag_kuwait),
      EmojiModel(
          name: 'flag_cayman_islands',
          code: 'u{1f1f0}',
          emoji: Emojis.flag_cayman_islands),
      EmojiModel(
          name: 'flag_kazakhstan',
          code: 'u{1f1f0}',
          emoji: Emojis.flag_kazakhstan),
      EmojiModel(name: 'flag_laos', code: 'u{1f1f1}', emoji: Emojis.flag_laos),
      EmojiModel(
          name: 'flag_lebanon', code: 'u{1f1f1}', emoji: Emojis.flag_lebanon),
      EmojiModel(
          name: 'flag_st_lucia', code: 'u{1f1f1}', emoji: Emojis.flag_st_lucia),
      EmojiModel(
          name: 'flag_liechtenstein',
          code: 'u{1f1f1}',
          emoji: Emojis.flag_liechtenstein),
      EmojiModel(
          name: 'flag_sri_lanka',
          code: 'u{1f1f1}',
          emoji: Emojis.flag_sri_lanka),
      EmojiModel(
          name: 'flag_liberia', code: 'u{1f1f1}', emoji: Emojis.flag_liberia),
      EmojiModel(
          name: 'flag_lesotho', code: 'u{1f1f1}', emoji: Emojis.flag_lesotho),
      EmojiModel(
          name: 'flag_lithuania',
          code: 'u{1f1f1}',
          emoji: Emojis.flag_lithuania),
      EmojiModel(
          name: 'flag_luxembourg',
          code: 'u{1f1f1}',
          emoji: Emojis.flag_luxembourg),
      EmojiModel(
          name: 'flag_latvia', code: 'u{1f1f1}', emoji: Emojis.flag_latvia),
      EmojiModel(
          name: 'flag_libya', code: 'u{1f1f1}', emoji: Emojis.flag_libya),
      EmojiModel(
          name: 'flag_morocco', code: 'u{1f1f2}', emoji: Emojis.flag_morocco),
      EmojiModel(
          name: 'flag_monaco', code: 'u{1f1f2}', emoji: Emojis.flag_monaco),
      EmojiModel(
          name: 'flag_moldova', code: 'u{1f1f2}', emoji: Emojis.flag_moldova),
      EmojiModel(
          name: 'flag_montenegro',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_montenegro),
      EmojiModel(
          name: 'flag_st_martin',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_st_martin),
      EmojiModel(
          name: 'flag_madagascar',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_madagascar),
      EmojiModel(
          name: 'flag_marshall_islands',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_marshall_islands),
      EmojiModel(
          name: 'flag_north_macedonia',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_north_macedonia),
      EmojiModel(name: 'flag_mali', code: 'u{1f1f2}', emoji: Emojis.flag_mali),
      EmojiModel(
          name: 'flag_myanmar_burma',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_myanmar_burma),
      EmojiModel(
          name: 'flag_mongolia', code: 'u{1f1f2}', emoji: Emojis.flag_mongolia),
      EmojiModel(
          name: 'flag_macao_sar_china',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_macao_sar_china),
      EmojiModel(
          name: 'flag_northern_mariana_islands',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_northern_mariana_islands),
      EmojiModel(
          name: 'flag_martinique',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_martinique),
      EmojiModel(
          name: 'flag_mauritania',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_mauritania),
      EmojiModel(
          name: 'flag_montserrat',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_montserrat),
      EmojiModel(
          name: 'flag_malta', code: 'u{1f1f2}', emoji: Emojis.flag_malta),
      EmojiModel(
          name: 'flag_mauritius',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_mauritius),
      EmojiModel(
          name: 'flag_maldives', code: 'u{1f1f2}', emoji: Emojis.flag_maldives),
      EmojiModel(
          name: 'flag_malawi', code: 'u{1f1f2}', emoji: Emojis.flag_malawi),
      EmojiModel(
          name: 'flag_mexico', code: 'u{1f1f2}', emoji: Emojis.flag_mexico),
      EmojiModel(
          name: 'flag_malaysia', code: 'u{1f1f2}', emoji: Emojis.flag_malaysia),
      EmojiModel(
          name: 'flag_mozambique',
          code: 'u{1f1f2}',
          emoji: Emojis.flag_mozambique),
      EmojiModel(
          name: 'flag_namibia', code: 'u{1f1f3}', emoji: Emojis.flag_namibia),
      EmojiModel(
          name: 'flag_new_caledonia',
          code: 'u{1f1f3}',
          emoji: Emojis.flag_new_caledonia),
      EmojiModel(
          name: 'flag_niger', code: 'u{1f1f3}', emoji: Emojis.flag_niger),
      EmojiModel(
          name: 'flag_norfolk_island',
          code: 'u{1f1f3}',
          emoji: Emojis.flag_norfolk_island),
      EmojiModel(
          name: 'flag_nigeria', code: 'u{1f1f3}', emoji: Emojis.flag_nigeria),
      EmojiModel(
          name: 'flag_nicaragua',
          code: 'u{1f1f3}',
          emoji: Emojis.flag_nicaragua),
      EmojiModel(
          name: 'flag_netherlands',
          code: 'u{1f1f3}',
          emoji: Emojis.flag_netherlands),
      EmojiModel(
          name: 'flag_norway', code: 'u{1f1f3}', emoji: Emojis.flag_norway),
      EmojiModel(
          name: 'flag_nepal', code: 'u{1f1f3}', emoji: Emojis.flag_nepal),
      EmojiModel(
          name: 'flag_nauru', code: 'u{1f1f3}', emoji: Emojis.flag_nauru),
      EmojiModel(name: 'flag_niue', code: 'u{1f1f3}', emoji: Emojis.flag_niue),
      EmojiModel(
          name: 'flag_new_zealand',
          code: 'u{1f1f3}',
          emoji: Emojis.flag_new_zealand),
      EmojiModel(name: 'flag_oman', code: 'u{1f1f4}', emoji: Emojis.flag_oman),
      EmojiModel(
          name: 'flag_panama', code: 'u{1f1f5}', emoji: Emojis.flag_panama),
      EmojiModel(name: 'flag_peru', code: 'u{1f1f5}', emoji: Emojis.flag_peru),
      EmojiModel(
          name: 'flag_french_polynesia',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_french_polynesia),
      EmojiModel(
          name: 'flag_papua_new_guinea',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_papua_new_guinea),
      EmojiModel(
          name: 'flag_philippines',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_philippines),
      EmojiModel(
          name: 'flag_pakistan', code: 'u{1f1f5}', emoji: Emojis.flag_pakistan),
      EmojiModel(
          name: 'flag_poland', code: 'u{1f1f5}', emoji: Emojis.flag_poland),
      EmojiModel(
          name: 'flag_st_pierre_miquelon',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_st_pierre_miquelon),
      EmojiModel(
          name: 'flag_pitcairn_islands',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_pitcairn_islands),
      EmojiModel(
          name: 'flag_puerto_rico',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_puerto_rico),
      EmojiModel(
          name: 'flag_palestinian_territories',
          code: 'u{1f1f5}',
          emoji: Emojis.flag_palestinian_territories),
      EmojiModel(
          name: 'flag_portugal', code: 'u{1f1f5}', emoji: Emojis.flag_portugal),
      EmojiModel(
          name: 'flag_palau', code: 'u{1f1f5}', emoji: Emojis.flag_palau),
      EmojiModel(
          name: 'flag_paraguay', code: 'u{1f1f5}', emoji: Emojis.flag_paraguay),
      EmojiModel(
          name: 'flag_qatar', code: 'u{1f1f6}', emoji: Emojis.flag_qatar),
      EmojiModel(
          name: 'flag_reunion', code: 'u{1f1f7}', emoji: Emojis.flag_reunion),
      EmojiModel(
          name: 'flag_romania', code: 'u{1f1f7}', emoji: Emojis.flag_romania),
      EmojiModel(
          name: 'flag_serbia', code: 'u{1f1f7}', emoji: Emojis.flag_serbia),
      EmojiModel(
          name: 'flag_russia', code: 'u{1f1f7}', emoji: Emojis.flag_russia),
      EmojiModel(
          name: 'flag_rwanda', code: 'u{1f1f7}', emoji: Emojis.flag_rwanda),
      EmojiModel(
          name: 'flag_saudi_arabia',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_saudi_arabia),
      EmojiModel(
          name: 'flag_solomon_islands',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_solomon_islands),
      EmojiModel(
          name: 'flag_seychelles',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_seychelles),
      EmojiModel(
          name: 'flag_sudan', code: 'u{1f1f8}', emoji: Emojis.flag_sudan),
      EmojiModel(
          name: 'flag_sweden', code: 'u{1f1f8}', emoji: Emojis.flag_sweden),
      EmojiModel(
          name: 'flag_singapore',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_singapore),
      EmojiModel(
          name: 'flag_st_helena',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_st_helena),
      EmojiModel(
          name: 'flag_slovenia', code: 'u{1f1f8}', emoji: Emojis.flag_slovenia),
      EmojiModel(
          name: 'flag_svalbard_jan_mayen',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_svalbard_jan_mayen),
      EmojiModel(
          name: 'flag_slovakia', code: 'u{1f1f8}', emoji: Emojis.flag_slovakia),
      EmojiModel(
          name: 'flag_sierra_leone',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_sierra_leone),
      EmojiModel(
          name: 'flag_san_marino',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_san_marino),
      EmojiModel(
          name: 'flag_senegal', code: 'u{1f1f8}', emoji: Emojis.flag_senegal),
      EmojiModel(
          name: 'flag_somalia', code: 'u{1f1f8}', emoji: Emojis.flag_somalia),
      EmojiModel(
          name: 'flag_suriname', code: 'u{1f1f8}', emoji: Emojis.flag_suriname),
      EmojiModel(
          name: 'flag_south_sudan',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_south_sudan),
      EmojiModel(
          name: 'flag_sao_tome_principe',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_sao_tome_principe),
      EmojiModel(
          name: 'flag_el_salvador',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_el_salvador),
      EmojiModel(
          name: 'flag_sint_maarten',
          code: 'u{1f1f8}',
          emoji: Emojis.flag_sint_maarten),
      EmojiModel(
          name: 'flag_syria', code: 'u{1f1f8}', emoji: Emojis.flag_syria),
      EmojiModel(
          name: 'flag_eswatini', code: 'u{1f1f8}', emoji: Emojis.flag_eswatini),
      EmojiModel(
          name: 'flag_tristan_da_cunha',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_tristan_da_cunha),
      EmojiModel(
          name: 'flag_turks_caicos_islands',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_turks_caicos_islands),
      EmojiModel(name: 'flag_chad', code: 'u{1f1f9}', emoji: Emojis.flag_chad),
      EmojiModel(
          name: 'flag_french_southern_territories',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_french_southern_territories),
      EmojiModel(name: 'flag_togo', code: 'u{1f1f9}', emoji: Emojis.flag_togo),
      EmojiModel(
          name: 'flag_thailand', code: 'u{1f1f9}', emoji: Emojis.flag_thailand),
      EmojiModel(
          name: 'flag_tajikistan',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_tajikistan),
      EmojiModel(
          name: 'flag_tokelau', code: 'u{1f1f9}', emoji: Emojis.flag_tokelau),
      EmojiModel(
          name: 'flag_timor_leste',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_timor_leste),
      EmojiModel(
          name: 'flag_turkmenistan',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_turkmenistan),
      EmojiModel(
          name: 'flag_tunisia', code: 'u{1f1f9}', emoji: Emojis.flag_tunisia),
      EmojiModel(
          name: 'flag_tonga', code: 'u{1f1f9}', emoji: Emojis.flag_tonga),
      EmojiModel(
          name: 'flag_trinidad_tobago',
          code: 'u{1f1f9}',
          emoji: Emojis.flag_trinidad_tobago),
      EmojiModel(
          name: 'flag_tuvalu', code: 'u{1f1f9}', emoji: Emojis.flag_tuvalu),
      EmojiModel(
          name: 'flag_taiwan', code: 'u{1f1f9}', emoji: Emojis.flag_taiwan),
      EmojiModel(
          name: 'flag_tanzania', code: 'u{1f1f9}', emoji: Emojis.flag_tanzania),
      EmojiModel(
          name: 'flag_ukraine', code: 'u{1f1fa}', emoji: Emojis.flag_ukraine),
      EmojiModel(
          name: 'flag_uganda', code: 'u{1f1fa}', emoji: Emojis.flag_uganda),
      EmojiModel(
          name: 'flag_us_outlying_islands',
          code: 'u{1f1fa}',
          emoji: Emojis.flag_us_outlying_islands),
      EmojiModel(
          name: 'flag_united_nations',
          code: 'u{1f1fa}',
          emoji: Emojis.flag_united_nations),
      EmojiModel(
          name: 'flag_transgenderSymbol',
          code: 'u{26A7}',
          emoji: Emojis.flag_transgenderSymbol),
      EmojiModel(
          name: 'flag_whiteFlag',
          code: 'u{1F3F3}u{FE0F}',
          emoji: Emojis.flag_whiteFlag),
      EmojiModel(
          name: 'flag_blackFlag',
          code: 'u{1F3F4}',
          emoji: Emojis.flag_blackFlag),
      EmojiModel(
          name: 'flag_chequeredFlag',
          code: 'u{1F3C1}',
          emoji: Emojis.flag_chequeredFlag),
      EmojiModel(
          name: 'flag_triangularFlag',
          code: 'u{1F6A9}',
          emoji: Emojis.flag_triangularFlag),
      EmojiModel(
          name: 'flag_rainbowFlag',
          code: 'u{1F3F3}u{FE0F}u{200D}u{1F308}',
          emoji: Emojis.flag_rainbowFlag),
      EmojiModel(
          name: 'flag_transgenderFlag',
          code: 'u{1F3F3}u{200D}u{26A7}u{FE0F}',
          emoji: Emojis.flag_transgenderFlag),
      EmojiModel(
          name: 'flag_pirateFlag',
          code: 'u{1F3F4}u{200D}u{2620}u{FE0F}',
          emoji: Emojis.flag_pirateFlag),
      EmojiModel(
          name: 'flag_Afghanistan',
          code: 'u{1F1E6}u{1F1EB}',
          emoji: Emojis.flag_Afghanistan),
      EmojiModel(
          name: 'flag_AlandIslands',
          code: 'u{1F1E6}u{1F1FD}',
          emoji: Emojis.flag_AlandIslands),
      EmojiModel(
          name: 'flag_Albania',
          code: 'u{1F1E6}u{1F1F1}',
          emoji: Emojis.flag_Albania),
      EmojiModel(
          name: 'flag_Algeria',
          code: 'u{1F1E9}u{1F1FF}',
          emoji: Emojis.flag_Algeria),
      EmojiModel(
          name: 'flag_AmericanSamoa',
          code: 'u{1F1E6}u{1F1F8}',
          emoji: Emojis.flag_AmericanSamoa),
      EmojiModel(
          name: 'flag_Andorra',
          code: 'u{1F1E6}u{1F1E9}',
          emoji: Emojis.flag_Andorra),
      EmojiModel(
          name: 'flag_Angola',
          code: 'u{1F1E6}u{1F1F4}',
          emoji: Emojis.flag_Angola),
      EmojiModel(
          name: 'flag_Anguilla',
          code: 'u{1F1E6}u{1F1EE}',
          emoji: Emojis.flag_Anguilla),
      EmojiModel(
          name: 'flag_Antarctica',
          code: 'u{1F1E6}u{1F1F6}',
          emoji: Emojis.flag_Antarctica),
      EmojiModel(
          name: 'flag_AntiguaBarbuda',
          code: 'u{1F1E6}u{1F1EC}',
          emoji: Emojis.flag_AntiguaBarbuda),
      EmojiModel(
          name: 'flag_Argentina',
          code: 'u{1F1E6}u{1F1F7}',
          emoji: Emojis.flag_Argentina),
      EmojiModel(
          name: 'flag_Armenia',
          code: 'u{1F1E6}u{1F1F2}',
          emoji: Emojis.flag_Armenia),
      EmojiModel(
          name: 'flag_Aruba',
          code: 'u{1F1E6}u{1F1FC}',
          emoji: Emojis.flag_Aruba),
      EmojiModel(
          name: 'flag_Australia',
          code: 'u{1F1E6}u{1F1FA}',
          emoji: Emojis.flag_Australia),
      EmojiModel(
          name: 'flag_Austria',
          code: 'u{1F1E6}u{1F1F9}',
          emoji: Emojis.flag_Austria),
      EmojiModel(
          name: 'flag_Azerbaijan',
          code: 'u{1F1E6}u{1F1FF}',
          emoji: Emojis.flag_Azerbaijan),
      EmojiModel(
          name: 'flag_Bahamas',
          code: 'u{1F1E7}u{1F1F8}',
          emoji: Emojis.flag_Bahamas),
      EmojiModel(
          name: 'flag_Bahrain',
          code: 'u{1F1E7}u{1F1ED}',
          emoji: Emojis.flag_Bahrain),
      EmojiModel(
          name: 'flag_Bangladesh',
          code: 'u{1F1E7}u{1F1E9}',
          emoji: Emojis.flag_Bangladesh),
      EmojiModel(
          name: 'flag_Barbados',
          code: 'u{1F1E7}u{1F1E7}',
          emoji: Emojis.flag_Barbados),
      EmojiModel(
          name: 'flag_Belarus',
          code: 'u{1F1E7}u{1F1FE}',
          emoji: Emojis.flag_Belarus),
      EmojiModel(
          name: 'flag_Belgium',
          code: 'u{1F1E7}u{1F1EA}',
          emoji: Emojis.flag_Belgium),
      EmojiModel(
          name: 'flag_Belize',
          code: 'u{1F1E7}u{1F1FF}',
          emoji: Emojis.flag_Belize),
      EmojiModel(
          name: 'flag_Benin',
          code: 'u{1F1E7}u{1F1EF}',
          emoji: Emojis.flag_Benin),
      EmojiModel(
          name: 'flag_Bermuda',
          code: 'u{1F1E7}u{1F1F2}',
          emoji: Emojis.flag_Bermuda),
      EmojiModel(
          name: 'flag_Bhutan',
          code: 'u{1F1E7}u{1F1F9}',
          emoji: Emojis.flag_Bhutan),
      EmojiModel(
          name: 'flag_Bolivia',
          code: 'u{1F1E7}u{1F1F4}',
          emoji: Emojis.flag_Bolivia),
      EmojiModel(
          name: 'flag_BosniaHerzegovina',
          code: 'u{1F1E7}u{1F1E6}',
          emoji: Emojis.flag_BosniaHerzegovina),
      EmojiModel(
          name: 'flag_Botswana',
          code: 'u{1F1E7}u{1F1FC}',
          emoji: Emojis.flag_Botswana),
      EmojiModel(
          name: 'flag_Brazil',
          code: 'u{1F1E7}u{1F1F7}',
          emoji: Emojis.flag_Brazil),
      EmojiModel(
          name: 'flag_BritishIndianOceanTerritory',
          code: 'u{1F1EE}u{1F1F4}',
          emoji: Emojis.flag_BritishIndianOceanTerritory),
      EmojiModel(
          name: 'flag_BritishVirginIslands',
          code: 'u{1F1FB}u{1F1EC}',
          emoji: Emojis.flag_BritishVirginIslands),
      EmojiModel(
          name: 'flag_Brunei',
          code: 'u{1F1E7}u{1F1F3}',
          emoji: Emojis.flag_Brunei),
      EmojiModel(
          name: 'flag_Bulgaria',
          code: 'u{1F1E7}u{1F1EC}',
          emoji: Emojis.flag_Bulgaria),
      EmojiModel(
          name: 'flag_BurkinaFaso',
          code: 'u{1F1E7}u{1F1EB}',
          emoji: Emojis.flag_BurkinaFaso),
      EmojiModel(
          name: 'flag_Burundi',
          code: 'u{1F1E7}u{1F1EE}',
          emoji: Emojis.flag_Burundi),
      EmojiModel(
          name: 'flag_Cambodia',
          code: 'u{1F1F0}u{1F1ED}',
          emoji: Emojis.flag_Cambodia),
      EmojiModel(
          name: 'flag_Cameroon',
          code: 'u{1F1E8}u{1F1F2}',
          emoji: Emojis.flag_Cameroon),
      EmojiModel(
          name: 'flag_Canada',
          code: 'u{1F1E8}u{1F1E6}',
          emoji: Emojis.flag_Canada),
      EmojiModel(
          name: 'flag_CanaryIslands',
          code: 'u{1F1EE}u{1F1E8}',
          emoji: Emojis.flag_CanaryIslands),
      EmojiModel(
          name: 'flag_CapeVerde',
          code: 'u{1F1E8}u{1F1FB}',
          emoji: Emojis.flag_CapeVerde),
      EmojiModel(
          name: 'flag_CaribbeanNetherlands',
          code: 'u{1F1E7}u{1F1F6}',
          emoji: Emojis.flag_CaribbeanNetherlands),
      EmojiModel(
          name: 'flag_CaymanIslands',
          code: 'u{1F1F0}u{1F1FE}',
          emoji: Emojis.flag_CaymanIslands),
      EmojiModel(
          name: 'flag_CentralAfricanRepublic',
          code: 'u{1F1E8}u{1F1EB}',
          emoji: Emojis.flag_CentralAfricanRepublic),
      EmojiModel(
          name: 'flag_Chad', code: 'u{1F1F9}u{1F1E9}', emoji: Emojis.flag_Chad),
      EmojiModel(
          name: 'flag_Chile',
          code: 'u{1F1E8}u{1F1F1}',
          emoji: Emojis.flag_Chile),
      EmojiModel(
          name: 'flag_China',
          code: 'u{1F1E8}u{1F1F3}',
          emoji: Emojis.flag_China),
      EmojiModel(
          name: 'flag_ChristmasIsland',
          code: 'u{1F1E8}u{1F1FD}',
          emoji: Emojis.flag_ChristmasIsland),
      EmojiModel(
          name: 'flag_Cocos',
          code: 'u{1F1E8}u{1F1E8}',
          emoji: Emojis.flag_Cocos),
      EmojiModel(
          name: 'flag_Colombia',
          code: 'u{1F1E8}u{1F1F4}',
          emoji: Emojis.flag_Colombia),
      EmojiModel(
          name: 'flag_Comoros',
          code: 'u{1F1F0}u{1F1F2}',
          emoji: Emojis.flag_Comoros),
      EmojiModel(
          name: 'flag_Congo__Brazzaville',
          code: 'u{1F1E8}u{1F1EC}',
          emoji: Emojis.flag_Congo__Brazzaville),
      EmojiModel(
          name: 'flag_Congo__Kinshasa',
          code: 'u{1F1E8}u{1F1E9}',
          emoji: Emojis.flag_Congo__Kinshasa),
      EmojiModel(
          name: 'flag_CookIslands',
          code: 'u{1F1E8}u{1F1F0}',
          emoji: Emojis.flag_CookIslands),
      EmojiModel(
          name: 'flag_CostaRica',
          code: 'u{1F1E8}u{1F1F7}',
          emoji: Emojis.flag_CostaRica),
      EmojiModel(
          name: 'flag_CoteDIvoire',
          code: 'u{1F1E8}u{1F1EE}',
          emoji: Emojis.flag_CoteDIvoire),
      EmojiModel(
          name: 'flag_Croatia',
          code: 'u{1F1ED}u{1F1F7}',
          emoji: Emojis.flag_Croatia),
      EmojiModel(
          name: 'flag_Cuba', code: 'u{1F1E8}u{1F1FA}', emoji: Emojis.flag_Cuba),
      EmojiModel(
          name: 'flag_Curacao',
          code: 'u{1F1E8}u{1F1FC}',
          emoji: Emojis.flag_Curacao),
      EmojiModel(
          name: 'flag_Cyprus',
          code: 'u{1F1E8}u{1F1FE}',
          emoji: Emojis.flag_Cyprus),
      EmojiModel(
          name: 'flag_Czechia',
          code: 'u{1F1E8}u{1F1FF}',
          emoji: Emojis.flag_Czechia),
      EmojiModel(
          name: 'flag_Denmark',
          code: 'u{1F1E9}u{1F1F0}',
          emoji: Emojis.flag_Denmark),
      EmojiModel(
          name: 'flag_Djibouti',
          code: 'u{1F1E9}u{1F1EF}',
          emoji: Emojis.flag_Djibouti),
      EmojiModel(
          name: 'flag_Dominica',
          code: 'u{1F1E9}u{1F1F2}',
          emoji: Emojis.flag_Dominica),
      EmojiModel(
          name: 'flag_DominicanRepublic',
          code: 'u{1F1E9}u{1F1F4}',
          emoji: Emojis.flag_DominicanRepublic),
      EmojiModel(
          name: 'flag_Ecuador',
          code: 'u{1F1EA}u{1F1E8}',
          emoji: Emojis.flag_Ecuador),
      EmojiModel(
          name: 'flag_Egypt',
          code: 'u{1F1EA}u{1F1EC}',
          emoji: Emojis.flag_Egypt),
      EmojiModel(
          name: 'flag_ElSalvador',
          code: 'u{1F1F8}u{1F1FB}',
          emoji: Emojis.flag_ElSalvador),
      EmojiModel(
          name: 'flag_EquatorialGuinea',
          code: 'u{1F1EC}u{1F1F6}',
          emoji: Emojis.flag_EquatorialGuinea),
      EmojiModel(
          name: 'flag_Eritrea',
          code: 'u{1F1EA}u{1F1F7}',
          emoji: Emojis.flag_Eritrea),
      EmojiModel(
          name: 'flag_Estonia',
          code: 'u{1F1EA}u{1F1EA}',
          emoji: Emojis.flag_Estonia),
      EmojiModel(
          name: 'flag_Ethiopia',
          code: 'u{1F1EA}u{1F1F9}',
          emoji: Emojis.flag_Ethiopia),
      EmojiModel(
          name: 'flag_EuropeanUnion',
          code: 'u{1F1EA}u{1F1FA}',
          emoji: Emojis.flag_EuropeanUnion),
      EmojiModel(
          name: 'flag_FalklandIslands',
          code: 'u{1F1EB}u{1F1F0}',
          emoji: Emojis.flag_FalklandIslands),
      EmojiModel(
          name: 'flag_FaroeIslands',
          code: 'u{1F1EB}u{1F1F4}',
          emoji: Emojis.flag_FaroeIslands),
      EmojiModel(
          name: 'flag_Fiji', code: 'u{1F1EB}u{1F1EF}', emoji: Emojis.flag_Fiji),
      EmojiModel(
          name: 'flag_Finland',
          code: 'u{1F1EB}u{1F1EE}',
          emoji: Emojis.flag_Finland),
      EmojiModel(
          name: 'flag_France',
          code: 'u{1F1EB}u{1F1F7}',
          emoji: Emojis.flag_France),
      EmojiModel(
          name: 'flag_FrenchGuiana',
          code: 'u{1F1EC}u{1F1EB}',
          emoji: Emojis.flag_FrenchGuiana),
      EmojiModel(
          name: 'flag_FrenchPolynesia',
          code: 'u{1F1F5}u{1F1EB}',
          emoji: Emojis.flag_FrenchPolynesia),
      EmojiModel(
          name: 'flag_FrenchSouthernTerritories',
          code: 'u{1F1F9}u{1F1EB}',
          emoji: Emojis.flag_FrenchSouthernTerritories),
      EmojiModel(
          name: 'flag_Gabon',
          code: 'u{1F1EC}u{1F1E6}',
          emoji: Emojis.flag_Gabon),
      EmojiModel(
          name: 'flag_Gambia',
          code: 'u{1F1EC}u{1F1F2}',
          emoji: Emojis.flag_Gambia),
      EmojiModel(
          name: 'flag_Georgia',
          code: 'u{1F1EC}u{1F1EA}',
          emoji: Emojis.flag_Georgia),
      EmojiModel(
          name: 'flag_Germany',
          code: 'u{1F1E9}u{1F1EA}',
          emoji: Emojis.flag_Germany),
      EmojiModel(
          name: 'flag_Ghana',
          code: 'u{1F1EC}u{1F1ED}',
          emoji: Emojis.flag_Ghana),
      EmojiModel(
          name: 'flag_Gibraltar',
          code: 'u{1F1EC}u{1F1EE}',
          emoji: Emojis.flag_Gibraltar),
      EmojiModel(
          name: 'flag_Greece',
          code: 'u{1F1EC}u{1F1F7}',
          emoji: Emojis.flag_Greece),
      EmojiModel(
          name: 'flag_Greenland',
          code: 'u{1F1EC}u{1F1F1}',
          emoji: Emojis.flag_Greenland),
      EmojiModel(
          name: 'flag_Grenada',
          code: 'u{1F1EC}u{1F1E9}',
          emoji: Emojis.flag_Grenada),
      EmojiModel(
          name: 'flag_Guadeloupe',
          code: 'u{1F1EC}u{1F1F5}',
          emoji: Emojis.flag_Guadeloupe),
      EmojiModel(
          name: 'flag_Guam', code: 'u{1F1EC}u{1F1FA}', emoji: Emojis.flag_Guam),
      EmojiModel(
          name: 'flag_Guatemala',
          code: 'u{1F1EC}u{1F1F9}',
          emoji: Emojis.flag_Guatemala),
      EmojiModel(
          name: 'flag_Guernsey',
          code: 'u{1F1EC}u{1F1EC}',
          emoji: Emojis.flag_Guernsey),
      EmojiModel(
          name: 'flag_Guinea',
          code: 'u{1F1EC}u{1F1F3}',
          emoji: Emojis.flag_Guinea),
      EmojiModel(
          name: 'flag_GuineaBissau',
          code: 'u{1F1EC}u{1F1FC}',
          emoji: Emojis.flag_GuineaBissau),
      EmojiModel(
          name: 'flag_Guyana',
          code: 'u{1F1EC}u{1F1FE}',
          emoji: Emojis.flag_Guyana),
      EmojiModel(
          name: 'flag_Haiti',
          code: 'u{1F1ED}u{1F1F9}',
          emoji: Emojis.flag_Haiti),
      EmojiModel(
          name: 'flag_Honduras',
          code: 'u{1F1ED}u{1F1F3}',
          emoji: Emojis.flag_Honduras),
      EmojiModel(
          name: 'flag_HongKongSarChina',
          code: 'u{1F1ED}u{1F1F0}',
          emoji: Emojis.flag_HongKongSarChina),
      EmojiModel(
          name: 'flag_Hungary',
          code: 'u{1F1ED}u{1F1FA}',
          emoji: Emojis.flag_Hungary),
      EmojiModel(
          name: 'flag_Iceland',
          code: 'u{1F1EE}u{1F1F8}',
          emoji: Emojis.flag_Iceland),
      EmojiModel(
          name: 'flag_India',
          code: 'u{1F1EE}u{1F1F3}',
          emoji: Emojis.flag_India),
      EmojiModel(
          name: 'flag_Indonesia',
          code: 'u{1F1EE}u{1F1E9}',
          emoji: Emojis.flag_Indonesia),
      EmojiModel(
          name: 'flag_Iran', code: 'u{1F1EE}u{1F1F7}', emoji: Emojis.flag_Iran),
      EmojiModel(
          name: 'flag_Iraq', code: 'u{1F1EE}u{1F1F6}', emoji: Emojis.flag_Iraq),
      EmojiModel(
          name: 'flag_Ireland',
          code: 'u{1F1EE}u{1F1EA}',
          emoji: Emojis.flag_Ireland),
      EmojiModel(
          name: 'flag_IsleOfMan',
          code: 'u{1F1EE}u{1F1F2}',
          emoji: Emojis.flag_IsleOfMan),
      EmojiModel(
          name: 'flag_Israel',
          code: 'u{1F1EE}u{1F1F1}',
          emoji: Emojis.flag_Israel),
      EmojiModel(
          name: 'flag_Italy',
          code: 'u{1F1EE}u{1F1F9}',
          emoji: Emojis.flag_Italy),
      EmojiModel(
          name: 'flag_Jamaica',
          code: 'u{1F1EF}u{1F1F2}',
          emoji: Emojis.flag_Jamaica),
      EmojiModel(
          name: 'flag_Japan',
          code: 'u{1F1EF}u{1F1F5}',
          emoji: Emojis.flag_Japan),
      EmojiModel(
          name: 'crossedFlags', code: 'u{1F38C}', emoji: Emojis.crossedFlags),
      EmojiModel(
          name: 'flag_Jersey',
          code: 'u{1F1EF}u{1F1EA}',
          emoji: Emojis.flag_Jersey),
      EmojiModel(
          name: 'flag_Jordan',
          code: 'u{1F1EF}u{1F1F4}',
          emoji: Emojis.flag_Jordan),
      EmojiModel(
          name: 'flag_Kazakhstan',
          code: 'u{1F1F0}u{1F1FF}',
          emoji: Emojis.flag_Kazakhstan),
      EmojiModel(
          name: 'flag_Kenya',
          code: 'u{1F1F0}u{1F1EA}',
          emoji: Emojis.flag_Kenya),
      EmojiModel(
          name: 'flag_Kiribati',
          code: 'u{1F1F0}u{1F1EE}',
          emoji: Emojis.flag_Kiribati),
      EmojiModel(
          name: 'flag_Kosovo',
          code: 'u{1F1FD}u{1F1F0}',
          emoji: Emojis.flag_Kosovo),
      EmojiModel(
          name: 'flag_Kuwait',
          code: 'u{1F1F0}u{1F1FC}',
          emoji: Emojis.flag_Kuwait),
      EmojiModel(
          name: 'flag_Kyrgyzstan',
          code: 'u{1F1F0}u{1F1EC}',
          emoji: Emojis.flag_Kyrgyzstan),
      EmojiModel(
          name: 'flag_Laos', code: 'u{1F1F1}u{1F1E6}', emoji: Emojis.flag_Laos),
      EmojiModel(
          name: 'flag_Latvia',
          code: 'u{1F1F1}u{1F1FB}',
          emoji: Emojis.flag_Latvia),
      EmojiModel(
          name: 'flag_Lebanon',
          code: 'u{1F1F1}u{1F1E7}',
          emoji: Emojis.flag_Lebanon),
      EmojiModel(
          name: 'flag_Lesotho',
          code: 'u{1F1F1}u{1F1F8}',
          emoji: Emojis.flag_Lesotho),
      EmojiModel(
          name: 'flag_Liberia',
          code: 'u{1F1F1}u{1F1F7}',
          emoji: Emojis.flag_Liberia),
      EmojiModel(
          name: 'flag_Libya',
          code: 'u{1F1F1}u{1F1FE}',
          emoji: Emojis.flag_Libya),
      EmojiModel(
          name: 'flag_Liechtenstein',
          code: 'u{1F1F1}u{1F1EE}',
          emoji: Emojis.flag_Liechtenstein),
      EmojiModel(
          name: 'flag_Lithuania',
          code: 'u{1F1F1}u{1F1F9}',
          emoji: Emojis.flag_Lithuania),
      EmojiModel(
          name: 'flag_Luxembourg',
          code: 'u{1F1F1}u{1F1FA}',
          emoji: Emojis.flag_Luxembourg),
      EmojiModel(
          name: 'flag_MacaoSarChina',
          code: 'u{1F1F2}u{1F1F4}',
          emoji: Emojis.flag_MacaoSarChina),
      EmojiModel(
          name: 'flag_NorthMacedonia',
          code: 'u{1F1F2}u{1F1F0}',
          emoji: Emojis.flag_NorthMacedonia),
      EmojiModel(
          name: 'flag_Madagascar',
          code: 'u{1F1F2}u{1F1EC}',
          emoji: Emojis.flag_Madagascar),
      EmojiModel(
          name: 'flag_Malawi',
          code: 'u{1F1F2}u{1F1FC}',
          emoji: Emojis.flag_Malawi),
      EmojiModel(
          name: 'flag_Malaysia',
          code: 'u{1F1F2}u{1F1FE}',
          emoji: Emojis.flag_Malaysia),
      EmojiModel(
          name: 'flag_Maldives',
          code: 'u{1F1F2}u{1F1FB}',
          emoji: Emojis.flag_Maldives),
      EmojiModel(
          name: 'flag_Mali', code: 'u{1F1F2}u{1F1F1}', emoji: Emojis.flag_Mali),
      EmojiModel(
          name: 'flag_Malta',
          code: 'u{1F1F2}u{1F1F9}',
          emoji: Emojis.flag_Malta),
      EmojiModel(
          name: 'flag_MarshallIslands',
          code: 'u{1F1F2}u{1F1ED}',
          emoji: Emojis.flag_MarshallIslands),
      EmojiModel(
          name: 'flag_Martinique',
          code: 'u{1F1F2}u{1F1F6}',
          emoji: Emojis.flag_Martinique),
      EmojiModel(
          name: 'flag_Mauritania',
          code: 'u{1F1F2}u{1F1F7}',
          emoji: Emojis.flag_Mauritania),
      EmojiModel(
          name: 'flag_Mauritius',
          code: 'u{1F1F2}u{1F1FA}',
          emoji: Emojis.flag_Mauritius),
      EmojiModel(
          name: 'flag_Mayotte',
          code: 'u{1F1FE}u{1F1F9}',
          emoji: Emojis.flag_Mayotte),
      EmojiModel(
          name: 'flag_Mexico',
          code: 'u{1F1F2}u{1F1FD}',
          emoji: Emojis.flag_Mexico),
      EmojiModel(
          name: 'flag_Micronesia',
          code: 'u{1F1EB}u{1F1F2}',
          emoji: Emojis.flag_Micronesia),
      EmojiModel(
          name: 'flag_Moldova',
          code: 'u{1F1F2}u{1F1E9}',
          emoji: Emojis.flag_Moldova),
      EmojiModel(
          name: 'flag_Monaco',
          code: 'u{1F1F2}u{1F1E8}',
          emoji: Emojis.flag_Monaco),
      EmojiModel(
          name: 'flag_Mongolia',
          code: 'u{1F1F2}u{1F1F3}',
          emoji: Emojis.flag_Mongolia),
      EmojiModel(
          name: 'flag_Montenegro',
          code: 'u{1F1F2}u{1F1EA}',
          emoji: Emojis.flag_Montenegro),
      EmojiModel(
          name: 'flag_Montserrat',
          code: 'u{1F1F2}u{1F1F8}',
          emoji: Emojis.flag_Montserrat),
      EmojiModel(
          name: 'flag_Morocco',
          code: 'u{1F1F2}u{1F1E6}',
          emoji: Emojis.flag_Morocco),
      EmojiModel(
          name: 'flag_Mozambique',
          code: 'u{1F1F2}u{1F1FF}',
          emoji: Emojis.flag_Mozambique),
      EmojiModel(
          name: 'flag_Myanmar',
          code: 'u{1F1F2}u{1F1F2}',
          emoji: Emojis.flag_Myanmar),
      EmojiModel(
          name: 'flag_Namibia',
          code: 'u{1F1F3}u{1F1E6}',
          emoji: Emojis.flag_Namibia),
      EmojiModel(
          name: 'flag_Nauru',
          code: 'u{1F1F3}u{1F1F7}',
          emoji: Emojis.flag_Nauru),
      EmojiModel(
          name: 'flag_Nepal',
          code: 'u{1F1F3}u{1F1F5}',
          emoji: Emojis.flag_Nepal),
      EmojiModel(
          name: 'flag_Netherlands',
          code: 'u{1F1F3}u{1F1F1}',
          emoji: Emojis.flag_Netherlands),
      EmojiModel(
          name: 'flag_NewCaledonia',
          code: 'u{1F1F3}u{1F1E8}',
          emoji: Emojis.flag_NewCaledonia),
      EmojiModel(
          name: 'flag_NewZealand',
          code: 'u{1F1F3}u{1F1FF}',
          emoji: Emojis.flag_NewZealand),
      EmojiModel(
          name: 'flag_Nicaragua',
          code: 'u{1F1F3}u{1F1EE}',
          emoji: Emojis.flag_Nicaragua),
      EmojiModel(
          name: 'flag_Niger',
          code: 'u{1F1F3}u{1F1EA}',
          emoji: Emojis.flag_Niger),
      EmojiModel(
          name: 'flag_Nigeria',
          code: 'u{1F1F3}u{1F1EC}',
          emoji: Emojis.flag_Nigeria),
      EmojiModel(
          name: 'flag_Niue', code: 'u{1F1F3}u{1F1FA}', emoji: Emojis.flag_Niue),
      EmojiModel(
          name: 'flag_NorfolkIsland',
          code: 'u{1F1F3}u{1F1EB}',
          emoji: Emojis.flag_NorfolkIsland),
      EmojiModel(
          name: 'flag_NorthKorea',
          code: 'u{1F1F0}u{1F1F5}',
          emoji: Emojis.flag_NorthKorea),
      EmojiModel(
          name: 'flag_NorthernMarianaIslands',
          code: 'u{1F1F2}u{1F1F5}',
          emoji: Emojis.flag_NorthernMarianaIslands),
      EmojiModel(
          name: 'flag_Norway',
          code: 'u{1F1F3}u{1F1F4}',
          emoji: Emojis.flag_Norway),
      EmojiModel(
          name: 'flag_Oman', code: 'u{1F1F4}u{1F1F2}', emoji: Emojis.flag_Oman),
      EmojiModel(
          name: 'flag_Pakistan',
          code: 'u{1F1F5}u{1F1F0}',
          emoji: Emojis.flag_Pakistan),
      EmojiModel(
          name: 'flag_Palau',
          code: 'u{1F1F5}u{1F1FC}',
          emoji: Emojis.flag_Palau),
      EmojiModel(
          name: 'flag_PalestinianTerritories',
          code: 'u{1F1F5}u{1F1F8}',
          emoji: Emojis.flag_PalestinianTerritories),
      EmojiModel(
          name: 'flag_Panama',
          code: 'u{1F1F5}u{1F1E6}',
          emoji: Emojis.flag_Panama),
      EmojiModel(
          name: 'flag_PapuaNewGuinea',
          code: 'u{1F1F5}u{1F1EC}',
          emoji: Emojis.flag_PapuaNewGuinea),
      EmojiModel(
          name: 'flag_Paraguay',
          code: 'u{1F1F5}u{1F1FE}',
          emoji: Emojis.flag_Paraguay),
      EmojiModel(
          name: 'flag_Peru', code: 'u{1F1F5}u{1F1EA}', emoji: Emojis.flag_Peru),
      EmojiModel(
          name: 'flag_Philippines',
          code: 'u{1F1F5}u{1F1ED}',
          emoji: Emojis.flag_Philippines),
      EmojiModel(
          name: 'flag_PitcairnIslands',
          code: 'u{1F1F5}u{1F1F3}',
          emoji: Emojis.flag_PitcairnIslands),
      EmojiModel(
          name: 'flag_Poland',
          code: 'u{1F1F5}u{1F1F1}',
          emoji: Emojis.flag_Poland),
      EmojiModel(
          name: 'flag_Portugal',
          code: 'u{1F1F5}u{1F1F9}',
          emoji: Emojis.flag_Portugal),
      EmojiModel(
          name: 'flag_PuertoRico',
          code: 'u{1F1F5}u{1F1F7}',
          emoji: Emojis.flag_PuertoRico),
      EmojiModel(
          name: 'flag_Qatar',
          code: 'u{1F1F6}u{1F1E6}',
          emoji: Emojis.flag_Qatar),
      EmojiModel(
          name: 'flag_Reunion',
          code: 'u{1F1F7}u{1F1EA}',
          emoji: Emojis.flag_Reunion),
      EmojiModel(
          name: 'flag_Romania',
          code: 'u{1F1F7}u{1F1F4}',
          emoji: Emojis.flag_Romania),
      EmojiModel(
          name: 'flag_Russia',
          code: 'u{1F1F7}u{1F1FA}',
          emoji: Emojis.flag_Russia),
      EmojiModel(
          name: 'flag_Rwanda',
          code: 'u{1F1F7}u{1F1FC}',
          emoji: Emojis.flag_Rwanda),
      EmojiModel(
          name: 'flag_Samoa',
          code: 'u{1F1FC}u{1F1F8}',
          emoji: Emojis.flag_Samoa),
      EmojiModel(
          name: 'flag_SanMarino',
          code: 'u{1F1F8}u{1F1F2}',
          emoji: Emojis.flag_SanMarino),
      EmojiModel(
          name: 'flag_SaoTomePrincipe',
          code: 'u{1F1F8}u{1F1F9}',
          emoji: Emojis.flag_SaoTomePrincipe),
      EmojiModel(
          name: 'flag_SaudiArabia',
          code: 'u{1F1F8}u{1F1E6}',
          emoji: Emojis.flag_SaudiArabia),
      EmojiModel(
          name: 'flag_Senegal',
          code: 'u{1F1F8}u{1F1F3}',
          emoji: Emojis.flag_Senegal),
      EmojiModel(
          name: 'flag_Serbia',
          code: 'u{1F1F7}u{1F1F8}',
          emoji: Emojis.flag_Serbia),
      EmojiModel(
          name: 'flag_Seychelles',
          code: 'u{1F1F8}u{1F1E8}',
          emoji: Emojis.flag_Seychelles),
      EmojiModel(
          name: 'flag_SierraLeone',
          code: 'u{1F1F8}u{1F1F1}',
          emoji: Emojis.flag_SierraLeone),
      EmojiModel(
          name: 'flag_Singapore',
          code: 'u{1F1F8}u{1F1EC}',
          emoji: Emojis.flag_Singapore),
      EmojiModel(
          name: 'flag_SintMaarten',
          code: 'u{1F1F8}u{1F1FD}',
          emoji: Emojis.flag_SintMaarten),
      EmojiModel(
          name: 'flag_Slovakia',
          code: 'u{1F1F8}u{1F1F0}',
          emoji: Emojis.flag_Slovakia),
      EmojiModel(
          name: 'flag_Slovenia',
          code: 'u{1F1F8}u{1F1EE}',
          emoji: Emojis.flag_Slovenia),
      EmojiModel(
          name: 'flag_SouthGeorgiaSouthSandwichIslands',
          code: 'u{1F1EC}u{1F1F8}',
          emoji: Emojis.flag_SouthGeorgiaSouthSandwichIslands),
      EmojiModel(
          name: 'flag_SolomonIslands',
          code: 'u{1F1F8}u{1F1E7}',
          emoji: Emojis.flag_SolomonIslands),
      EmojiModel(
          name: 'flag_Somalia',
          code: 'u{1F1F8}u{1F1F4}',
          emoji: Emojis.flag_Somalia),
      EmojiModel(
          name: 'flag_SouthAfrica',
          code: 'u{1F1FF}u{1F1E6}',
          emoji: Emojis.flag_SouthAfrica),
      EmojiModel(
          name: 'flag_SouthKorea',
          code: 'u{1F1F0}u{1F1F7}',
          emoji: Emojis.flag_SouthKorea),
      EmojiModel(
          name: 'flag_SouthSudan',
          code: 'u{1F1F8}u{1F1F8}',
          emoji: Emojis.flag_SouthSudan),
      EmojiModel(
          name: 'flag_Spain',
          code: 'u{1F1EA}u{1F1F8}',
          emoji: Emojis.flag_Spain),
      EmojiModel(
          name: 'flag_SriLanka',
          code: 'u{1F1F1}u{1F1F0}',
          emoji: Emojis.flag_SriLanka),
      EmojiModel(
          name: 'flag_StBarthelemy',
          code: 'u{1F1E7}u{1F1F1}',
          emoji: Emojis.flag_StBarthelemy),
      EmojiModel(
          name: 'flag_StHelena',
          code: 'u{1F1F8}u{1F1ED}',
          emoji: Emojis.flag_StHelena),
      EmojiModel(
          name: 'flag_StKittsNevis',
          code: 'u{1F1F0}u{1F1F3}',
          emoji: Emojis.flag_StKittsNevis),
      EmojiModel(
          name: 'flag_StLucia',
          code: 'u{1F1F1}u{1F1E8}',
          emoji: Emojis.flag_StLucia),
      EmojiModel(
          name: 'flag_StPierreMiquelon',
          code: 'u{1F1F5}u{1F1F2}',
          emoji: Emojis.flag_StPierreMiquelon),
      EmojiModel(
          name: 'flag_StVincentGrenadines',
          code: 'u{1F1FB}u{1F1E8}',
          emoji: Emojis.flag_StVincentGrenadines),
      EmojiModel(
          name: 'flag_Sudan',
          code: 'u{1F1F8}u{1F1E9}',
          emoji: Emojis.flag_Sudan),
      EmojiModel(
          name: 'flag_Suriname',
          code: 'u{1F1F8}u{1F1F7}',
          emoji: Emojis.flag_Suriname),
      EmojiModel(
          name: 'flag_Eswatini',
          code: 'u{1F1F8}u{1F1FF}',
          emoji: Emojis.flag_Eswatini),
      EmojiModel(
          name: 'flag_Sweden',
          code: 'u{1F1F8}u{1F1EA}',
          emoji: Emojis.flag_Sweden),
      EmojiModel(
          name: 'flag_Switzerland',
          code: 'u{1F1E8}u{1F1ED}',
          emoji: Emojis.flag_Switzerland),
      EmojiModel(
          name: 'flag_Syria',
          code: 'u{1F1F8}u{1F1FE}',
          emoji: Emojis.flag_Syria),
      EmojiModel(
          name: 'flag_Taiwan',
          code: 'u{1F1F9}u{1F1FC}',
          emoji: Emojis.flag_Taiwan),
      EmojiModel(
          name: 'flag_Tajikistan',
          code: 'u{1F1F9}u{1F1EF}',
          emoji: Emojis.flag_Tajikistan),
      EmojiModel(
          name: 'flag_Tanzania',
          code: 'u{1F1F9}u{1F1FF}',
          emoji: Emojis.flag_Tanzania),
      EmojiModel(
          name: 'flag_Thailand',
          code: 'u{1F1F9}u{1F1ED}',
          emoji: Emojis.flag_Thailand),
      EmojiModel(
          name: 'flag_TimorLeste',
          code: 'u{1F1F9}u{1F1F1}',
          emoji: Emojis.flag_TimorLeste),
      EmojiModel(
          name: 'flag_Togo', code: 'u{1F1F9}u{1F1EC}', emoji: Emojis.flag_Togo),
      EmojiModel(
          name: 'flag_Tokelau',
          code: 'u{1F1F9}u{1F1F0}',
          emoji: Emojis.flag_Tokelau),
      EmojiModel(
          name: 'flag_Tonga',
          code: 'u{1F1F9}u{1F1F4}',
          emoji: Emojis.flag_Tonga),
      EmojiModel(
          name: 'flag_TrinidadTobago',
          code: 'u{1F1F9}u{1F1F9}',
          emoji: Emojis.flag_TrinidadTobago),
      EmojiModel(
          name: 'flag_Tunisia',
          code: 'u{1F1F9}u{1F1F3}',
          emoji: Emojis.flag_Tunisia),
      EmojiModel(
          name: 'flag_Turkey',
          code: 'u{1F1F9}u{1F1F7}',
          emoji: Emojis.flag_Turkey),
      EmojiModel(
          name: 'flag_Turkmenistan',
          code: 'u{1F1F9}u{1F1F2}',
          emoji: Emojis.flag_Turkmenistan),
      EmojiModel(
          name: 'flag_TurksCaicosIslands',
          code: 'u{1F1F9}u{1F1E8}',
          emoji: Emojis.flag_TurksCaicosIslands),
      EmojiModel(
          name: 'flag_UsVirginIslands',
          code: 'u{1F1FB}u{1F1EE}',
          emoji: Emojis.flag_UsVirginIslands),
      EmojiModel(
          name: 'flag_Tuvalu',
          code: 'u{1F1F9}u{1F1FB}',
          emoji: Emojis.flag_Tuvalu),
      EmojiModel(
          name: 'flag_Uganda',
          code: 'u{1F1FA}u{1F1EC}',
          emoji: Emojis.flag_Uganda),
      EmojiModel(
          name: 'flag_Ukraine',
          code: 'u{1F1FA}u{1F1E6}',
          emoji: Emojis.flag_Ukraine),
      EmojiModel(
          name: 'flag_UnitedArabEmirates',
          code: 'u{1F1E6}u{1F1EA}',
          emoji: Emojis.flag_UnitedArabEmirates),
      EmojiModel(
          name: 'flag_UnitedKingdom',
          code: 'u{1F1EC}u{1F1E7}',
          emoji: Emojis.flag_UnitedKingdom),
      EmojiModel(
          name: 'flag_England',
          code: 'u{1F3F4}u{E0067}u{E0062}u{E0065}u{E006E}u{E0067}u{E007F}',
          emoji: Emojis.flag_England),
      EmojiModel(
          name: 'flag_Scotland',
          code: 'u{1F3F4}u{E0067}u{E0062}u{E0073}u{E0063}u{E0074}u{E007F}',
          emoji: Emojis.flag_Scotland),
      EmojiModel(
          name: 'flag_Wales',
          code: 'u{1F3F4}u{E0067}u{E0062}u{E0077}u{E006C}u{E0073}u{E007F}',
          emoji: Emojis.flag_Wales),
      EmojiModel(
          name: 'flag_UnitedStates',
          code: 'u{1F1FA}u{1F1F8}',
          emoji: Emojis.flag_UnitedStates),
      EmojiModel(
          name: 'flag_Uruguay',
          code: 'u{1F1FA}u{1F1FE}',
          emoji: Emojis.flag_Uruguay),
      EmojiModel(
          name: 'flag_Uzbekistan',
          code: 'u{1F1FA}u{1F1FF}',
          emoji: Emojis.flag_Uzbekistan),
      EmojiModel(
          name: 'flag_Vanuatu',
          code: 'u{1F1FB}u{1F1FA}',
          emoji: Emojis.flag_Vanuatu),
      EmojiModel(
          name: 'flag_VaticanCity',
          code: 'u{1F1FB}u{1F1E6}',
          emoji: Emojis.flag_VaticanCity),
      EmojiModel(
          name: 'flag_Venezuela',
          code: 'u{1F1FB}u{1F1EA}',
          emoji: Emojis.flag_Venezuela),
      EmojiModel(
          name: 'flag_Vietnam',
          code: 'u{1F1FB}u{1F1F3}',
          emoji: Emojis.flag_Vietnam),
      EmojiModel(
          name: 'flag_WallisFutuna',
          code: 'u{1F1FC}u{1F1EB}',
          emoji: Emojis.flag_WallisFutuna),
      EmojiModel(
          name: 'flag_WesternSahara',
          code: 'u{1F1EA}u{1F1ED}',
          emoji: Emojis.flag_WesternSahara),
      EmojiModel(
          name: 'flag_Yemen',
          code: 'u{1F1FE}u{1F1EA}',
          emoji: Emojis.flag_Yemen),
      EmojiModel(
          name: 'flag_Zambia',
          code: 'u{1F1FF}u{1F1F2}',
          emoji: Emojis.flag_Zambia),
      EmojiModel(
          name: 'flag_Zimbabwe',
          code: 'u{1F1FF}u{1F1FC}',
          emoji: Emojis.flag_Zimbabwe),
      EmojiModel(
          name: 'flag_AscensionIsland',
          code: 'u{1F1E6}u{1F1E8}',
          emoji: Emojis.flag_AscensionIsland),
      EmojiModel(
          name: 'flag_BouvetIsland',
          code: 'u{1F1E7}u{1F1FB}',
          emoji: Emojis.flag_BouvetIsland),
      EmojiModel(
          name: 'flag_ClippertonIsland',
          code: 'u{1F1E8}u{1F1F5}',
          emoji: Emojis.flag_ClippertonIsland),
      EmojiModel(
          name: 'flag_CeutaMelilla',
          code: 'u{1F1EA}u{1F1E6}',
          emoji: Emojis.flag_CeutaMelilla),
      EmojiModel(
          name: 'flag_DiegoGarcia',
          code: 'u{1F1E9}u{1F1EC}',
          emoji: Emojis.flag_DiegoGarcia),
      EmojiModel(
          name: 'flag_HeardMcdonaldIslands',
          code: 'u{1F1ED}u{1F1F2}',
          emoji: Emojis.flag_HeardMcdonaldIslands),
      EmojiModel(
          name: 'flag_StMartin',
          code: 'u{1F1F2}u{1F1EB}',
          emoji: Emojis.flag_StMartin),
      EmojiModel(
          name: 'flag_SvalbardJanMayen',
          code: 'u{1F1F8}u{1F1EF}',
          emoji: Emojis.flag_SvalbardJanMayen),
      EmojiModel(
          name: 'flag_TristanDaCunha',
          code: 'u{1F1F9}u{1F1E6}',
          emoji: Emojis.flag_TristanDaCunha),
      EmojiModel(
          name: 'flag_UsOutlyingIslands',
          code: 'u{1F1FA}u{1F1F2}',
          emoji: Emojis.flag_UsOutlyingIslands),
      EmojiModel(
          name: 'flag_UnitedNations',
          code: 'u{1F1FA}u{1F1F3}',
          emoji: Emojis.flag_UnitedNations),
      EmojiModel(
          name: 'tone_lightSkinTone',
          code: 'u{1F3FB}',
          emoji: Emojis.tone_lightSkinTone),
      EmojiModel(
          name: 'tone_mediumLightSkinTone',
          code: 'u{1F3FC}',
          emoji: Emojis.tone_mediumLightSkinTone),
      EmojiModel(
          name: 'tone_mediumSkinTone',
          code: 'u{1F3FD}',
          emoji: Emojis.tone_mediumSkinTone),
      EmojiModel(
          name: 'tone_mediumDarkSkinTone',
          code: 'u{1F3FE}',
          emoji: Emojis.tone_mediumDarkSkinTone),
      EmojiModel(
          name: 'tone_darkSkinTone',
          code: 'u{1F3FF}',
          emoji: Emojis.tone_darkSkinTone),
      EmojiModel(
          name: 'combiningEnclosingKeycap',
          code: 'u{20E3}',
          emoji: Emojis.combiningEnclosingKeycap),
      EmojiModel(
          name: 'variationSelector16',
          code: 'u{FE0F}',
          emoji: Emojis.variationSelector16),
    ];
  }
}
