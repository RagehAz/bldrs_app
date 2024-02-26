library fish_tank;

import 'dart:async';

import 'package:basics/bldrs_theme/assets/planet/all_flags_list.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/animators/scroller.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/components/dialogs/bottom_dialog.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/linker.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_clip_board.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/models/america.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_screens/d_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_screens/g_search_screen/z_components/building_blocks/filter_bool_tile.dart';
import 'package:bldrs/b_screens/g_search_screen/z_components/building_blocks/filter_multi_button_tile.dart';
import 'package:bldrs/b_screens/g_search_screen/z_components/building_blocks/filters_box.dart';
import 'package:bldrs/b_screens/g_search_screen/z_components/filters_tiles/countries_filter_tile.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contacts_wrap.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/social_field_editor_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:collection/collection.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

part 'src/screens/bzz_fish_tank_manager.dart';
part 'src/screens/fish_maker_screen.dart';
part 'src/models/fish_model.dart';
part 'src/fish_protocols/fish_ldb_ops.dart';
part 'src/fish_protocols/fish_protocols.dart';
part 'src/fish_protocols/fish_real_ops.dart';
part 'src/components/fish_tile.dart';
part '../i_gt_insta_screen/src/models/insta_profile.dart';
/// SCRAP_EYE_OF_RIYADH
// part 'src/fish_protocols/eye_of_riyadh_scrapper.dart';
