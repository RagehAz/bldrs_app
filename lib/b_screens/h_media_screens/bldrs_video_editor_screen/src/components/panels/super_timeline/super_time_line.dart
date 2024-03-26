library super_time_line;

import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/video_maker/video_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'src/a_time_line.dart';
part 'src/b_ruler.dart';
part 'src/c_time_line_selector.dart';
part 'src/d_current_second_text.dart';
part 'src/e_seconds_boxes.dart';
part 'src/f_timeline_bar.dart';
part 'src/g_selector_parts.dart';
part 'src/z_frame_model.dart';
part 'src/h_video_boxer.dart';
part 'src/i_frames_loading_indicator.dart';

part 'src/z_timeline_scales.dart';
