import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  String get heyWorld {
    return Intl.message(
      'Hey World',
      name: 'heyWorld',
      desc: 'Simpel word for greeting ',
    );
  }
  String get areYou {
    return Intl.message(
      'Are you ?',
      name: 'areYou',
    );
  }
  String get user {
    return Intl.message(
      'User ',
      name: 'user',
    );
  }
  String get foodTruckOwner {
    return Intl.message(
      'Food Truck Owner',
      name: 'foodTruckOwner',
    );
  }
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
    );
  }
  String get contiueAsAGuest {
    return Intl.message(
      'Contiue As A Guest',
      name: 'contiueAsAGuest',
    );
  }
  String get welcome {
    return Intl.message(
      'Welcome to Which Stop? !!',
      name: 'welcome',
    );
  }
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
    );
  }
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
    );
  }
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
    );
  }
  String get forgotpass {
    return Intl.message(
      'Forgot Passsword ?',
      name: 'forgotpass',
    );
  }
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
    );
  }
  String get createAccnt {
    return Intl.message(
      "Create an account with Which Stop ? ",
      name: 'createAccnt',
    );
  }
  String get firstName {
    return Intl.message(
      "First Name",
      name: 'firstName',
    );
  }
  String get lastName {
    return Intl.message(
      "Last Name",
      name: 'lastName',
    );
  }
  String get emailAddress {
    return Intl.message(
      "E-Mail Adress",
      name: 'emailAddress',
    );
  }
  String get confirmPass {
    return Intl.message(
      "Confirm Password",
      name: 'confirmPass',
    );
  }
  String get dob {
    return Intl.message(
      "Date of Birth",
      name: 'dob',
    );
  }
  String get country {
    return Intl.message(
      "Country",
      name: 'country',
    );
  }
  String get continueButton {
    return Intl.message(
      "Continue",
      name: 'continueButton',
    );
  }
}



class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}

// command to generate strings from getters
//flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale/app_localization.dart

// command to generate dart files in l10n
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/locale/app_localization.dart lib/l10n/intl_en.arb lib/l10n/intl_ar.arb lib/l10n/intl_messages.arb