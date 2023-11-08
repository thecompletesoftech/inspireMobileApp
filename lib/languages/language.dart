import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  ///************** Common String get  **************///

  String get isLoading;
  String get appName;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= laungauge screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get chooseLanguage;

  String get english;

  String get saudiArabia;

  String get arabic;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Intro screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get skip;

  String get next;

  String get living;

  String get weAre;

  String get weAlso;

  String get getStarted;
  String get pleaseFollowToBus;
  String get errorOwnReport;
  String get errorOwnMsg;
  String get errorOwnFollow;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Login screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get signUp;

  String get loginTo;

  String get email;

  String get password;

  String get forgetPassword;

  String get login;

  String get continueAs;

  String get clickHere;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= forgot password screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get enterYour;

  String get demoMail;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= OTP screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get enterDigit;

  String get codeSend;

  String get didntRecive;

  String get resend;

  String get codeToNumber;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Reset password screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get reset;

  String get enterA;

  String get newPassword;

  String get confirmNewPassword;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= congratulation screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get congrats;

  String get resetSuccessful;

  String get yourProfile;

  String get back;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Reset password screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get welcome;

  String get business;

  String get user;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= signup screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get signupFor;

  String get iAgree;

  String get termsAndConditions;

  String get privacyPolicy;

  String get createAccount;

  String get orCountinue;

  String get google;

  String get apple;

  String get confirmPassword;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= create account screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get upload;

  String get fromGallery;

  String get takePhoto;

  String get tapTo;

  String get chooseGender;

  String get male;

  String get female;

  String get firstName;

  String get lastName;

  String get dateOfBirth;

  String get gender;

  String get done;

  String get mobileNumber;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Set location screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get setLocation;

  String get thisData;

  String get yourLocation;

  String get allowLocation;

  String get editLocation;

  String get address;
  String get urlNotFound;
  String get urlIsNotValid;
  String get guestError;
  String get storyError;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= home screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  String get location;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Setting  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get setting;

  String get myAccount;

  String get updateInformation;

  String get previewProfile;

  String get blockUser;

  String get changeInfo;

  String get changeLocation;

  String get changePassword;

  String get changeLanguage;

  String get termsAndPolicy;

  String get termsAndCondition;

  String get support;

  String get suggestion;

  String get reportAdvert;

  String get accountActions;

  String get deleteAccount;

  String get logout;

  String get verifyYourAccount;

  String get bioData;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Setting - Block User >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get allUser;

  String get blockedUser;

  String get searchFriends;

  String get noUserFound;

  String get block;
  String get cancel;

  String get unBlock;

  String get changeYourLocation;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Setting - Change Password >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get oldPassword;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Setting - Billing Information >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get addNewCard;

  String get addNewCardTitle;

  String get otherCard;

  String get addBankDetail;

  String get cardNumber;

  String get expirationDate;

  String get securityCode;

  String get cardHolderName;

  String get saveCardMsg;

  ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= search screen =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  String get searchFor;
  String get searchForCountry;
  String get search;
  String get searchType;

  String get popularStore;

  String get viewAll;
  String get searchStore;
  String get searchCategory;
  String get searchStoreFriend;

  String get noOfFriends;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Disount Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get uploadIn;

  String get mentionThe;

  String get sendPrivately;

  String get andSend;

  String get send;

  String get share;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< massage Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get chat;

  String get report;

  String get areYou;

  String get thisUser;

  String get thesePhotos;

  String get feelsLike;

  String get thisUserIs;

  String get imNot;

  String get submit;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< massage Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get subscribeMinus;

  String get toView;

  String get subscription;

  String get cardNo;

  String get checkOut;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Settings - Transfer Balance >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get country;

  String get bankName;

  String get swiftCode;

  String get iban;

  String get province;

  String get city;

  String get street;

  String get agreeMsg;

  // String get submit;
  String get rolesAndRegulation;

  String get yourPayment;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< second story Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get views;

  String get deleteStory;

  String get shareStory;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< cloud home Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get cloud;

  String get specialDeal;

  String get visitProfile;

  String get fashionBeauty;

  String get honey;

  String get perfums;

  String get hotelVillaRio;

  String get orderNow;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< preview profile Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get keithKing;

  String get keithKingTag;

  String get myStories;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< update Information Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get webSiteLink;

  String get menuLink;

  String get category;

  String get selectYourCategory;
  String get selectYourSubCategory;

  String get uploadImages;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< preview profile Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get notification;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< your story request Screen >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get successfully;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Settings - Terms & Condition >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get suggestionTitle;

  String get writeHere;

  String get lastUpdated;

  String get summary;

  String get summaryDetail;

  String get terms;

  String get termsDetail;

  String get introduction;

  String get introductionDetail;

  String get managingInfo;

  String get managingInfoDetail;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Settings - Report Advert >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get nameOfAdvert;

  String get typeOfProblem;

  String get shortDetail;

  String get attach;

  String get reportJpg;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Settings - Delete Account >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get reason1;

  String get reason2;

  String get reason3;

  String get reason4;

  String get reason5;

  String get reason6;

  String get deleteMsg;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Settings - Logout >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get logOutMsg;
  String get loginFirst;

  String get logoutBtn;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Settings - Logout >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get selectTheCountry;

  String get c1;

  String get c2;

  String get c3;

  String get c4;

  String get c5;

  String get c6;

  String get c7;

  String get coinsConverted;

  String get transferMsg;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< promotion Campaign -= text filed >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get yourOffer;

  String get noteMessage;

  String get uploadImageAndVideo;

  String get uploadImage;

  String get saveLocation;

  String get enterYourLocation;

  String get thisDataWill;

  String get yourRequest;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ADs Mangemant >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get AdsManagment;

  String get offers;

  String get offersRate;

  String get release;

  String get tapToEdit;

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< cloud promotion -main ADS - upload license >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  String get uploadLicense;

  String get uploadLicenseMsg;

  String get addDocumentMsg;

  String get displayYourAd;

  String get myAD;

  String get mainAD;

  String get pickDateMsg;

  String get budgetMsg;

  String get payPromot;

  String get trendTitle;

  String get yourProduct;
  String get verificationAccount;

  String get uploadCommercial;

  String get uploadCommercialMsg;

  String get update;

  String get tapToImage;

  String get tapToImageAndVideo;

  String get profile;

  String get typeSomthing;

  String get site;

  String get locationSpel;

  String get enterNumber;

  String get pleaseChoose;

  String get ok;

  // =-=-=-=-=-=-=-=-=- FeedBack =-=-==-=-=->>>>>>

  String get unitedArabEmirates;

  String get kuwait;

  String get bahrain;

  String get qatar;

  String get oman;

  String get selectBusiness;

  String get indiaFood;

  String get delete;

  String get phone;

  String get addresStr;

  String get postalCode;

  String get state;

  String get bankAccount;

  String get routingNumber;

  String get updateBankDetails;

  String get identifyNumber;

  String get externalAccount;

  String get externalCurrency;

  String get frontImage;

  String get backImage;

  String get teaSite;

  // =-=-=-=-=-=-=-=-=- Error Strings  =-=-==-=-=->>>>>>
  String get enterYourEmail;
  String get pleaseEnterEmail;

  String get pleaseEnterValidEmail;

  String get enterYourPassword;
  String get pleaseEnterPassword;

  String get pleaseEnterConfirmPassword;

  String get pleaseMatchConfirmPassword;

  String get pleaseEnterValidPassword;

  String get pleaseEnterFirstName;

  String get pleaseEnterLastName;

  String get pleaseEnterDob;

  String get pleaseEnterGender;

  String get pleaseEnterPhoneNumber;
  String get pleaseEnterIdentityNo;
  String get pleaseEnterValidIdentityNo;
  String get pleaseEnterCity;

  String get pleaseEnterCountry;
  String get pleaseSelectCountry;
  String get pleaseEnterState;
  String get pleaseEnterPostalCode;
  String get pleaseEnterBankNo;

  String get pleaseEnterValidPhoneNumber;

  String get pleaseEnterProfile;

  String get iAgreeToTerms;

  String get agreeTermsAndCondition;

  String get agreePolicy;

  String get pleaseEnterWebsite;

  String get pleaseEnterNoteMsg;

  String get pleaseSelectImage;

  String get pleaseTagUser;

  String get pleaseEnterOffer;
  String get pleaseEnterSite;

  String get pleaseCardDetails;

  String get pleaseEnterExpiryDate;

  String get pleaseEnterSecurityCode;

  String get pleaseEnterHolderName;

  String get pleaseEnterCardNo;

  String get pleaseEnterNewPassword;

  String get pleaseMatchPassword;

  String get pleaseEnterOtp;

  String get pleaseEnterValidOtp;
  String get pleaseEnterValidUrl;

  String get pleaseEnterBio;

  String get pleaseEnterIdno;

  String get pleaseEnterSuggection;
  String get pleaseEnterMsg;

  String get pleaseEnterAdvertName;

  String get pleaseEnterLocation;
  String get pleaseWaitLocation;
  String get pleaseEnterDetail;

  String get pleaseEnterProblem;

  String get pleaseEnterWebSiteLink;

  String get pleaseEnterMenuLink;

  String get pleaseEnterRouting;

  String get pleaseEnterRoutingNo;

  String get noDataFound;
  String get noStoryFound;
}
