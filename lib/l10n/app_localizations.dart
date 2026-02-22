import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// Pranks category label
  ///
  /// In en, this message translates to:
  /// **'Pranks 🔥'**
  String get pranksCategoryLabel;

  /// Homeless prompt label
  ///
  /// In en, this message translates to:
  /// **'Homeless'**
  String get homelessPromptLabel;

  /// Homeless prompt text
  ///
  /// In en, this message translates to:
  /// **'Add a realistic homeless man standing inside the room. He looks toward the camera with a warm, grateful expression, as if he has just been welcomed in. Match the room\'s lighting, perspective, and shadows perfectly. The scene must look natural and believable, with no changes to the rest of the image.'**
  String get homelessPromptText;

  /// Plumber prompt label
  ///
  /// In en, this message translates to:
  /// **'Plumber'**
  String get plumberPromptLabel;

  /// Plumber prompt text
  ///
  /// In en, this message translates to:
  /// **'Add a realistic shirtless plumber inside the room, wearing work pants and holding plumbing tools, working on pipes or fixtures. His bare torso looks out of place and slightly uncomfortable, increasing the awkwardness of the scene. He appears odd, suspicious, or socially off, with an unusual expression or posture, as if something feels wrong. Match the room\'s lighting, perspective, shadows, and reflections perfectly. The scene must look natural, believable, and subtly unsettling, with no other changes to the image.'**
  String get plumberPromptText;

  /// Damaged car prompt label
  ///
  /// In en, this message translates to:
  /// **'Damaged Car'**
  String get damagedCarPromptLabel;

  /// Damaged car prompt text
  ///
  /// In en, this message translates to:
  /// **'Modify the car in the image to look clearly damaged from a noticeable accident, while still being repairable and fully recognizable. Add multiple deep dents, stronger scratches, cracked or missing headlight covers, a visibly bent bumper or hood, misaligned panels, and paint damage, but do not turn the car into scrap or completely destroy it. Preserve the original environment, lighting, reflections, camera angle, and composition so the damage looks realistic, coherent, and naturally integrated into the scene.'**
  String get damagedCarPromptText;

  /// Dirty toilets prompt label
  ///
  /// In en, this message translates to:
  /// **'Dirty Toilets'**
  String get dirtyToiletsPromptLabel;

  /// Dirty toilets prompt text
  ///
  /// In en, this message translates to:
  /// **'Modify the clean toilet in the image to appear extremely dirty and unhygienic, as if it has been neglected for a long time. Add realistic stains, dried splashes, smears, urine marks, water discoloration, dirty bowl residue, splattered seat stains, and overall grime on the toilet and surrounding area. The mess should look severe but non-graphic, with no close-up gore or excessive detail. Preserve the original bathroom layout, lighting, camera angle, and proportions so the result looks believable and shocking at first glance.'**
  String get dirtyToiletsPromptText;

  /// Broken TV prompt label
  ///
  /// In en, this message translates to:
  /// **'Broken TV'**
  String get brokenTvPromptLabel;

  /// Broken TV prompt text
  ///
  /// In en, this message translates to:
  /// **'Modify the TV in the image to look severely damaged and unusable, as if it has suffered a serious malfunction or impact. Add a cracked or shattered screen, black dead zones, colored glitch lines, distorted pixels, and display artifacts, while keeping the TV physically recognizable and in place. The screen should clearly appear non-functional, even if the TV is powered on. Preserve the original room, lighting, reflections, camera angle, and composition so the damage looks realistic and convincing.'**
  String get brokenTvPromptText;

  /// Relationships category label
  ///
  /// In en, this message translates to:
  /// **'Relationships 💞'**
  String get relationshipsCategoryLabel;

  /// AI Girlfriend prompt label
  ///
  /// In en, this message translates to:
  /// **'AI Girlfriend'**
  String get aiGirlfriendPromptLabel;

  /// AI Girlfriend prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic photograph. Add a natural-looking girlfriend standing or sitting next to the man. She should look comfortable and naturally close, as if they are a real couple. Match lighting, perspective, scale, and shadows perfectly. Their interaction must feel subtle and authentic. Keep the man\'s face, body, and the background unchanged. No stylization, no exaggeration, pure photorealism.'**
  String get aiGirlfriendPromptText;

  /// AI Boyfriend prompt label
  ///
  /// In en, this message translates to:
  /// **'AI Boyfriend'**
  String get aiBoyfriendPromptLabel;

  /// AI Boyfriend prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic photograph. Add a natural-looking boyfriend standing or sitting next to the person. He should appear relaxed and naturally close, as if they are a real couple. Match lighting, perspective, scale, and shadows perfectly. Their interaction must feel subtle and authentic. Keep the original person\'s face, body, and the background unchanged. No stylization, no exaggeration, pure photorealism.'**
  String get aiBoyfriendPromptText;

  /// Fashion category label
  ///
  /// In en, this message translates to:
  /// **'Fashion 👠'**
  String get fashionCategoryLabel;

  /// Change hairstyle prompt label
  ///
  /// In en, this message translates to:
  /// **'Change Hairstyle'**
  String get changeHairstylePromptLabel;

  /// Change hairstyle prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic photograph. Change the person\'s hairstyle to the following: [HAIRSTYLE DESCRIPTION]. The hair must look natural, with realistic volume, texture, and strands. Match lighting, shadows, hairline, and head shape perfectly. The hairstyle should blend seamlessly with the face and scalp, without distortion or artificial edges. Keep the face, expression, body, and background unchanged.'**
  String get changeHairstylePromptText;

  /// Tattoo try-on prompt label
  ///
  /// In en, this message translates to:
  /// **'Tattoo Try-On'**
  String get tattooTryOnPromptLabel;

  /// Tattoo try-on prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic photograph. Add a tattoo on the [BODY PART], following this description: [TATTOO DESCRIPTION]. The tattoo must follow the natural shape, curvature, and muscle structure of the skin. Match skin texture, pores, lighting, shadows, and perspective perfectly. The ink should look embedded under the skin, not printed or overlaid. No distortion, no stylization. Do not change anything else in the image.'**
  String get tattooTryOnPromptText;

  /// Outfit try-on prompt label
  ///
  /// In en, this message translates to:
  /// **'Outfit Try-On'**
  String get outfitTryOnPromptLabel;

  /// Outfit try-on prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic photograph. Replace the clothing on the person with the following outfit: [OUTFIT DESCRIPTION]. The outfit must fit the body naturally, following posture, proportions, and fabric behavior. Match lighting, shadows, folds, and perspective perfectly. The fabric should look worn, with natural wrinkles and depth, not pasted or painted. Keep the person\'s body, face, pose, and background unchanged.'**
  String get outfitTryOnPromptText;

  /// Transformation category label
  ///
  /// In en, this message translates to:
  /// **'Transformation 🪄'**
  String get transformationCategoryLabel;

  /// Muscular prompt label
  ///
  /// In en, this message translates to:
  /// **'Muscular'**
  String get muscularPromptLabel;

  /// Muscular prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic photograph. Adjust the person\'s pose so they are flexing their muscles naturally, as if consciously tensing their body. Enhance muscle definition and visible vascularity while keeping anatomy realistic and proportional. The flexed muscles must follow natural body mechanics, with accurate lighting, shadows, and skin texture. Keep the face, expression, identity, and background unchanged. No stylization, no exaggerated bodybuilding look, pure photorealism.'**
  String get muscularPromptText;

  /// Professional prompt label
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get professionalPromptLabel;

  /// Professional prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the image as a realistic professional portrait. Keep the original person and face unchanged. Place them in a neutral, clean environment with a soft, balanced studio lighting and a plain gray background. Dress the person in a simple, elegant, and professional suit. The person should have a subtle, natural smile and a confident, upright posture. The result must look like a real high-quality LinkedIn profile photo, with no stylization or artificial effects.'**
  String get professionalPromptText;

  /// Man to woman prompt label
  ///
  /// In en, this message translates to:
  /// **'Man to Woman'**
  String get manToWomanPromptLabel;

  /// Man to woman prompt text
  ///
  /// In en, this message translates to:
  /// **'Transform the man in the image into his realistic female equivalent. Keep the photo exactly the same: same framing, same background, same environment, same pose, same posture, and same body position. Do NOT extend, crop, or generate any new body parts. Only modify gender-related traits while preserving identity and likeness: facial structure adapted naturally, softer features, feminine hairstyle, subtle feminine body characteristics where already visible. Maintain the original lighting, shadows, perspective, and image quality. High realism, seamless integration, no visual artifacts.'**
  String get manToWomanPromptText;

  /// Woman to man prompt label
  ///
  /// In en, this message translates to:
  /// **'Woman to Man'**
  String get womanToManPromptLabel;

  /// Woman to man prompt text
  ///
  /// In en, this message translates to:
  /// **'Transform the woman in the image into her realistic male equivalent. Keep the photo exactly the same: same framing, same background, same environment, same pose, same posture, and same body position. Do NOT extend, crop, or generate any new body parts. Only modify gender-related traits while preserving identity and likeness: stronger jawline, masculine facial features, masculine hairstyle, subtle masculine body characteristics where already visible. Maintain the original lighting, shadows, perspective, and image quality. High realism, seamless integration, no visual artifacts.'**
  String get womanToManPromptText;

  /// Animal to human prompt label
  ///
  /// In en, this message translates to:
  /// **'Animal to Human'**
  String get animalToHumanPromptLabel;

  /// Animal to human prompt text
  ///
  /// In en, this message translates to:
  /// **'Transform the animal in the image into a realistic human equivalent while preserving the animal\'s identity, posture, attitude, and distinctive traits. The human should clearly feel like the same being in human form, with recognizable facial structure, expression, body language, and presence inspired by the animal. Keep the original environment, lighting, camera angle, and composition unchanged. The transformation must look natural, photorealistic, and perfectly integrated into the scene.'**
  String get animalToHumanPromptText;

  /// Avatars category label
  ///
  /// In en, this message translates to:
  /// **'Avatars 🎭'**
  String get avatarsCategoryLabel;

  /// iOS Memoji prompt label
  ///
  /// In en, this message translates to:
  /// **'iOS Memoji'**
  String get iosMemojiPromptLabel;

  /// iOS Memoji prompt text
  ///
  /// In en, this message translates to:
  /// **'Transform the person into a full-body iOS-style Memoji character. Keep the person\'s facial features, hairstyle, skin tone, and overall identity recognizable. If parts of the body are not visible in the original image, naturally imagine and complete them in a consistent way. Render the character with smooth, rounded shapes and soft colors, following official iOS Memoji style. Use a pure white background. The result should look like a clean, polished, full-body Apple Memoji.'**
  String get iosMemojiPromptText;

  /// Snapchat Bitmoji prompt label
  ///
  /// In en, this message translates to:
  /// **'Snapchat Bitmoji'**
  String get snapchatBitmojiPromptLabel;

  /// Snapchat Bitmoji prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the person from the image as a full-body Bitmoji-style avatar, inspired by Snapchat Bitmoji visuals. Preserve the person\'s facial features, hairstyle, skin tone, expression, and posture so they remain clearly recognizable. Generate the entire body from head to toe, even if parts are not visible in the original image, while keeping the same pose and body language. Use clean cartoon proportions, smooth outlines, bright flat colors, and soft shading typical of Bitmoji. Place the avatar on a plain white background. The final result must look like an official Bitmoji character representing the person.'**
  String get snapchatBitmojiPromptText;

  /// Pixel art prompt label
  ///
  /// In en, this message translates to:
  /// **'Pixel Art'**
  String get pixelArtPromptLabel;

  /// Pixel art prompt text
  ///
  /// In en, this message translates to:
  /// **'Transform the person into a full-body pixel art avatar. Keep the person\'s main facial features, hairstyle, and general appearance recognizable. If parts of the body are not visible, realistically imagine and complete them. Render the avatar in a clean pixel art style with clear shapes, limited colors, and sharp pixels. Use a pure white background. The result should look like a well-designed full-body pixel character suitable for a profile or game avatar.'**
  String get pixelArtPromptText;

  /// Minecraft avatar prompt label
  ///
  /// In en, this message translates to:
  /// **'Minecraft'**
  String get minecraftAvatarPromptLabel;

  /// Minecraft avatar prompt text
  ///
  /// In en, this message translates to:
  /// **'Transform the person into a full-body Minecraft-style character skin. The entire body must be fully visible from head to feet, with nothing cropped or missing. Preserve the same posture, body position, and body language as in the original image. Keep the person\'s facial features, hairstyle, and overall look recognizable in a blocky Minecraft aesthetic. If parts of the body are not visible, naturally imagine and complete them while strictly maintaining the original pose. Use flat colors, sharp pixel edges, and no shading or gradients. Plain white background. The result must look like a proper Minecraft player skin.'**
  String get minecraftAvatarPromptText;

  /// Environment category label
  ///
  /// In en, this message translates to:
  /// **'Environment 🏞️'**
  String get environmentCategoryLabel;

  /// Stranger Things prompt label
  ///
  /// In en, this message translates to:
  /// **'Stranger Things'**
  String get strangerThingsPromptLabel;

  /// Stranger Things prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the exact same image and integrate the person into the world of Stranger Things. Preserve the main subject fully realistic and unchanged (face, body, clothes, pose, expression). Transform the entire environment to match the Stranger Things atmosphere: an ominous, stormy sky without rain, glowing scarlet-red clouds, and red lightning illuminating the scene. Place the Mind Flayer from Stranger Things clearly visible in the distant sky, massive and menacing, partially obscured by clouds, faithful to the series design. Keep the original composition, perspective, and camera angle. The scene must feel cinematic, dark, supernatural, and unmistakably inspired by Stranger Things, as if the photo was taken during an Upside Down event.'**
  String get strangerThingsPromptText;

  /// Minecraft environment prompt label
  ///
  /// In en, this message translates to:
  /// **'Minecraft'**
  String get minecraftEnvironmentPromptLabel;

  /// Minecraft environment prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the exact same image, but transform the entire environment into a Minecraft world. Rebuild the background strictly using official Minecraft blocks, textures, and proportions. Do NOT modify the main subject (the person), keep them fully realistic and unchanged. Convert all other people, animals, objects, and interactive elements into their Minecraft equivalents (e.g. dog = Minecraft wolf, glass of water = Minecraft water bucket). Preserve the original composition, camera angle, perspective, and positions. The result must look like a real photo taken inside Minecraft, with the subject standing in the real world.'**
  String get minecraftEnvironmentPromptText;

  /// LEGO prompt label
  ///
  /// In en, this message translates to:
  /// **'LEGO'**
  String get legoPromptLabel;

  /// LEGO prompt text
  ///
  /// In en, this message translates to:
  /// **'Recreate the exact same image, but transform the entire environment into a LEGO world. Rebuild the background using LEGO bricks, studs, plastic textures, and LEGO-scale proportions. Do NOT modify the main subject (the person), keep them fully realistic and unchanged. Convert all other people, animals, and objects into their LEGO equivalents (minifigures, LEGO animals, LEGO accessories). Preserve the original composition, camera angle, perspective, and positions. The final image must look like a real photo taken inside a LEGO world, with the real subject standing among LEGO elements.'**
  String get legoPromptText;

  /// Filters category label
  ///
  /// In en, this message translates to:
  /// **'Filters 📸'**
  String get filtersCategoryLabel;

  /// Fish-eye lens prompt label
  ///
  /// In en, this message translates to:
  /// **'Fish-Eye Lens'**
  String get fisheyeLensPromptLabel;

  /// Fish-eye lens prompt text
  ///
  /// In en, this message translates to:
  /// **'Preserve the original image and subject exactly as they are. Apply a realistic high-end fisheye camera lens effect, as if the photo was taken extremely close to the face. Strong wide-angle distortion with visible fisheye curvature: enlarged facial features near the lens, curved edges, subtle barrel distortion. Maintain natural skin texture, realistic proportions, and accurate lighting. High-quality camera look, sharp focus, no artificial or cartoon effects. The result should look like a genuine close-up photo taken with a professional fisheye lens.'**
  String get fisheyeLensPromptText;

  /// Old photo restore prompt label
  ///
  /// In en, this message translates to:
  /// **'Old Photo Restore'**
  String get oldPhotoRestorePromptLabel;

  /// Old photo restore prompt text
  ///
  /// In en, this message translates to:
  /// **'Preserve the original composition, people, facial features, poses, and background exactly as in the source image. Fully restore this old, damaged black-and-white or faded photo to look like it was taken today with a modern high-end camera. Repair scratches, stains, tears, blur, and noise. Reconstruct missing details naturally without altering identity. Add realistic modern colorization with accurate skin tones and materials, balanced contrast, sharp focus, and clean lighting. No artistic reinterpretation, no stylization, no AI artifacts. The final result must look like a genuine contemporary photograph, not an edited or colorized old photo.'**
  String get oldPhotoRestorePromptText;

  /// Wool prompt label
  ///
  /// In en, this message translates to:
  /// **'Wool'**
  String get woolPromptLabel;

  /// Wool prompt text
  ///
  /// In en, this message translates to:
  /// **'Regenerate the exact same image, but make everything out of thick, dense wool and needle-felted fabric. Every element must have chunky fibers, heavy yarn, visible felt texture, soft fuzzy edges, and clear textile volume. No paint, no plastic, no clay, no CGI, only thick wool. Preserve the exact composition, perspective, poses, and proportions. Colors must look yarn-dyed. Lighting should reveal fiber depth and softness. The result must look like a physical wool sculpture, unmistakably made of thick wool.'**
  String get woolPromptText;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// account
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// Lumena pro
  ///
  /// In en, this message translates to:
  /// **'LUMENA PRO'**
  String get lumenaPro;

  /// legal
  ///
  /// In en, this message translates to:
  /// **'LEGAL'**
  String get legal;

  /// website
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// Legal notice
  ///
  /// In en, this message translates to:
  /// **'Legal Notice'**
  String get legalNotice;

  /// Terms of service
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Restore failed
  ///
  /// In en, this message translates to:
  /// **'Restore Failed'**
  String get restoreFailed;

  /// Restore failed description
  ///
  /// In en, this message translates to:
  /// **'An error occurred while restoring your purchases. Please, try again.'**
  String get restoreFailedDescription;

  /// Change plan
  ///
  /// In en, this message translates to:
  /// **'Change Plan'**
  String get changePlan;

  /// manage
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// upgrade
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// Sign out
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Sign out confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// Sign out description
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your account.'**
  String get signOutDescription;

  /// cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Monthly edits usage
  ///
  /// In en, this message translates to:
  /// **'Monthly Edits Usage'**
  String get monthlyEditsUsage;

  /// Sign in to view
  ///
  /// In en, this message translates to:
  /// **'Sign in to view'**
  String get signInToView;

  /// remaining edits with plural support
  ///
  /// In en, this message translates to:
  /// **'{remaining, plural, =0{{remaining} / {max} remaining} =1{{remaining} / {max} remaining} other{{remaining} / {max} remaining}}'**
  String remaining(int remaining, int max);

  /// counting
  ///
  /// In en, this message translates to:
  /// **'Counting...'**
  String get counting;

  /// Restore purchases
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// restore
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No purchases
  ///
  /// In en, this message translates to:
  /// **'No Purchases'**
  String get noPurchases;

  /// No purchases description
  ///
  /// In en, this message translates to:
  /// **'We could not find any previous purchases associated with your account.'**
  String get noPurchasesDescription;

  /// Restore successful
  ///
  /// In en, this message translates to:
  /// **'Restore Successful'**
  String get restoreSuccessful;

  /// Restore successful description
  ///
  /// In en, this message translates to:
  /// **'You have successfully restored your purchases! You can now enjoy the full power of Lumena PRO.'**
  String get restoreSuccessfulDescription;

  /// email
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Sign in
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Image saved to gallery
  ///
  /// In en, this message translates to:
  /// **'Image Saved to Gallery'**
  String get imageSavedToGallery;

  /// Failed to save image
  ///
  /// In en, this message translates to:
  /// **'Failed to Save Image'**
  String get failedToSaveImage;

  /// Image saved to gallery description
  ///
  /// In en, this message translates to:
  /// **'Your image has been successfully saved to your gallery.'**
  String get imageSavedToGalleryDescription;

  /// Failed to save image description
  ///
  /// In en, this message translates to:
  /// **'There was an error saving your image. Please, try again.'**
  String get failedToSaveImageDescription;

  /// Image share description
  ///
  /// In en, this message translates to:
  /// **'Check out my edited image using Lumena AI! ✨'**
  String get imageShareDescription;

  /// Unexpected error
  ///
  /// In en, this message translates to:
  /// **'Unexpected Error'**
  String get unexpectedError;

  /// Unexpected error image generation
  ///
  /// In en, this message translates to:
  /// **'Something wrong happened while generating the image. Please, try again.'**
  String get unexpectedErrorImageGenerationDescription;

  /// Exit confirm title
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get exitConfirmTitle;

  /// Exit confirm description
  ///
  /// In en, this message translates to:
  /// **'Leaving this page will discard any unsaved changes.'**
  String get exitConfirmDescription;

  /// exit
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// Stay here
  ///
  /// In en, this message translates to:
  /// **'Stay Here'**
  String get stayHere;

  /// Photo editor
  ///
  /// In en, this message translates to:
  /// **'Photo Editor'**
  String get photoEditor;

  /// Edits remaining with plural support
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No edits remaining for this month} =1{1 edit remaining for this month} other{{count} edits remaining for this month}}'**
  String editsRemainingThisMonth(int count);

  /// Checking edit balance
  ///
  /// In en, this message translates to:
  /// **'Checking your edit balance...'**
  String get checkingEditBalance;

  /// Keep editing
  ///
  /// In en, this message translates to:
  /// **'Keep Editing'**
  String get keepEditing;

  /// download
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// share
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// generate
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// Prompt input placeholder
  ///
  /// In en, this message translates to:
  /// **'Describe what you want to edit...'**
  String get promptInputPlaceholder;

  /// Picture input placeholder
  ///
  /// In en, this message translates to:
  /// **'Tap to select a picture'**
  String get pictureInputPlaceholder;

  /// Shaping the unseen
  ///
  /// In en, this message translates to:
  /// **'Shaping the unseen...'**
  String get loadingSubtitle1;

  /// Weaving digital dreams
  ///
  /// In en, this message translates to:
  /// **'Weaving digital dreams...'**
  String get loadingSubtitle2;

  /// Painting with pixels
  ///
  /// In en, this message translates to:
  /// **'Painting with pixels...'**
  String get loadingSubtitle3;

  /// Crafting visual magic
  ///
  /// In en, this message translates to:
  /// **'Crafting visual magic...'**
  String get loadingSubtitle4;

  /// Bending reality
  ///
  /// In en, this message translates to:
  /// **'Bending reality...'**
  String get loadingSubtitle5;

  /// Conjuring imagination
  ///
  /// In en, this message translates to:
  /// **'Conjuring imagination...'**
  String get loadingSubtitle6;

  /// Sculpting light
  ///
  /// In en, this message translates to:
  /// **'Sculpting light...'**
  String get loadingSubtitle7;

  /// Transcending boundaries
  ///
  /// In en, this message translates to:
  /// **'Transcending boundaries...'**
  String get loadingSubtitle8;

  /// Lumena A I
  ///
  /// In en, this message translates to:
  /// **'Lumena AI'**
  String get lumenaAI;

  /// Image source
  ///
  /// In en, this message translates to:
  /// **'Image Source'**
  String get imageSource;

  /// Image source description
  ///
  /// In en, this message translates to:
  /// **'Choose the source of the image you want to edit.'**
  String get imageSourceDescription;

  /// camera
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// gallery
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Premium hook page title with highlighted parts
  ///
  /// In en, this message translates to:
  /// **'Enjoy **Lumena PRO** for **FREE**'**
  String get premiumHookTitle;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Paywall title with highlighted free
  ///
  /// In en, this message translates to:
  /// **'How the **free** trial works'**
  String get howFreeTrialWorks;

  /// step1title
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get step1Title;

  /// step1description
  ///
  /// In en, this message translates to:
  /// **'Unlock access to Lumena PRO'**
  String get step1Description;

  /// step2title
  ///
  /// In en, this message translates to:
  /// **'In 2 days'**
  String get step2Title;

  /// step2description
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a reminder before your trial ends'**
  String get step2Description;

  /// step3title
  ///
  /// In en, this message translates to:
  /// **'In 3 days'**
  String get step3Title;

  /// step3description
  ///
  /// In en, this message translates to:
  /// **'Your PRO subscription will begin, unless you cancel it before'**
  String get step3Description;

  /// Three day free trial
  ///
  /// In en, this message translates to:
  /// **'3-DAY FREE TRIAL'**
  String get threeDayFreeTrial;

  /// Message when user is not eligible for free trial
  ///
  /// In en, this message translates to:
  /// **'You are no longer eligible for the free trial'**
  String get notEligibleForFreeTrial;

  /// Title of the notification when free trial is expiring
  ///
  /// In en, this message translates to:
  /// **'Your free trial ends soon!'**
  String get freeTrialExpirationTitle;

  /// Body of the notification when free trial is expiring
  ///
  /// In en, this message translates to:
  /// **'Your 3-day free trial will expire in 24 hours. Keep enjoying Lumena PRO!'**
  String get freeTrialExpirationBody;

  /// monthly
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// Price per month
  ///
  /// In en, this message translates to:
  /// **'{price} / month'**
  String pricePerMonth(String price);

  /// weekly
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// Price per week
  ///
  /// In en, this message translates to:
  /// **'{price} / week'**
  String pricePerWeek(String price);

  /// subscribeForPrice
  ///
  /// In en, this message translates to:
  /// **'Subscribe for {price}'**
  String subscribeForPrice(String price);

  /// No commitment cancel anytime
  ///
  /// In en, this message translates to:
  /// **'No commitment, cancel anytime.'**
  String get noCommitmentCancelAnytime;

  /// Edits per month
  ///
  /// In en, this message translates to:
  /// **'{edits} edits / month'**
  String editsPerMonth(int edits);

  /// Purchase failure
  ///
  /// In en, this message translates to:
  /// **'Purchase Failure'**
  String get purchaseFailure;

  /// Purchase failure description
  ///
  /// In en, this message translates to:
  /// **'Something wrong happened during the purchase process. Please, try again.'**
  String get purchaseFailureDescription;

  /// congratulations
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// Congratulations description
  ///
  /// In en, this message translates to:
  /// **'You are now a member of Lumena PRO! You can now enjoy the full power of the app.'**
  String get congratulationsDescription;

  /// okay
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// Parameters reminder dialog title
  ///
  /// In en, this message translates to:
  /// **'Don\'t Forget the Parameters!'**
  String get parametersReminderTitle;

  /// Parameters reminder dialog description
  ///
  /// In en, this message translates to:
  /// **'This prompt contains parameters in brackets (e.g., [BODY PART], [DESCRIPTION]). Make sure to replace them with your own text before generating an image.'**
  String get parametersReminderDescription;

  /// Already pro
  ///
  /// In en, this message translates to:
  /// **'Already PRO'**
  String get alreadyPro;

  /// Already pro description
  ///
  /// In en, this message translates to:
  /// **'You are already a PRO member. Go to the settings to manage your plan.'**
  String get alreadyProDescription;

  /// welcomeToLumena
  ///
  /// In en, this message translates to:
  /// **'Welcome to Lumena'**
  String get welcomeToLumena;

  /// Edit anything with text
  ///
  /// In en, this message translates to:
  /// **'Edit Anything With Text'**
  String get editAnythingWithText;

  /// Get started
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Legal notice with links marked by [brackets]
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our [Terms of Service] and [Privacy Policy].'**
  String get linkedLegalNotice;

  /// next
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Choose your picture
  ///
  /// In en, this message translates to:
  /// **'Choose Your Picture'**
  String get chooseYourPicture;

  /// Type your edit
  ///
  /// In en, this message translates to:
  /// **'Type Your Edit'**
  String get typeYourEdit;

  /// Example prompt girlfriend
  ///
  /// In en, this message translates to:
  /// **'Add me a girlfriend'**
  String get examplePromptGirlfriend;

  /// Watch it turn real
  ///
  /// In en, this message translates to:
  /// **'Watch It Turn Real'**
  String get watchItTurnReal;

  /// Current plan
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// Change your plan to weekly
  ///
  /// In en, this message translates to:
  /// **'Change Your Plan to Weekly'**
  String get changeYourPlanToWeekly;

  /// Change your plan to monthly
  ///
  /// In en, this message translates to:
  /// **'Change Your Plan to Monthly'**
  String get changeYourPlanToMonthly;

  /// Weekly plan
  ///
  /// In en, this message translates to:
  /// **'Weekly Plan'**
  String get weeklyPlan;

  /// Monthly plan
  ///
  /// In en, this message translates to:
  /// **'Monthly Plan'**
  String get monthlyPlan;

  /// month
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// week
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get week;

  /// Upgrade to monthly
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Monthly'**
  String get upgradeToMonthly;

  /// Switch to weekly
  ///
  /// In en, this message translates to:
  /// **'Switch to Weekly'**
  String get switchToWeekly;

  /// Cancel subscription
  ///
  /// In en, this message translates to:
  /// **'Cancel Subscription'**
  String get cancelSubscription;

  /// Subscription active notice
  ///
  /// In en, this message translates to:
  /// **'Your subscription will remain active until the end of the current billing period'**
  String get subscriptionActiveNotice;

  /// Cancel subscription question
  ///
  /// In en, this message translates to:
  /// **'Cancel Subscription?'**
  String get cancelSubscriptionQuestion;

  /// Cancel subscription description
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel your Lumena PRO subscription? You will lose access to premium features at the end of your billing period.'**
  String get cancelSubscriptionQuestionDescription;

  /// Keep pro
  ///
  /// In en, this message translates to:
  /// **'Keep PRO'**
  String get keepPro;

  /// Cancel subscription description
  ///
  /// In en, this message translates to:
  /// **'To cancel your Lumena PRO subscription, please go to your subscription settings in the Google Play Store.'**
  String get cancelSubscriptionDescription;

  /// Fetching price
  ///
  /// In en, this message translates to:
  /// **'Fetching price...'**
  String get fetchingPrice;

  /// Unable to detect current plan
  ///
  /// In en, this message translates to:
  /// **'Unable to Detect Your Current Plan'**
  String get unableToDetectCurrentPlan;

  /// Unable to detect current plan
  ///
  /// In en, this message translates to:
  /// **'Please try again later or contact support if the problem persists.'**
  String get unableToDetectCurrentPlanDescription;

  /// Plan changed
  ///
  /// In en, this message translates to:
  /// **'Plan Changed'**
  String get planChanged;

  /// Plan changed description
  ///
  /// In en, this message translates to:
  /// **'Your subscription plan has been updated.'**
  String get planChangedDescription;

  /// planChangeFailed
  ///
  /// In en, this message translates to:
  /// **'Plan Change Failed'**
  String get planChangeFailed;

  /// Plan change failed description
  ///
  /// In en, this message translates to:
  /// **'Something went wrong during the upgrade process. Please try again.'**
  String get planChangeFailedDescription;

  /// Sign in to continue
  ///
  /// In en, this message translates to:
  /// **'Sign In to Continue'**
  String get signInToContinue;

  /// Continue with Google
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No edits remaining
  ///
  /// In en, this message translates to:
  /// **'No Edits Remaining'**
  String get noEditsRemaining;

  /// No edits remaining description pro
  ///
  /// In en, this message translates to:
  /// **'You have used all your monthly edits for this month. Come back next month!'**
  String get noEditsRemainingDescriptionPro;

  /// No edits remaining description non pro
  ///
  /// In en, this message translates to:
  /// **'You need to be PRO to edit images. Please upgrade to PRO to continue.'**
  String get noEditsRemainingDescriptionNonPro;

  /// Title for no internet connection dialog
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnectionTitle;

  /// Description for no internet connection dialog
  ///
  /// In en, this message translates to:
  /// **'This app requires an internet connection to function. Please check your connection and try again.'**
  String get noInternetConnectionDescription;

  /// Upgrade to pro
  ///
  /// In en, this message translates to:
  /// **'Upgrade to PRO'**
  String get upgradeToPro;

  /// Rate us dialog title
  ///
  /// In en, this message translates to:
  /// **'Enjoying Lumena?'**
  String get rateUsTitle;

  /// Rate us dialog description
  ///
  /// In en, this message translates to:
  /// **'If you love using Lumena AI, would you mind taking a moment to rate it? It won\'t take more than a minute. Thanks for your support!'**
  String get rateUsDescription;

  /// Rate us button
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rateUsButton;

  /// No thanks button
  ///
  /// In en, this message translates to:
  /// **'No thanks'**
  String get noThanks;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bn',
    'de',
    'el',
    'en',
    'es',
    'fil',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'th',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
