import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'z_components/buttons/general_buttons/bldrs_box.dart';

/// SUPER_DEV_TEST

const bool showTestButton = false;

Future<void> superDevTestGoX() async {

  final UserModel? _user = UsersProvider.proGetMyUserModel(context: getMainContext(), listen: false);

  _user?.blogUserModel(invoker: 'this bitch');

  final List<AccountModel> _accounts = await AccountLDBOps.readAllAccounts();
  AccountModel.blogAccounts(_accounts);

}

class TheFastTestButton extends StatelessWidget {

  const TheFastTestButton({
    required this.onTap,
    super.key,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: 60,
      width: 60,
      icon: Iconz.star,
      color: Colorz.bloodTest,
      iconSizeFactor: 0.6,
      onTap: onTap,
    );
  }
}


/// CHAT GBT PROMPTS
/*

for the following flutter method, write group of at-least 7 test methods in one test group to assure its perfectly
working, and call this static function from class called ( ________________ )


------------------

CHAT GBT TRANSLATION PROMPT

for the following list of lines by english and arabic
please figure out the best translation equivalent to each line into [es, it, de, fr, zh, tr, hi, ru, pt, fa]
and please only reply with the list of answers with the same order
do not explain anything, do not illustrate, just reply with translation value directly

don't do, don't write the keys or the source while replying to me
key: translation
key: translation
...

but do directly this without adding descriptions, pronunciations or any extra text
[langCode]
translation
translation
...

 */

// --------------

/*
for the following english and arabic equivalents
please conclude the translation of them in those langs [ar, es, it, de, fr, zh, tr, hi, ru, pt, fa]
write me the key value pairs for each lang in a Map<String, dynamic> {
  langCode: translation,
}

dont use this ' ' or this " " or this ''' ''' or this """ """
just write the values

* */


/*

17841447816479749?fields=business_discovery.username(modulorstudio_eg)

17841447816479749?fields=profile_picture_url,ig_id,followers_count,name,website,media

business_discovery.username(modulorstudio_eg) {
    profile_picture_url,
    ig_id,
    followers_count,
    name,
    biography,
    website,
    media {
      media_url,
      children {
        media_url
      }
    }
}



 */