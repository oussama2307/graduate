// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get first_page_text1 {
    return Intl.message(
      'Welcome',
      name: 'first_page_text1',
      desc: '',
      args: [],
    );
  }

  /// `Welcome , start your adventure to do business.`
  String get first_page_text2 {
    return Intl.message(
      'Welcome , start your adventure to do business.',
      name: 'first_page_text2',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get second_page_text1 {
    return Intl.message(
      'Explore',
      name: 'second_page_text1',
      desc: '',
      args: [],
    );
  }

  /// `Explore new or equipment to improve your project and increase your profits.`
  String get second_page_text2 {
    return Intl.message(
      'Explore new or equipment to improve your project and increase your profits.',
      name: 'second_page_text2',
      desc: '',
      args: [],
    );
  }

  /// `Recover`
  String get third_page_text1 {
    return Intl.message(
      'Recover',
      name: 'third_page_text1',
      desc: '',
      args: [],
    );
  }

  /// `Recover the best offers available on the market and at affordable prices.`
  String get third_page_text2 {
    return Intl.message(
      'Recover the best offers available on the market and at affordable prices.',
      name: 'third_page_text2',
      desc: '',
      args: [],
    );
  }

  /// `Hello, Welcome`
  String get login_page_text1 {
    return Intl.message(
      'Hello, Welcome',
      name: 'login_page_text1',
      desc: '',
      args: [],
    );
  }

  /// `to AgriTech`
  String get login_page_text2 {
    return Intl.message(
      'to AgriTech',
      name: 'login_page_text2',
      desc: '',
      args: [],
    );
  }

  /// `Connect to your account`
  String get login_page_text3 {
    return Intl.message(
      'Connect to your account',
      name: 'login_page_text3',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get login_page_username {
    return Intl.message(
      'Username',
      name: 'login_page_username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_page_password {
    return Intl.message(
      'Password',
      name: 'login_page_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_page_button {
    return Intl.message(
      'Login',
      name: 'login_page_button',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get login_page_question {
    return Intl.message(
      'Don\'t have an account?',
      name: 'login_page_question',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get login_page_proposition {
    return Intl.message(
      'Create an account',
      name: 'login_page_proposition',
      desc: '',
      args: [],
    );
  }

  /// `Create your own account`
  String get signup_page_text1 {
    return Intl.message(
      'Create your own account',
      name: 'signup_page_text1',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get signup_page_nom {
    return Intl.message(
      'Name',
      name: 'signup_page_nom',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get signup_page_Username {
    return Intl.message(
      'Username',
      name: 'signup_page_Username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signup_page_password {
    return Intl.message(
      'Password',
      name: 'signup_page_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get signup_page_confirming {
    return Intl.message(
      'Confirm password',
      name: 'signup_page_confirming',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signup_page_button {
    return Intl.message(
      'SignUp',
      name: 'signup_page_button',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get filters_vente {
    return Intl.message(
      'Sale',
      name: 'filters_vente',
      desc: '',
      args: [],
    );
  }

  /// `Rental`
  String get filter_Location {
    return Intl.message(
      'Rental',
      name: 'filter_Location',
      desc: '',
      args: [],
    );
  }

  /// `Equipment`
  String get filter_Equipement {
    return Intl.message(
      'Equipment',
      name: 'filter_Equipement',
      desc: '',
      args: [],
    );
  }

  /// `Surfaces`
  String get filter_surfaces {
    return Intl.message(
      'Surfaces',
      name: 'filter_surfaces',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get filter_tout {
    return Intl.message(
      'All',
      name: 'filter_tout',
      desc: '',
      args: [],
    );
  }

  /// `Publications to explore`
  String get principal_page_text1 {
    return Intl.message(
      'Publications to explore',
      name: 'principal_page_text1',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get principal_page_text2 {
    return Intl.message(
      'Filter',
      name: 'principal_page_text2',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get card_description {
    return Intl.message(
      'Description',
      name: 'card_description',
      desc: '',
      args: [],
    );
  }

  /// `Type:`
  String get add_text1 {
    return Intl.message(
      'Type:',
      name: 'add_text1',
      desc: '',
      args: [],
    );
  }

  /// `Service:`
  String get add_text2 {
    return Intl.message(
      'Service:',
      name: 'add_text2',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get add_text3 {
    return Intl.message(
      'Description:',
      name: 'add_text3',
      desc: '',
      args: [],
    );
  }

  /// `Price:`
  String get add_text4 {
    return Intl.message(
      'Price:',
      name: 'add_text4',
      desc: '',
      args: [],
    );
  }

  /// `Image:`
  String get add_text5 {
    return Intl.message(
      'Image:',
      name: 'add_text5',
      desc: '',
      args: [],
    );
  }

  /// `Select the type`
  String get add_case1 {
    return Intl.message(
      'Select the type',
      name: 'add_case1',
      desc: '',
      args: [],
    );
  }

  /// `Select the service`
  String get add_case2 {
    return Intl.message(
      'Select the service',
      name: 'add_case2',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get add_case3 {
    return Intl.message(
      'Description',
      name: 'add_case3',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get add_case4 {
    return Intl.message(
      'Price',
      name: 'add_case4',
      desc: '',
      args: [],
    );
  }

  /// `Insert image`
  String get add_button1 {
    return Intl.message(
      'Insert image',
      name: 'add_button1',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get add_button2 {
    return Intl.message(
      'Publish',
      name: 'add_button2',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get profile_title {
    return Intl.message(
      'My Profile',
      name: 'profile_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get profile_case1 {
    return Intl.message(
      'Name',
      name: 'profile_case1',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get profile_case2 {
    return Intl.message(
      'Password',
      name: 'profile_case2',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get profile_case3 {
    return Intl.message(
      'New password',
      name: 'profile_case3',
      desc: '',
      args: [],
    );
  }

  /// `Wilaya`
  String get profile_case4 {
    return Intl.message(
      'Wilaya',
      name: 'profile_case4',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get profile_button {
    return Intl.message(
      'Edit',
      name: 'profile_button',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting_title {
    return Intl.message(
      'Settings',
      name: 'setting_title',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get setting_text1 {
    return Intl.message(
      'My Profile',
      name: 'setting_text1',
      desc: '',
      args: [],
    );
  }

  /// `My publications`
  String get setting_text2 {
    return Intl.message(
      'My publications',
      name: 'setting_text2',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get setting_text3 {
    return Intl.message(
      'Language',
      name: 'setting_text3',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get setting_text4 {
    return Intl.message(
      'Privacy',
      name: 'setting_text4',
      desc: '',
      args: [],
    );
  }

  /// `Contact and publication rights`
  String get setting_text5 {
    return Intl.message(
      'Contact and publication rights',
      name: 'setting_text5',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get setting_button {
    return Intl.message(
      'Logout',
      name: 'setting_button',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get confidence_title1 {
    return Intl.message(
      'Privacy',
      name: 'confidence_title1',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy:`
  String get confidence_title2 {
    return Intl.message(
      'Privacy policy:',
      name: 'confidence_title2',
      desc: '',
      args: [],
    );
  }

  /// `Information we collect:`
  String get confidence_text1 {
    return Intl.message(
      'Information we collect:',
      name: 'confidence_text1',
      desc: '',
      args: [],
    );
  }

  /// `When you use our app or services, we may collect the following information from you: Personal information: this includes your name, email address, phone number, and other information you provide when you sign up for our services. Usage information: This includes information about how you use our website and services, including your IP address, browser type, and the pages you visit`
  String get confidence_text2 {
    return Intl.message(
      'When you use our app or services, we may collect the following information from you: Personal information: this includes your name, email address, phone number, and other information you provide when you sign up for our services. Usage information: This includes information about how you use our website and services, including your IP address, browser type, and the pages you visit',
      name: 'confidence_text2',
      desc: '',
      args: [],
    );
  }

  /// `How we use your information:`
  String get confidence_text3 {
    return Intl.message(
      'How we use your information:',
      name: 'confidence_text3',
      desc: '',
      args: [],
    );
  }

  /// `We use your personal information to provide our services, to communicate with you about our services, and to improve our services. We may also use your information to send you marketing communications if you have opted in to receive them. We use usage information to analyze how our website and services are being used, to diagnose problems with our app and services, and to improve our app and services.`
  String get confidence_text4 {
    return Intl.message(
      'We use your personal information to provide our services, to communicate with you about our services, and to improve our services. We may also use your information to send you marketing communications if you have opted in to receive them. We use usage information to analyze how our website and services are being used, to diagnose problems with our app and services, and to improve our app and services.',
      name: 'confidence_text4',
      desc: '',
      args: [],
    );
  }

  /// `How we protect your information:`
  String get confidence_text5 {
    return Intl.message(
      'How we protect your information:',
      name: 'confidence_text5',
      desc: '',
      args: [],
    );
  }

  /// `We use reasonable security measures to protect your personal information against unauthorized access, use, or disclosure. However, no method of transmission over the internet or method of electronic storage is 100% secure, and we cannot guarantee the absolute security of your personal information.`
  String get confidence_text6 {
    return Intl.message(
      'We use reasonable security measures to protect your personal information against unauthorized access, use, or disclosure. However, no method of transmission over the internet or method of electronic storage is 100% secure, and we cannot guarantee the absolute security of your personal information.',
      name: 'confidence_text6',
      desc: '',
      args: [],
    );
  }

  /// `Sharing of information:`
  String get confidence_text7 {
    return Intl.message(
      'Sharing of information:',
      name: 'confidence_text7',
      desc: '',
      args: [],
    );
  }

  /// `We do not sell, rent, or share your personal information with third parties, except as described in this privacy policy. We may share your personal information with our service providers who need access to your personal information to provide services to us. We may also share your personal information if we in good faith believe that disclosure is necessary to comply with applicable law, regulation, legal process, or governmental request.`
  String get confidence_text8 {
    return Intl.message(
      'We do not sell, rent, or share your personal information with third parties, except as described in this privacy policy. We may share your personal information with our service providers who need access to your personal information to provide services to us. We may also share your personal information if we in good faith believe that disclosure is necessary to comply with applicable law, regulation, legal process, or governmental request.',
      name: 'confidence_text8',
      desc: '',
      args: [],
    );
  }

  /// `Your rights:`
  String get confidence_text9 {
    return Intl.message(
      'Your rights:',
      name: 'confidence_text9',
      desc: '',
      args: [],
    );
  }

  /// `You have the right to access, correct, or delete your personal information that we hold about you. You may also have the right to object to or restrict the processing of your personal information and to receive a copy of your personal information in a structured and machine-readable format.`
  String get confidence_text10 {
    return Intl.message(
      'You have the right to access, correct, or delete your personal information that we hold about you. You may also have the right to object to or restrict the processing of your personal information and to receive a copy of your personal information in a structured and machine-readable format.',
      name: 'confidence_text10',
      desc: '',
      args: [],
    );
  }

  /// `Changes to this policy`
  String get confidence_text11 {
    return Intl.message(
      'Changes to this policy',
      name: 'confidence_text11',
      desc: '',
      args: [],
    );
  }

  /// `We may update this privacy policy from time to time. If we make material changes to this privacy policy, we will notify you by email or by posting a notice on our app.`
  String get confidence_text12 {
    return Intl.message(
      'We may update this privacy policy from time to time. If we make material changes to this privacy policy, we will notify you by email or by posting a notice on our app.',
      name: 'confidence_text12',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get confidence_text13 {
    return Intl.message(
      'Contact us',
      name: 'confidence_text13',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions or concerns about this privacy policy, or if you would like to exercise your rights regarding your personal information, please contact us through this website, the mobile app, or the contact information above.`
  String get confidnece_text14 {
    return Intl.message(
      'If you have any questions or concerns about this privacy policy, or if you would like to exercise your rights regarding your personal information, please contact us through this website, the mobile app, or the contact information above.',
      name: 'confidnece_text14',
      desc: '',
      args: [],
    );
  }

  /// `All development and publishing rights are reserved for the developer and supervisor, Dr. Kherici.`
  String get contact_text {
    return Intl.message(
      'All development and publishing rights are reserved for the developer and supervisor, Dr. Kherici.',
      name: 'contact_text',
      desc: '',
      args: [],
    );
  }

  /// `Select your language`
  String get setting_list {
    return Intl.message(
      'Select your language',
      name: 'setting_list',
      desc: '',
      args: [],
    );
  }

  /// `My Favorites`
  String get favorite_title {
    return Intl.message(
      'My Favorites',
      name: 'favorite_title',
      desc: '',
      args: [],
    );
  }

  /// `My Posts`
  String get myposts_title {
    return Intl.message(
      'My Posts',
      name: 'myposts_title',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details_title {
    return Intl.message(
      'Details',
      name: 'details_title',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get details_text1 {
    return Intl.message(
      'Description:',
      name: 'details_text1',
      desc: '',
      args: [],
    );
  }

  /// `Price:`
  String get details_text2 {
    return Intl.message(
      'Price:',
      name: 'details_text2',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get details_text3 {
    return Intl.message(
      'Type',
      name: 'details_text3',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get details_text4 {
    return Intl.message(
      'Service',
      name: 'details_text4',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get details_text5 {
    return Intl.message(
      'Schedule',
      name: 'details_text5',
      desc: '',
      args: [],
    );
  }

  /// `Availability`
  String get details_text6 {
    return Intl.message(
      'Availability',
      name: 'details_text6',
      desc: '',
      args: [],
    );
  }

  /// `Images:`
  String get details_text7 {
    return Intl.message(
      'Images:',
      name: 'details_text7',
      desc: '',
      args: [],
    );
  }

  /// `No images`
  String get details_noimages {
    return Intl.message(
      'No images',
      name: 'details_noimages',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get details_modify {
    return Intl.message(
      'Modify',
      name: 'details_modify',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get details_delete {
    return Intl.message(
      'Delete',
      name: 'details_delete',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get details_sendmessage {
    return Intl.message(
      'Send Message',
      name: 'details_sendmessage',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update_tilte {
    return Intl.message(
      'Update',
      name: 'update_tilte',
      desc: '',
      args: [],
    );
  }

  /// `Type:`
  String get update_text1 {
    return Intl.message(
      'Type:',
      name: 'update_text1',
      desc: '',
      args: [],
    );
  }

  /// `Service:`
  String get update_text2 {
    return Intl.message(
      'Service:',
      name: 'update_text2',
      desc: '',
      args: [],
    );
  }

  /// `Availability:`
  String get update_text3 {
    return Intl.message(
      'Availability:',
      name: 'update_text3',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get update_text4 {
    return Intl.message(
      'Description:',
      name: 'update_text4',
      desc: '',
      args: [],
    );
  }

  /// `Price:`
  String get update_text5 {
    return Intl.message(
      'Price:',
      name: 'update_text5',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get update_button {
    return Intl.message(
      'Modify',
      name: 'update_button',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get delete_dialogue_title {
    return Intl.message(
      'Confirmation',
      name: 'delete_dialogue_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete?`
  String get delete_dialogue_content {
    return Intl.message(
      'Are you sure to delete?',
      name: 'delete_dialogue_content',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get delete_dialogue_yes {
    return Intl.message(
      'Yes',
      name: 'delete_dialogue_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get delete_dialogue_no {
    return Intl.message(
      'No',
      name: 'delete_dialogue_no',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
