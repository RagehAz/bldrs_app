library bldrs_video_editor;

import 'dart:io';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/video_maker/video_maker.dart';
import 'package:basics/mediator/video_maker/video_ops.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_video_editor_screen/src/components/panels/super_timeline/super_time_line.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_nab_button/editor_nav_button.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_media_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/g_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/i_gt_insta_screen/src/screens/video_player_screen.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/zzzzz_videos_test_lab/video_dialog.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';

/// COMPONENTS
part 'src/components/panels/video_editor_panel_switcher.dart';
part 'src/components/video_zone/video_editor_video_zone.dart';
part 'src/components/play_bar/video_editor_play_bar.dart';

part 'src/components/nav_bar/video_editor_nav_bar.dart';

/// CONTROLLERS
part 'src/controllers/video_editor_scales.dart';

/// VIEWS
part 'src/views/video_cover_creator_screen.dart';
part 'src/views/video_editor_screen.dart';
