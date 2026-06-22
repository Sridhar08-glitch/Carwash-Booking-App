// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Holora Performance';

  @override
  String get tagline => 'Premium Car Care, Delivered to You.';

  @override
  String get btnGetStarted => 'Get Started';

  @override
  String get btnSendCode => 'Send Code';

  @override
  String get btnVerify => 'Verify';

  @override
  String get btnContinue => 'Continue';

  @override
  String get btnConfirm => 'Confirm';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnRetry => 'Try again';

  @override
  String get btnSeeAll => 'See all';

  @override
  String get btnBookNow => 'Book Now';

  @override
  String get btnAddToCart => 'Add to Cart';

  @override
  String get btnCheckout => 'Checkout';

  @override
  String get btnPay => 'Pay';

  @override
  String get btnSignOut => 'Sign Out';

  @override
  String get btnResend => 'Resend';

  @override
  String get btnShare => 'Share';

  @override
  String get btnSave => 'Save';

  @override
  String get navHome => 'Home';

  @override
  String get navServices => 'Services';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navProfile => 'Profile';

  @override
  String get navShop => 'Shop';

  @override
  String get navJobs => 'Jobs';

  @override
  String get loginTitle => 'Your Phone Number';

  @override
  String get loginSubtitle =>
      'We\'ll send you a one-time code to verify your identity.';

  @override
  String get loginPhoneLabel => 'Phone number';

  @override
  String get loginPhoneHint => '+966 5X XXX XXXX';

  @override
  String get loginTerms =>
      'By continuing you agree to our Terms & Privacy Policy.';

  @override
  String get otpTitle => 'Enter the code';

  @override
  String otpSubtitle(String phone) {
    return 'A 6-digit code was sent to\n$phone';
  }

  @override
  String get otpDidntGet => 'Didn\'t get it? ';

  @override
  String otpResendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String otpAttemptsLeft(int count) {
    return '$count attempt(s) remaining';
  }

  @override
  String homeGreeting(String timeOfDay) {
    return 'Good $timeOfDay';
  }

  @override
  String get servicesTitle => 'Services';

  @override
  String get servicesEmpty => 'No services found';

  @override
  String get servicesAll => 'All';

  @override
  String servicesDuration(int minutes) {
    return '$minutes min';
  }

  @override
  String get servicesMobile => 'Mobile available';

  @override
  String get servicesStartingFrom => 'Starting from';

  @override
  String get servicesAbout => 'About this service';

  @override
  String get servicesIncludes => 'Includes';

  @override
  String get slotPickerTitle => 'Pick a Time';

  @override
  String get slotPickerNoSlots => 'No slots available';

  @override
  String get slotPickerNoSlotsHint => 'Try a different date.';

  @override
  String get slotFull => 'Full';

  @override
  String slotLeft(int count) {
    return '$count left';
  }

  @override
  String get locationTitle => 'Choose Location';

  @override
  String get locationBranch => 'Branch Visit';

  @override
  String get locationBranchSub => 'Drop off your car at our branch';

  @override
  String get locationMobile => 'Mobile / At Home';

  @override
  String get locationMobileSub => 'We come to you';

  @override
  String get locationSelectBranch => 'Select branch';

  @override
  String get locationMobileNote =>
      'You\'ll confirm your address on the next screen.';

  @override
  String get confirmTitle => 'Confirm Booking';

  @override
  String get confirmService => 'Service';

  @override
  String get confirmDate => 'Date';

  @override
  String get confirmTime => 'Time';

  @override
  String get confirmLocation => 'Location';

  @override
  String get confirmPayment => 'Payment';

  @override
  String get confirmCash => 'Cash on service';

  @override
  String get confirmPriceNote =>
      'Final price confirmed at booking. You pay in cash after service.';

  @override
  String get successTitle => 'Booking Confirmed!';

  @override
  String get successSubtitle =>
      'Your car wash is scheduled. We\'ll see you then.';

  @override
  String get successBookingId => 'Booking ID';

  @override
  String get successStatus => 'Status';

  @override
  String get successViewBookings => 'View My Bookings';

  @override
  String get successBackHome => 'Back to Home';

  @override
  String get historyTitle => 'My Bookings';

  @override
  String get historyUpcoming => 'Upcoming';

  @override
  String get historyPast => 'Past';

  @override
  String get historyEmpty => 'No bookings yet';

  @override
  String get historyEmptySub => 'Book your first car wash service.';

  @override
  String get historyCancelBooking => 'Cancel booking';

  @override
  String get historyCancelConfirmTitle => 'Cancel booking?';

  @override
  String get historyCancelConfirmBody =>
      'This action cannot be undone. Are you sure?';

  @override
  String get historyKeep => 'Keep';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get statusAssigned => 'Assigned';

  @override
  String get statusEnRoute => 'En Route';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusNoShow => 'No Show';

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopSearchHint => 'Search products...';

  @override
  String get shopEmpty => 'No products found';

  @override
  String get shopInStock => 'In Stock';

  @override
  String get shopLowStock => 'Low Stock';

  @override
  String get shopOutOfStock => 'Out of Stock';

  @override
  String get shopFrequentlyBought => 'Frequently Bought Together';

  @override
  String get cartTitle => 'Cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get cartEmptySub => 'Add some products to get started.';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartDiscount => 'Discount';

  @override
  String get cartDelivery => 'Delivery';

  @override
  String get cartTotal => 'Total';

  @override
  String get cartPromoHint => 'Promo code';

  @override
  String get cartPromoApply => 'Apply';

  @override
  String get cartPromoSuccess => 'Promo applied!';

  @override
  String get cartPromoError => 'Invalid promo code.';

  @override
  String get cartRemoveItem => 'Remove';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get checkoutDelivery => 'Delivery';

  @override
  String get checkoutPickup => 'Pickup';

  @override
  String get checkoutSelectAddress => 'Select address';

  @override
  String get checkoutPayWith => 'Pay with';

  @override
  String get checkoutCard => 'Card';

  @override
  String get checkoutWallet => 'Wallet';

  @override
  String get checkoutCash => 'Cash on delivery';

  @override
  String get checkoutPlaceOrder => 'Place Order';

  @override
  String get checkoutOrderSuccess => 'Order Placed!';

  @override
  String get checkoutOrderSuccessSub => 'We\'ll process your order shortly.';

  @override
  String get ordersTitle => 'My Orders';

  @override
  String get ordersEmpty => 'No orders yet';

  @override
  String get ordersTrack => 'Track order';

  @override
  String get walletTitle => 'My Wallet';

  @override
  String get walletBalance => 'Balance';

  @override
  String get walletTransactions => 'Recent Transactions';

  @override
  String get walletNoTransactions => 'No transactions yet';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsEmpty => 'No notifications';

  @override
  String get notificationsMarkAll => 'Mark all read';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get notifBookingReminders => 'Booking reminders';

  @override
  String get notifOrderUpdates => 'Order updates';

  @override
  String get notifPromotions => 'Promotions';

  @override
  String get notifLoyalty => 'Loyalty updates';

  @override
  String get notifPushEnabled => 'Push notifications';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileVehicles => 'My Vehicles';

  @override
  String get profileAddresses => 'Saved Addresses';

  @override
  String get profileNotifications => 'Notification Settings';

  @override
  String get profileLoyalty => 'Loyalty Status';

  @override
  String get profileMemberships => 'Memberships';

  @override
  String get profileReferral => 'Refer a Friend';

  @override
  String get profileTheme => 'Theme';

  @override
  String get profileThemeSystem => 'System';

  @override
  String get profileThemeLight => 'Light';

  @override
  String get profileThemeDark => 'Dark';

  @override
  String get vehiclesTitle => 'My Vehicles';

  @override
  String get vehiclesAdd => 'Add Vehicle';

  @override
  String get vehiclesEmpty => 'No vehicles saved';

  @override
  String get vehiclesEmptySub => 'Add your car to speed up booking.';

  @override
  String get vehicleMake => 'Make';

  @override
  String get vehicleModel => 'Model';

  @override
  String get vehicleYear => 'Year';

  @override
  String get vehiclePlate => 'Plate number';

  @override
  String get vehicleColour => 'Colour';

  @override
  String get vehicleType => 'Type';

  @override
  String get vehicleNotes => 'Notes';

  @override
  String get vehicleDefault => 'Default';

  @override
  String get vehicleSetDefault => 'Set as default';

  @override
  String get vehicleDelete => 'Delete vehicle';

  @override
  String get vehicleDeleteConfirm => 'Delete this vehicle?';

  @override
  String get addressesTitle => 'Saved Addresses';

  @override
  String get addressesAdd => 'Add Address';

  @override
  String get addressesEmpty => 'No addresses saved';

  @override
  String get addressLabel => 'Label (e.g. Home)';

  @override
  String get addressLine1 => 'Address line 1';

  @override
  String get addressLine2 => 'Address line 2 (optional)';

  @override
  String get addressCity => 'City';

  @override
  String get addressPostal => 'Postal code';

  @override
  String get addressDefault => 'Default';

  @override
  String get recurringTitle => 'Recurring Bookings';

  @override
  String get recurringAdd => 'New recurring booking';

  @override
  String get recurringEmpty => 'No recurring bookings';

  @override
  String get recurringFrequency => 'Frequency';

  @override
  String get recurringWeekly => 'Weekly';

  @override
  String get recurringBiweekly => 'Every 2 weeks';

  @override
  String get recurringMonthly => 'Monthly';

  @override
  String get recurringWeekday => 'Preferred day';

  @override
  String get recurringTime => 'Preferred time';

  @override
  String get recurringPayment => 'Default payment';

  @override
  String get loyaltyTitle => 'Loyalty Status';

  @override
  String loyaltyPoints(int points) {
    return '$points points';
  }

  @override
  String loyaltyWashes(int count) {
    return '$count washes';
  }

  @override
  String loyaltyDiscount(String percent) {
    return '$percent% discount';
  }

  @override
  String loyaltyNextTier(String tier) {
    return 'Next tier: $tier';
  }

  @override
  String get membershipsTitle => 'Memberships';

  @override
  String get membershipsSubscribe => 'Subscribe';

  @override
  String get membershipsCancel => 'Cancel membership';

  @override
  String get membershipsCancelConfirm => 'Cancel your membership?';

  @override
  String get membershipsActive => 'Active';

  @override
  String get membershipsIncluded => 'Included';

  @override
  String get membershipsPerMonth => '/month';

  @override
  String get referralTitle => 'Refer a Friend';

  @override
  String get referralCode => 'Your referral code';

  @override
  String get referralShare => 'Share code';

  @override
  String get referralHowIt => 'How it works';

  @override
  String get referralStep1 => 'Share your code with a friend';

  @override
  String get referralStep2 => 'They book their first wash';

  @override
  String get referralStep3 => 'You both get a reward';

  @override
  String get trackingTitle => 'Live Tracking';

  @override
  String trackingEta(int minutes) {
    return 'ETA: $minutes min';
  }

  @override
  String get trackingEtaUnknown => 'ETA calculating...';

  @override
  String get trackingWasherEnRoute => 'Your washer is on the way';

  @override
  String get trackingInProgress => 'Your car is being washed';

  @override
  String get staffJobsTitle => 'My Jobs';

  @override
  String get staffJobsEmpty => 'No jobs assigned';

  @override
  String get staffAccept => 'Accept Job';

  @override
  String get staffEnRoute => 'I\'m on my way';

  @override
  String get staffStart => 'Start Service';

  @override
  String get staffComplete => 'Mark Complete';

  @override
  String get staffChecklist => 'Checklist';

  @override
  String get staffPhotos => 'Before / After Photos';

  @override
  String get staffBefore => 'Before photo';

  @override
  String get staffAfter => 'After photo';

  @override
  String get staffNavigate => 'Navigate';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNetwork => 'No internet connection.';

  @override
  String get errorTimeout => 'The request timed out.';

  @override
  String get errorSlotFull => 'This time slot is no longer available.';

  @override
  String get errorSessionExpired =>
      'Your session has expired. Please log in again.';

  @override
  String get errorOfflineBooking => 'You\'re offline. Please connect to book.';

  @override
  String get offlineBanner => 'No internet connection';
}
