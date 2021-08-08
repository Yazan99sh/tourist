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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tourists`
  String get title {
    return Intl.message(
      'Tourists',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Soyah`
  String get welcome {
    return Intl.message(
      'Welcome to Soyah',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `I want to enjoy your services while I'm in Saudi Arabia`
  String get card_01 {
    return Intl.message(
      'I want to enjoy your services while I\'m in Saudi Arabia',
      name: 'card_01',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get go_to_tourist_login {
    return Intl.message(
      'Next',
      name: 'go_to_tourist_login',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register a new Account`
  String get move_to_register {
    return Intl.message(
      'Register a new Account',
      name: 'move_to_register',
      desc: '',
      args: [],
    );
  }

  /// `I have an account!`
  String get move_to_login {
    return Intl.message(
      'I have an account!',
      name: 'move_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register_submit {
    return Intl.message(
      'Register',
      name: 'register_submit',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get form_label_name {
    return Intl.message(
      'Name',
      name: 'form_label_name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Not Available`
  String get not_available {
    return Intl.message(
      'Not Available',
      name: 'not_available',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Festivals`
  String get festivals {
    return Intl.message(
      'Festivals',
      name: 'festivals',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Saving Data`
  String get saving_cata {
    return Intl.message(
      'Saving Data',
      name: 'saving_cata',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Language`
  String get toast_select_language {
    return Intl.message(
      'Please Select a Language',
      name: 'toast_select_language',
      desc: '',
      args: [],
    );
  }

  /// `Select a Gender`
  String get select_gender {
    return Intl.message(
      'Select a Gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Select a Language`
  String get select_language {
    return Intl.message(
      'Select a Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get language_arabic {
    return Intl.message(
      'العربية',
      name: 'language_arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language_english {
    return Intl.message(
      'English',
      name: 'language_english',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get error_null_text {
    return Intl.message(
      'Please enter some text',
      name: 'error_null_text',
      desc: '',
      args: [],
    );
  }

  /// `Error Fetching Data!`
  String get error_fetching_data {
    return Intl.message(
      'Error Fetching Data!',
      name: 'error_fetching_data',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `No Events for now!`
  String get no_events_yet {
    return Intl.message(
      'No Events for now!',
      name: 'no_events_yet',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit an App`
  String get exit_msg {
    return Intl.message(
      'Do you want to exit an App',
      name: 'exit_msg',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `SHOW MORE`
  String get show_more {
    return Intl.message(
      'SHOW MORE',
      name: 'show_more',
      desc: '',
      args: [],
    );
  }

  /// `Guides`
  String get guides {
    return Intl.message(
      'Guides',
      name: 'guides',
      desc: '',
      args: [],
    );
  }

  /// `No Images?!!`
  String get error_no_images {
    return Intl.message(
      'No Images?!!',
      name: 'error_no_images',
      desc: '',
      args: [],
    );
  }

  /// `Successfully registered`
  String get successfully_registered {
    return Intl.message(
      'Successfully registered',
      name: 'successfully_registered',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registration_failed {
    return Intl.message(
      'Registration failed',
      name: 'registration_failed',
      desc: '',
      args: [],
    );
  }

  /// `Requesting the guide was completed, he/she will contact you as soon as possible`
  String get request_guide_msg_success {
    return Intl.message(
      'Requesting the guide was completed, he/she will contact you as soon as possible',
      name: 'request_guide_msg_success',
      desc: '',
      args: [],
    );
  }

  /// `Return to Home`
  String get return_to_home {
    return Intl.message(
      'Return to Home',
      name: 'return_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Request for Guide`
  String get request_for_guide {
    return Intl.message(
      'Request for Guide',
      name: 'request_for_guide',
      desc: '',
      args: [],
    );
  }

  /// `Request Guid!`
  String get request_guid {
    return Intl.message(
      'Request Guid!',
      name: 'request_guid',
      desc: '',
      args: [],
    );
  }

  /// `Request Guide`
  String get request_guide {
    return Intl.message(
      'Request Guide',
      name: 'request_guide',
      desc: '',
      args: [],
    );
  }

  /// `Request Tour`
  String get request_tour {
    return Intl.message(
      'Request Tour',
      name: 'request_tour',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Show Less`
  String get showLess {
    return Intl.message(
      'Show Less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `Signing out`
  String get signing_out {
    return Intl.message(
      'Signing out',
      name: 'signing_out',
      desc: '',
      args: [],
    );
  }

  /// `Request Sent!`
  String get requestSent {
    return Intl.message(
      'Request Sent!',
      name: 'requestSent',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Request a Guide`
  String get requestAGuide {
    return Intl.message(
      'Request a Guide',
      name: 'requestAGuide',
      desc: '',
      args: [],
    );
  }

  /// `Make a General Request`
  String get makeAGeneralRequest {
    return Intl.message(
      'Make a General Request',
      name: 'makeAGeneralRequest',
      desc: '',
      args: [],
    );
  }

  /// `Expected Communication Language`
  String get expectedCommunicationLanguage {
    return Intl.message(
      'Expected Communication Language',
      name: 'expectedCommunicationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Target City`
  String get targetCity {
    return Intl.message(
      'Target City',
      name: 'targetCity',
      desc: '',
      args: [],
    );
  }

  /// `Staying for`
  String get stayingFor {
    return Intl.message(
      'Staying for',
      name: 'stayingFor',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get car {
    return Intl.message(
      'Car',
      name: 'car',
      desc: '',
      args: [],
    );
  }

  /// `Hotel`
  String get hotel {
    return Intl.message(
      'Hotel',
      name: 'hotel',
      desc: '',
      args: [],
    );
  }

  /// `Request a Chat!`
  String get requestAChat {
    return Intl.message(
      'Request a Chat!',
      name: 'requestAChat',
      desc: '',
      args: [],
    );
  }

  /// `Stying For`
  String get stying_for {
    return Intl.message(
      'Stying For',
      name: 'stying_for',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Update My Profile`
  String get updateMyProfile {
    return Intl.message(
      'Update My Profile',
      name: 'updateMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Accept Order`
  String get accept_order {
    return Intl.message(
      'Accept Order',
      name: 'accept_order',
      desc: '',
      args: [],
    );
  }

  /// `Open Chat`
  String get openChat {
    return Intl.message(
      'Open Chat',
      name: 'openChat',
      desc: '',
      args: [],
    );
  }

  /// `I am a Guide Operating in Saudi Arabia`
  String get iAmAGuideOperatingInSaudiArabia {
    return Intl.message(
      'I am a Guide Operating in Saudi Arabia',
      name: 'iAmAGuideOperatingInSaudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `I am a Guide Operating in Saudi Arabia`
  String get card_02 {
    return Intl.message(
      'I am a Guide Operating in Saudi Arabia',
      name: 'card_02',
      desc: '',
      args: [],
    );
  }

  /// `Logged in:`
  String get loggedIn {
    return Intl.message(
      'Logged in:',
      name: 'loggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Guide`
  String get guide {
    return Intl.message(
      'Guide',
      name: 'guide',
      desc: '',
      args: [],
    );
  }

  /// `Tourist`
  String get tourist {
    return Intl.message(
      'Tourist',
      name: 'tourist',
      desc: '',
      args: [],
    );
  }

  /// `Arrival Date`
  String get arrivalDate {
    return Intl.message(
      'Arrival Date',
      name: 'arrivalDate',
      desc: '',
      args: [],
    );
  }

  /// `Not Logged In`
  String get notLoggedIn {
    return Intl.message(
      'Not Logged In',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Mountains`
  String get mountains {
    return Intl.message(
      'Mountains',
      name: 'mountains',
      desc: '',
      args: [],
    );
  }

  /// `Dessert`
  String get dessert {
    return Intl.message(
      'Dessert',
      name: 'dessert',
      desc: '',
      args: [],
    );
  }

  /// `Malls`
  String get malls {
    return Intl.message(
      'Malls',
      name: 'malls',
      desc: '',
      args: [],
    );
  }

  /// `I came for:`
  String get iCameFor {
    return Intl.message(
      'I came for:',
      name: 'iCameFor',
      desc: '',
      args: [],
    );
  }

  /// `Sent / Pending`
  String get sentPending {
    return Intl.message(
      'Sent / Pending',
      name: 'sentPending',
      desc: '',
      args: [],
    );
  }

  /// `Pending Payment`
  String get pendingPayment {
    return Intl.message(
      'Pending Payment',
      name: 'pendingPayment',
      desc: '',
      args: [],
    );
  }

  /// `Payed / On going`
  String get payedOnGoing {
    return Intl.message(
      'Payed / On going',
      name: 'payedOnGoing',
      desc: '',
      args: [],
    );
  }

  /// `Finished Orders`
  String get finishedOrders {
    return Intl.message(
      'Finished Orders',
      name: 'finishedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Code`
  String get confirmCode {
    return Intl.message(
      'Confirm Code',
      name: 'confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Please input your phone number`
  String get pleaseInputYourPhoneNumber {
    return Intl.message(
      'Please input your phone number',
      name: 'pleaseInputYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Register Success, Setup My Profile`
  String get registerSuccessSetupMyProfile {
    return Intl.message(
      'Register Success, Setup My Profile',
      name: 'registerSuccessSetupMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email Address is Required`
  String get emailAddressIsRequired {
    return Intl.message(
      'Email Address is Required',
      name: 'emailAddressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get passwordIsTooShort {
    return Intl.message(
      'Password is too short',
      name: 'passwordIsTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameIsRequired {
    return Intl.message(
      'Name is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `I have an account`
  String get iHaveAnAccount {
    return Intl.message(
      'I have an account',
      name: 'iHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get saudiArabia {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `Lebanon`
  String get lebanon {
    return Intl.message(
      'Lebanon',
      name: 'lebanon',
      desc: '',
      args: [],
    );
  }

  /// `Syria`
  String get syria {
    return Intl.message(
      'Syria',
      name: 'syria',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Send Me Code`
  String get sendMeCode {
    return Intl.message(
      'Send Me Code',
      name: 'sendMeCode',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the form`
  String get pleaseCompleteTheForm {
    return Intl.message(
      'Please complete the form',
      name: 'pleaseCompleteTheForm',
      desc: '',
      args: [],
    );
  }

  /// `Send Login Link`
  String get sendLoginLink {
    return Intl.message(
      'Send Login Link',
      name: 'sendLoginLink',
      desc: '',
      args: [],
    );
  }

  /// `Please Check your Email!`
  String get pleaseCheckYourEmail {
    return Intl.message(
      'Please Check your Email!',
      name: 'pleaseCheckYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email/Phone`
  String get emailphone {
    return Intl.message(
      'Email/Phone',
      name: 'emailphone',
      desc: '',
      args: [],
    );
  }

  /// `Please input an Email or a phone number`
  String get pleaseInputAnEmailOrAPhoneNumber {
    return Intl.message(
      'Please input an Email or a phone number',
      name: 'pleaseInputAnEmailOrAPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Requesting Profile From the Server`
  String get requestingProfileFromTheServer {
    return Intl.message(
      'Requesting Profile From the Server',
      name: 'requestingProfileFromTheServer',
      desc: '',
      args: [],
    );
  }

  /// `My Name`
  String get myName {
    return Intl.message(
      'My Name',
      name: 'myName',
      desc: '',
      args: [],
    );
  }

  /// `About Me`
  String get aboutMe {
    return Intl.message(
      'About Me',
      name: 'aboutMe',
      desc: '',
      args: [],
    );
  }

  /// `Save Profile`
  String get saveProfile {
    return Intl.message(
      'Save Profile',
      name: 'saveProfile',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message(
      'Saving',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Select Image from Gallery`
  String get selectImageFromGallery {
    return Intl.message(
      'Select Image from Gallery',
      name: 'selectImageFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Capture My Image From Camera`
  String get captureMyImageFromCamera {
    return Intl.message(
      'Capture My Image From Camera',
      name: 'captureMyImageFromCamera',
      desc: '',
      args: [],
    );
  }

  /// `Capture My Image`
  String get captureMyImage {
    return Intl.message(
      'Capture My Image',
      name: 'captureMyImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Uploading`
  String get uploading {
    return Intl.message(
      'Uploading',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `Please Upload Your Image`
  String get pleaseUploadYourImage {
    return Intl.message(
      'Please Upload Your Image',
      name: 'pleaseUploadYourImage',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please Enter Your Name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Locations you work in`
  String get locationsYouWorkIn {
    return Intl.message(
      'Locations you work in',
      name: 'locationsYouWorkIn',
      desc: '',
      args: [],
    );
  }

  /// `Location Name`
  String get locationName {
    return Intl.message(
      'Location Name',
      name: 'locationName',
      desc: '',
      args: [],
    );
  }

  /// `Location Description`
  String get locationDescription {
    return Intl.message(
      'Location Description',
      name: 'locationDescription',
      desc: '',
      args: [],
    );
  }

  /// `My Phone number`
  String get myPhoneNumber {
    return Intl.message(
      'My Phone number',
      name: 'myPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Guides Area`
  String get guidesArea {
    return Intl.message(
      'Guides Area',
      name: 'guidesArea',
      desc: '',
      args: [],
    );
  }

  /// `Search Query`
  String get searchQuery {
    return Intl.message(
      'Search Query',
      name: 'searchQuery',
      desc: '',
      args: [],
    );
  }

  /// `Price proposal`
  String get priceProposal {
    return Intl.message(
      'Price proposal',
      name: 'priceProposal',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `On Going`
  String get onGoing {
    return Intl.message(
      'On Going',
      name: 'onGoing',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get finished {
    return Intl.message(
      'Finished',
      name: 'finished',
      desc: '',
      args: [],
    );
  }

  /// `Proposal`
  String get proposal {
    return Intl.message(
      'Proposal',
      name: 'proposal',
      desc: '',
      args: [],
    );
  }

  /// `Login as guide`
  String get loginAsGuide {
    return Intl.message(
      'Login as guide',
      name: 'loginAsGuide',
      desc: '',
      args: [],
    );
  }

  /// `Login as tourist`
  String get loginAsTourist {
    return Intl.message(
      'Login as tourist',
      name: 'loginAsTourist',
      desc: '',
      args: [],
    );
  }

  /// `Soyah`
  String get soyah {
    return Intl.message(
      'Soyah',
      name: 'soyah',
      desc: '',
      args: [],
    );
  }

  /// `rating`
  String get rating {
    return Intl.message(
      'rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Login Status`
  String get loginStatus {
    return Intl.message(
      'Login Status',
      name: 'loginStatus',
      desc: '',
      args: [],
    );
  }

  /// `Empty List`
  String get empty {
    return Intl.message(
      'Empty List',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continues {
    return Intl.message(
      'Continue',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Chat Room`
  String get chatRoom {
    return Intl.message(
      'Chat Room',
      name: 'chatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Start Writing`
  String get startWriting {
    return Intl.message(
      'Start Writing',
      name: 'startWriting',
      desc: '',
      args: [],
    );
  }

  /// `Empty Text`
  String get emptyText {
    return Intl.message(
      'Empty Text',
      name: 'emptyText',
      desc: '',
      args: [],
    );
  }

  /// `Loging Please`
  String get loginPlease {
    return Intl.message(
      'Loging Please',
      name: 'loginPlease',
      desc: '',
      args: [],
    );
  }

  /// `Be the First to comment`
  String get firstComment {
    return Intl.message(
      'Be the First to comment',
      name: 'firstComment',
      desc: '',
      args: [],
    );
  }

  /// `Comment Here`
  String get commentHere {
    return Intl.message(
      'Comment Here',
      name: 'commentHere',
      desc: '',
      args: [],
    );
  }

  /// `CC Payment works`
  String get ccPay {
    return Intl.message(
      'CC Payment works',
      name: 'ccPay',
      desc: '',
      args: [],
    );
  }

  /// `Request Success`
  String get requestSuccess {
    return Intl.message(
      'Request Success',
      name: 'requestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Soon`
  String get soon {
    return Intl.message(
      'Soon',
      name: 'soon',
      desc: '',
      args: [],
    );
  }

  /// `No guides for this place was found`
  String get noGuides {
    return Intl.message(
      'No guides for this place was found',
      name: 'noGuides',
      desc: '',
      args: [],
    );
  }

  /// `Refuse Order`
  String get refused {
    return Intl.message(
      'Refuse Order',
      name: 'refused',
      desc: '',
      args: [],
    );
  }

  /// `Finish Order`
  String get finishOrder {
    return Intl.message(
      'Finish Order',
      name: 'finishOrder',
      desc: '',
      args: [],
    );
  }

  /// `This value is required`
  String get valueRequred {
    return Intl.message(
      'This value is required',
      name: 'valueRequred',
      desc: '',
      args: [],
    );
  }

  /// `There is no result found`
  String get notFound {
    return Intl.message(
      'There is no result found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Create a Request`
  String get createNewOrder {
    return Intl.message(
      'Create a Request',
      name: 'createNewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Rating average`
  String get ratingAverage {
    return Intl.message(
      'Rating average',
      name: 'ratingAverage',
      desc: '',
      args: [],
    );
  }

  /// `Error finding the profile, please register first`
  String get errorFindingProfile {
    return Intl.message(
      'Error finding the profile, please register first',
      name: 'errorFindingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Code Timeout`
  String get codeTimeout {
    return Intl.message(
      'Code Timeout',
      name: 'codeTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Saved`
  String get successfully_saved {
    return Intl.message(
      'Successfully Saved',
      name: 'successfully_saved',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get city {
    return Intl.message(
      'Region',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get cost {
    return Intl.message(
      'Cost',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `You can chat with the tourist after payment phase`
  String get chatWithTourest {
    return Intl.message(
      'You can chat with the tourist after payment phase',
      name: 'chatWithTourest',
      desc: '',
      args: [],
    );
  }

  /// `You can chat with the guide after payment phase`
  String get chatWithGuid {
    return Intl.message(
      'You can chat with the guide after payment phase',
      name: 'chatWithGuid',
      desc: '',
      args: [],
    );
  }

  /// `Rate this area`
  String get rateThisLocation {
    return Intl.message(
      'Rate this area',
      name: 'rateThisLocation',
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
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}