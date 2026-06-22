import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Holora Performance'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Premium Car Care, Delivered to You.'**
  String get tagline;

  /// No description provided for @btnGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get btnGetStarted;

  /// No description provided for @btnSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get btnSendCode;

  /// No description provided for @btnVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get btnVerify;

  /// No description provided for @btnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// No description provided for @btnConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btnConfirm;

  /// No description provided for @btnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btnCancel;

  /// No description provided for @btnRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get btnRetry;

  /// No description provided for @btnSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get btnSeeAll;

  /// No description provided for @btnBookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get btnBookNow;

  /// No description provided for @btnAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get btnAddToCart;

  /// No description provided for @btnCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get btnCheckout;

  /// No description provided for @btnPay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get btnPay;

  /// No description provided for @btnSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get btnSignOut;

  /// No description provided for @btnResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get btnResend;

  /// No description provided for @btnShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get btnShare;

  /// No description provided for @btnSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get btnSave;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get navServices;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @navJobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get navJobs;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Phone Number'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a one-time code to verify your identity.'**
  String get loginSubtitle;

  /// No description provided for @loginPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get loginPhoneLabel;

  /// No description provided for @loginPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+966 5X XXX XXXX'**
  String get loginPhoneHint;

  /// No description provided for @loginTerms.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to our Terms & Privacy Policy.'**
  String get loginTerms;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A 6-digit code was sent to\n{phone}'**
  String otpSubtitle(String phone);

  /// No description provided for @otpDidntGet.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get it? '**
  String get otpDidntGet;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String otpResendIn(int seconds);

  /// No description provided for @otpAttemptsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} attempt(s) remaining'**
  String otpAttemptsLeft(int count);

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good {timeOfDay}'**
  String homeGreeting(String timeOfDay);

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTitle;

  /// No description provided for @servicesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No services found'**
  String get servicesEmpty;

  /// No description provided for @servicesAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get servicesAll;

  /// No description provided for @servicesDuration.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String servicesDuration(int minutes);

  /// No description provided for @servicesMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile available'**
  String get servicesMobile;

  /// No description provided for @servicesStartingFrom.
  ///
  /// In en, this message translates to:
  /// **'Starting from'**
  String get servicesStartingFrom;

  /// No description provided for @servicesAbout.
  ///
  /// In en, this message translates to:
  /// **'About this service'**
  String get servicesAbout;

  /// No description provided for @servicesIncludes.
  ///
  /// In en, this message translates to:
  /// **'Includes'**
  String get servicesIncludes;

  /// No description provided for @slotPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a Time'**
  String get slotPickerTitle;

  /// No description provided for @slotPickerNoSlots.
  ///
  /// In en, this message translates to:
  /// **'No slots available'**
  String get slotPickerNoSlots;

  /// No description provided for @slotPickerNoSlotsHint.
  ///
  /// In en, this message translates to:
  /// **'Try a different date.'**
  String get slotPickerNoSlotsHint;

  /// No description provided for @slotFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get slotFull;

  /// No description provided for @slotLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String slotLeft(int count);

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Location'**
  String get locationTitle;

  /// No description provided for @locationBranch.
  ///
  /// In en, this message translates to:
  /// **'Branch Visit'**
  String get locationBranch;

  /// No description provided for @locationBranchSub.
  ///
  /// In en, this message translates to:
  /// **'Drop off your car at our branch'**
  String get locationBranchSub;

  /// No description provided for @locationMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile / At Home'**
  String get locationMobile;

  /// No description provided for @locationMobileSub.
  ///
  /// In en, this message translates to:
  /// **'We come to you'**
  String get locationMobileSub;

  /// No description provided for @locationSelectBranch.
  ///
  /// In en, this message translates to:
  /// **'Select branch'**
  String get locationSelectBranch;

  /// No description provided for @locationMobileNote.
  ///
  /// In en, this message translates to:
  /// **'You\'ll confirm your address on the next screen.'**
  String get locationMobileNote;

  /// No description provided for @confirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmTitle;

  /// No description provided for @confirmService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get confirmService;

  /// No description provided for @confirmDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get confirmDate;

  /// No description provided for @confirmTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get confirmTime;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get confirmLocation;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get confirmPayment;

  /// No description provided for @confirmCash.
  ///
  /// In en, this message translates to:
  /// **'Cash on service'**
  String get confirmCash;

  /// No description provided for @confirmPriceNote.
  ///
  /// In en, this message translates to:
  /// **'Final price confirmed at booking. You pay in cash after service.'**
  String get confirmPriceNote;

  /// No description provided for @successTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get successTitle;

  /// No description provided for @successSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your car wash is scheduled. We\'ll see you then.'**
  String get successSubtitle;

  /// No description provided for @successBookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get successBookingId;

  /// No description provided for @successStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get successStatus;

  /// No description provided for @successViewBookings.
  ///
  /// In en, this message translates to:
  /// **'View My Bookings'**
  String get successViewBookings;

  /// No description provided for @successBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get successBackHome;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get historyTitle;

  /// No description provided for @historyUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get historyUpcoming;

  /// No description provided for @historyPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get historyPast;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet'**
  String get historyEmpty;

  /// No description provided for @historyEmptySub.
  ///
  /// In en, this message translates to:
  /// **'Book your first car wash service.'**
  String get historyEmptySub;

  /// No description provided for @historyCancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get historyCancelBooking;

  /// No description provided for @historyCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking?'**
  String get historyCancelConfirmTitle;

  /// No description provided for @historyCancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Are you sure?'**
  String get historyCancelConfirmBody;

  /// No description provided for @historyKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get historyKeep;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @statusAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get statusAssigned;

  /// No description provided for @statusEnRoute.
  ///
  /// In en, this message translates to:
  /// **'En Route'**
  String get statusEnRoute;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusNoShow.
  ///
  /// In en, this message translates to:
  /// **'No Show'**
  String get statusNoShow;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @shopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get shopSearchHint;

  /// No description provided for @shopEmpty.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get shopEmpty;

  /// No description provided for @shopInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get shopInStock;

  /// No description provided for @shopLowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get shopLowStock;

  /// No description provided for @shopOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get shopOutOfStock;

  /// No description provided for @shopFrequentlyBought.
  ///
  /// In en, this message translates to:
  /// **'Frequently Bought Together'**
  String get shopFrequentlyBought;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @cartEmptySub.
  ///
  /// In en, this message translates to:
  /// **'Add some products to get started.'**
  String get cartEmptySub;

  /// No description provided for @cartSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartSubtotal;

  /// No description provided for @cartDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get cartDiscount;

  /// No description provided for @cartDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get cartDelivery;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cartTotal;

  /// No description provided for @cartPromoHint.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get cartPromoHint;

  /// No description provided for @cartPromoApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get cartPromoApply;

  /// No description provided for @cartPromoSuccess.
  ///
  /// In en, this message translates to:
  /// **'Promo applied!'**
  String get cartPromoSuccess;

  /// No description provided for @cartPromoError.
  ///
  /// In en, this message translates to:
  /// **'Invalid promo code.'**
  String get cartPromoError;

  /// No description provided for @cartRemoveItem.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get cartRemoveItem;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @checkoutDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get checkoutDelivery;

  /// No description provided for @checkoutPickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get checkoutPickup;

  /// No description provided for @checkoutSelectAddress.
  ///
  /// In en, this message translates to:
  /// **'Select address'**
  String get checkoutSelectAddress;

  /// No description provided for @checkoutPayWith.
  ///
  /// In en, this message translates to:
  /// **'Pay with'**
  String get checkoutPayWith;

  /// No description provided for @checkoutCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get checkoutCard;

  /// No description provided for @checkoutWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get checkoutWallet;

  /// No description provided for @checkoutCash.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get checkoutCash;

  /// No description provided for @checkoutPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get checkoutPlaceOrder;

  /// No description provided for @checkoutOrderSuccess.
  ///
  /// In en, this message translates to:
  /// **'Order Placed!'**
  String get checkoutOrderSuccess;

  /// No description provided for @checkoutOrderSuccessSub.
  ///
  /// In en, this message translates to:
  /// **'We\'ll process your order shortly.'**
  String get checkoutOrderSuccessSub;

  /// No description provided for @ordersTitle.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get ordersTitle;

  /// No description provided for @ordersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get ordersEmpty;

  /// No description provided for @ordersTrack.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get ordersTrack;

  /// No description provided for @walletTitle.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get walletTitle;

  /// No description provided for @walletBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get walletBalance;

  /// No description provided for @walletTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get walletTransactions;

  /// No description provided for @walletNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get walletNoTransactions;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsEmpty;

  /// No description provided for @notificationsMarkAll.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAll;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @notifBookingReminders.
  ///
  /// In en, this message translates to:
  /// **'Booking reminders'**
  String get notifBookingReminders;

  /// No description provided for @notifOrderUpdates.
  ///
  /// In en, this message translates to:
  /// **'Order updates'**
  String get notifOrderUpdates;

  /// No description provided for @notifPromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get notifPromotions;

  /// No description provided for @notifLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty updates'**
  String get notifLoyalty;

  /// No description provided for @notifPushEnabled.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get notifPushEnabled;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileVehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get profileVehicles;

  /// No description provided for @profileAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get profileAddresses;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get profileNotifications;

  /// No description provided for @profileLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Status'**
  String get profileLoyalty;

  /// No description provided for @profileMemberships.
  ///
  /// In en, this message translates to:
  /// **'Memberships'**
  String get profileMemberships;

  /// No description provided for @profileReferral.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend'**
  String get profileReferral;

  /// No description provided for @profileTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileTheme;

  /// No description provided for @profileThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get profileThemeSystem;

  /// No description provided for @profileThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profileThemeLight;

  /// No description provided for @profileThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profileThemeDark;

  /// No description provided for @vehiclesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get vehiclesTitle;

  /// No description provided for @vehiclesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get vehiclesAdd;

  /// No description provided for @vehiclesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No vehicles saved'**
  String get vehiclesEmpty;

  /// No description provided for @vehiclesEmptySub.
  ///
  /// In en, this message translates to:
  /// **'Add your car to speed up booking.'**
  String get vehiclesEmptySub;

  /// No description provided for @vehicleMake.
  ///
  /// In en, this message translates to:
  /// **'Make'**
  String get vehicleMake;

  /// No description provided for @vehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get vehicleModel;

  /// No description provided for @vehicleYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get vehicleYear;

  /// No description provided for @vehiclePlate.
  ///
  /// In en, this message translates to:
  /// **'Plate number'**
  String get vehiclePlate;

  /// No description provided for @vehicleColour.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get vehicleColour;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get vehicleType;

  /// No description provided for @vehicleNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get vehicleNotes;

  /// No description provided for @vehicleDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get vehicleDefault;

  /// No description provided for @vehicleSetDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get vehicleSetDefault;

  /// No description provided for @vehicleDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete vehicle'**
  String get vehicleDelete;

  /// No description provided for @vehicleDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this vehicle?'**
  String get vehicleDeleteConfirm;

  /// No description provided for @addressesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get addressesTitle;

  /// No description provided for @addressesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addressesAdd;

  /// No description provided for @addressesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No addresses saved'**
  String get addressesEmpty;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Label (e.g. Home)'**
  String get addressLabel;

  /// No description provided for @addressLine1.
  ///
  /// In en, this message translates to:
  /// **'Address line 1'**
  String get addressLine1;

  /// No description provided for @addressLine2.
  ///
  /// In en, this message translates to:
  /// **'Address line 2 (optional)'**
  String get addressLine2;

  /// No description provided for @addressCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get addressCity;

  /// No description provided for @addressPostal.
  ///
  /// In en, this message translates to:
  /// **'Postal code'**
  String get addressPostal;

  /// No description provided for @addressDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get addressDefault;

  /// No description provided for @recurringTitle.
  ///
  /// In en, this message translates to:
  /// **'Recurring Bookings'**
  String get recurringTitle;

  /// No description provided for @recurringAdd.
  ///
  /// In en, this message translates to:
  /// **'New recurring booking'**
  String get recurringAdd;

  /// No description provided for @recurringEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recurring bookings'**
  String get recurringEmpty;

  /// No description provided for @recurringFrequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get recurringFrequency;

  /// No description provided for @recurringWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get recurringWeekly;

  /// No description provided for @recurringBiweekly.
  ///
  /// In en, this message translates to:
  /// **'Every 2 weeks'**
  String get recurringBiweekly;

  /// No description provided for @recurringMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get recurringMonthly;

  /// No description provided for @recurringWeekday.
  ///
  /// In en, this message translates to:
  /// **'Preferred day'**
  String get recurringWeekday;

  /// No description provided for @recurringTime.
  ///
  /// In en, this message translates to:
  /// **'Preferred time'**
  String get recurringTime;

  /// No description provided for @recurringPayment.
  ///
  /// In en, this message translates to:
  /// **'Default payment'**
  String get recurringPayment;

  /// No description provided for @loyaltyTitle.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Status'**
  String get loyaltyTitle;

  /// No description provided for @loyaltyPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String loyaltyPoints(int points);

  /// No description provided for @loyaltyWashes.
  ///
  /// In en, this message translates to:
  /// **'{count} washes'**
  String loyaltyWashes(int count);

  /// No description provided for @loyaltyDiscount.
  ///
  /// In en, this message translates to:
  /// **'{percent}% discount'**
  String loyaltyDiscount(String percent);

  /// No description provided for @loyaltyNextTier.
  ///
  /// In en, this message translates to:
  /// **'Next tier: {tier}'**
  String loyaltyNextTier(String tier);

  /// No description provided for @membershipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Memberships'**
  String get membershipsTitle;

  /// No description provided for @membershipsSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get membershipsSubscribe;

  /// No description provided for @membershipsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel membership'**
  String get membershipsCancel;

  /// No description provided for @membershipsCancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel your membership?'**
  String get membershipsCancelConfirm;

  /// No description provided for @membershipsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get membershipsActive;

  /// No description provided for @membershipsIncluded.
  ///
  /// In en, this message translates to:
  /// **'Included'**
  String get membershipsIncluded;

  /// No description provided for @membershipsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get membershipsPerMonth;

  /// No description provided for @referralTitle.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend'**
  String get referralTitle;

  /// No description provided for @referralCode.
  ///
  /// In en, this message translates to:
  /// **'Your referral code'**
  String get referralCode;

  /// No description provided for @referralShare.
  ///
  /// In en, this message translates to:
  /// **'Share code'**
  String get referralShare;

  /// No description provided for @referralHowIt.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get referralHowIt;

  /// No description provided for @referralStep1.
  ///
  /// In en, this message translates to:
  /// **'Share your code with a friend'**
  String get referralStep1;

  /// No description provided for @referralStep2.
  ///
  /// In en, this message translates to:
  /// **'They book their first wash'**
  String get referralStep2;

  /// No description provided for @referralStep3.
  ///
  /// In en, this message translates to:
  /// **'You both get a reward'**
  String get referralStep3;

  /// No description provided for @trackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Tracking'**
  String get trackingTitle;

  /// No description provided for @trackingEta.
  ///
  /// In en, this message translates to:
  /// **'ETA: {minutes} min'**
  String trackingEta(int minutes);

  /// No description provided for @trackingEtaUnknown.
  ///
  /// In en, this message translates to:
  /// **'ETA calculating...'**
  String get trackingEtaUnknown;

  /// No description provided for @trackingWasherEnRoute.
  ///
  /// In en, this message translates to:
  /// **'Your washer is on the way'**
  String get trackingWasherEnRoute;

  /// No description provided for @trackingInProgress.
  ///
  /// In en, this message translates to:
  /// **'Your car is being washed'**
  String get trackingInProgress;

  /// No description provided for @staffJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Jobs'**
  String get staffJobsTitle;

  /// No description provided for @staffJobsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No jobs assigned'**
  String get staffJobsEmpty;

  /// No description provided for @staffAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept Job'**
  String get staffAccept;

  /// No description provided for @staffEnRoute.
  ///
  /// In en, this message translates to:
  /// **'I\'m on my way'**
  String get staffEnRoute;

  /// No description provided for @staffStart.
  ///
  /// In en, this message translates to:
  /// **'Start Service'**
  String get staffStart;

  /// No description provided for @staffComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Complete'**
  String get staffComplete;

  /// No description provided for @staffChecklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get staffChecklist;

  /// No description provided for @staffPhotos.
  ///
  /// In en, this message translates to:
  /// **'Before / After Photos'**
  String get staffPhotos;

  /// No description provided for @staffBefore.
  ///
  /// In en, this message translates to:
  /// **'Before photo'**
  String get staffBefore;

  /// No description provided for @staffAfter.
  ///
  /// In en, this message translates to:
  /// **'After photo'**
  String get staffAfter;

  /// No description provided for @staffNavigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get staffNavigate;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The request timed out.'**
  String get errorTimeout;

  /// No description provided for @errorSlotFull.
  ///
  /// In en, this message translates to:
  /// **'This time slot is no longer available.'**
  String get errorSlotFull;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get errorSessionExpired;

  /// No description provided for @errorOfflineBooking.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Please connect to book.'**
  String get errorOfflineBooking;

  /// No description provided for @offlineBanner.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get offlineBanner;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
