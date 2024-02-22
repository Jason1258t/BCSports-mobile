import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About player'**
  String get about;

  /// No description provided for @academy.
  ///
  /// In en, this message translates to:
  /// **'Academy'**
  String get academy;

  /// No description provided for @agree_terms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the terms and conditions'**
  String get agree_terms;

  /// No description provided for @all_collection.
  ///
  /// In en, this message translates to:
  /// **'All collections'**
  String get all_collection;

  /// No description provided for @already_have_acc.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_acc;

  /// No description provided for @ar.
  ///
  /// In en, this message translates to:
  /// **'AR'**
  String get ar;

  /// No description provided for @ar_visual.
  ///
  /// In en, this message translates to:
  /// **'AR Visualization of the Brazilian Academy'**
  String get ar_visual;

  /// No description provided for @assists.
  ///
  /// In en, this message translates to:
  /// **'Assists'**
  String get assists;

  /// No description provided for @available_bill.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get available_bill;

  /// No description provided for @ball_recovery.
  ///
  /// In en, this message translates to:
  /// **'Ball recovery'**
  String get ball_recovery;

  /// No description provided for @basketball.
  ///
  /// In en, this message translates to:
  /// **'Basketball'**
  String get basketball;

  /// No description provided for @be_first_to_write_a_message.
  ///
  /// In en, this message translates to:
  /// **'Be the first to write a message'**
  String get be_first_to_write_a_message;

  /// No description provided for @birth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birth;

  /// No description provided for @born.
  ///
  /// In en, this message translates to:
  /// **'BORN'**
  String get born;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @cancel_lot.
  ///
  /// In en, this message translates to:
  /// **'cancel lot'**
  String get cancel_lot;

  /// No description provided for @cansel_sale.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the sale?'**
  String get cansel_sale;

  /// No description provided for @capture_matrics.
  ///
  /// In en, this message translates to:
  /// **'Capturing metrics from football matches and physical metrics of players by our partners.'**
  String get capture_matrics;

  /// No description provided for @change_lang.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_lang;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// No description provided for @choose_play.
  ///
  /// In en, this message translates to:
  /// **'Choose, play, win'**
  String get choose_play;

  /// No description provided for @choose_this.
  ///
  /// In en, this message translates to:
  /// **'Choose this'**
  String get choose_this;

  /// No description provided for @citizen.
  ///
  /// In en, this message translates to:
  /// **'Citizenship'**
  String get citizen;

  /// No description provided for @club_name.
  ///
  /// In en, this message translates to:
  /// **'Club name'**
  String get club_name;

  /// No description provided for @collection_stats.
  ///
  /// In en, this message translates to:
  /// **'Collecting a player\'s stats'**
  String get collection_stats;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'COMMENTS'**
  String get comments;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'COUNTRY'**
  String get country;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'CREATE'**
  String get create;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @delete_fail.
  ///
  /// In en, this message translates to:
  /// **'Delete fail, try again later'**
  String get delete_fail;

  /// No description provided for @democratize_sports.
  ///
  /// In en, this message translates to:
  /// **'Democratize sports investment, providing fans with the opportunity to support athletes directly while offering athletes from all backgrounds equal access to opportunities in their careers.'**
  String get democratize_sports;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @dribbling_siffered.
  ///
  /// In en, this message translates to:
  /// **'Dribbling suffered'**
  String get dribbling_siffered;

  /// No description provided for @duel_air.
  ///
  /// In en, this message translates to:
  /// **'Duel air'**
  String get duel_air;

  /// No description provided for @duel_lost.
  ///
  /// In en, this message translates to:
  /// **'Duel lost'**
  String get duel_lost;

  /// No description provided for @duel_tackle.
  ///
  /// In en, this message translates to:
  /// **'Duel tackle'**
  String get duel_tackle;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get edit_profile;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email_address;

  /// No description provided for @enter_registered_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your registered email address.'**
  String get enter_registered_email;

  /// No description provided for @exclusive_colls.
  ///
  /// In en, this message translates to:
  /// **'Exclusive digital collections'**
  String get exclusive_colls;

  /// No description provided for @explore_more.
  ///
  /// In en, this message translates to:
  /// **'Explore more'**
  String get explore_more;

  /// No description provided for @fast_player_good_dribbling.
  ///
  /// In en, this message translates to:
  /// **'Fast player with good dribbling and passing. Looks good in attack but has some work to do in defence.'**
  String get fast_player_good_dribbling;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favourite;

  /// No description provided for @favs.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favs;

  /// No description provided for @feel_professional.
  ///
  /// In en, this message translates to:
  /// **'Feel professional racer'**
  String get feel_professional;

  /// No description provided for @fincher_best.
  ///
  /// In en, this message translates to:
  /// **'Fincher is best and most popular website for selling and your arts and collections in a very easy and hustle free  process.'**
  String get fincher_best;

  /// No description provided for @fincher_over.
  ///
  /// In en, this message translates to:
  /// **'Fincher is a over expanding network of many interlinked applications and services for building an ecosystem of decenteralized future.'**
  String get fincher_over;

  /// No description provided for @first_nft.
  ///
  /// In en, this message translates to:
  /// **'The first NFT, which depends not on the market, but on the worships of the players.'**
  String get first_nft;

  /// No description provided for @foot.
  ///
  /// In en, this message translates to:
  /// **'Foot'**
  String get foot;

  /// No description provided for @footbag.
  ///
  /// In en, this message translates to:
  /// **'Footbag'**
  String get footbag;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'forgot password'**
  String get forgot_password;

  /// No description provided for @forgot_your_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_your_password;

  /// No description provided for @fouls.
  ///
  /// In en, this message translates to:
  /// **'Fouls'**
  String get fouls;

  /// No description provided for @go_ar.
  ///
  /// In en, this message translates to:
  /// **'Go to AR'**
  String get go_ar;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'hide'**
  String get hide;

  /// No description provided for @hit_the_max.
  ///
  /// In en, this message translates to:
  /// **'Hit the maximum number of times'**
  String get hit_the_max;

  /// No description provided for @killer_passes.
  ///
  /// In en, this message translates to:
  /// **'Killer passes'**
  String get killer_passes;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @make_selfie.
  ///
  /// In en, this message translates to:
  /// **'Make a selfie or video with your favorite athlete using AR'**
  String get make_selfie;

  /// No description provided for @market.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get market;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @mind.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get mind;

  /// No description provided for @mini_games.
  ///
  /// In en, this message translates to:
  /// **'Mini-games'**
  String get mini_games;

  /// No description provided for @minuts_played.
  ///
  /// In en, this message translates to:
  /// **'Minutes played'**
  String get minuts_played;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get more;

  /// No description provided for @moto_pg.
  ///
  /// In en, this message translates to:
  /// **'MotoGP'**
  String get moto_pg;

  /// No description provided for @my_active_lots.
  ///
  /// In en, this message translates to:
  /// **'My active lots'**
  String get my_active_lots;

  /// No description provided for @my_players.
  ///
  /// In en, this message translates to:
  /// **'My players'**
  String get my_players;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @nft.
  ///
  /// In en, this message translates to:
  /// **'NFT'**
  String get nft;

  /// No description provided for @nft_will_removed.
  ///
  /// In en, this message translates to:
  /// **'The NFT will be removed from the marketplace and returned to your inventory.'**
  String get nft_will_removed;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @no_acc.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get no_acc;

  /// No description provided for @no_favs.
  ///
  /// In en, this message translates to:
  /// **'Looks like you have no favorite'**
  String get no_favs;

  /// No description provided for @no_lots.
  ///
  /// In en, this message translates to:
  /// **'Looks like you have no active lots'**
  String get no_lots;

  /// No description provided for @no_post.
  ///
  /// In en, this message translates to:
  /// **'There is no post yet'**
  String get no_post;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @penalties.
  ///
  /// In en, this message translates to:
  /// **'Penalties'**
  String get penalties;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @player_details.
  ///
  /// In en, this message translates to:
  /// **'Player Details'**
  String get player_details;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @posts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @project_mission.
  ///
  /// In en, this message translates to:
  /// **'Project mission'**
  String get project_mission;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @put_up_for_sale.
  ///
  /// In en, this message translates to:
  /// **'Put up for sale'**
  String get put_up_for_sale;

  /// No description provided for @quantity_matches.
  ///
  /// In en, this message translates to:
  /// **'Quantity of matches'**
  String get quantity_matches;

  /// No description provided for @replanish.
  ///
  /// In en, this message translates to:
  /// **'Replanish'**
  String get replanish;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @send_recovery.
  ///
  /// In en, this message translates to:
  /// **'Send recovery mail'**
  String get send_recovery;

  /// No description provided for @set_price.
  ///
  /// In en, this message translates to:
  /// **'Set a price'**
  String get set_price;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @show_aim.
  ///
  /// In en, this message translates to:
  /// **'Show your aim and accuracy, score a three-pointer'**
  String get show_aim;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @successful_return.
  ///
  /// In en, this message translates to:
  /// **'Successful, you can return'**
  String get successful_return;

  /// No description provided for @swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swap;

  /// No description provided for @talanted_individuals.
  ///
  /// In en, this message translates to:
  /// **'Talented individuals couldn\'t become successful athletes due to limited resources and had to abandon their dreams for a stable life.'**
  String get talanted_individuals;

  /// No description provided for @trick_goalkeeper.
  ///
  /// In en, this message translates to:
  /// **'Trick the goalkeeper and hit the goal'**
  String get trick_goalkeeper;

  /// No description provided for @trust_way.
  ///
  /// In en, this message translates to:
  /// **'The most trusted way'**
  String get trust_way;

  /// No description provided for @type_comment.
  ///
  /// In en, this message translates to:
  /// **'Type your comment here...'**
  String get type_comment;

  /// No description provided for @unlock_feature.
  ///
  /// In en, this message translates to:
  /// **'Unlock the future'**
  String get unlock_feature;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get views;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @we_spot_talents.
  ///
  /// In en, this message translates to:
  /// **'We spot the talents'**
  String get we_spot_talents;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @you_dont_nfts.
  ///
  /// In en, this message translates to:
  /// **'Sorry, you don\'t have NFTs.'**
  String get you_dont_nfts;

  /// No description provided for @you_dont_posts.
  ///
  /// In en, this message translates to:
  /// **'Sorry, you don\'t have Posts.'**
  String get you_dont_posts;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Statistic'**
  String get stats;

  /// No description provided for @chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @add_nft.
  ///
  /// In en, this message translates to:
  /// **'Add NFT'**
  String get add_nft;

  /// No description provided for @crop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get crop;

  /// No description provided for @choose_photo.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get choose_photo;

  /// No description provided for @report_sended.
  ///
  /// In en, this message translates to:
  /// **'Report sended'**
  String get report_sended;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @spam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get spam;

  /// No description provided for @violence.
  ///
  /// In en, this message translates to:
  /// **'Violence'**
  String get violence;

  /// No description provided for @child_abuse.
  ///
  /// In en, this message translates to:
  /// **'Child Abuse'**
  String get child_abuse;

  /// No description provided for @porn.
  ///
  /// In en, this message translates to:
  /// **'Pornography'**
  String get porn;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get copy;

  /// No description provided for @drugs.
  ///
  /// In en, this message translates to:
  /// **'Illegal drugs'**
  String get drugs;

  /// No description provided for @personal_details.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personal_details;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
