// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'هولورا بيرفورمانس';

  @override
  String get tagline => 'العناية بسيارتك بمستوى احترافي.';

  @override
  String get btnGetStarted => 'ابدأ الآن';

  @override
  String get btnSendCode => 'إرسال الرمز';

  @override
  String get btnVerify => 'تحقق';

  @override
  String get btnContinue => 'متابعة';

  @override
  String get btnConfirm => 'تأكيد';

  @override
  String get btnCancel => 'إلغاء';

  @override
  String get btnRetry => 'حاول مجدداً';

  @override
  String get btnSeeAll => 'عرض الكل';

  @override
  String get btnBookNow => 'احجز الآن';

  @override
  String get btnAddToCart => 'أضف للسلة';

  @override
  String get btnCheckout => 'إتمام الشراء';

  @override
  String get btnPay => 'ادفع';

  @override
  String get btnSignOut => 'تسجيل الخروج';

  @override
  String get btnResend => 'إعادة الإرسال';

  @override
  String get btnShare => 'مشاركة';

  @override
  String get btnSave => 'حفظ';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navServices => 'الخدمات';

  @override
  String get navBookings => 'الحجوزات';

  @override
  String get navProfile => 'الملف';

  @override
  String get navShop => 'المتجر';

  @override
  String get navJobs => 'المهام';

  @override
  String get loginTitle => 'رقم هاتفك';

  @override
  String get loginSubtitle => 'سنرسل لك رمزاً للتحقق من هويتك.';

  @override
  String get loginPhoneLabel => 'رقم الهاتف';

  @override
  String get loginPhoneHint => '+966 5X XXX XXXX';

  @override
  String get loginTerms => 'بالمتابعة فأنت توافق على الشروط وسياسة الخصوصية.';

  @override
  String get otpTitle => 'أدخل الرمز';

  @override
  String otpSubtitle(String phone) {
    return 'تم إرسال رمز مكوّن من 6 أرقام إلى\n$phone';
  }

  @override
  String get otpDidntGet => 'لم تستلمه؟ ';

  @override
  String otpResendIn(int seconds) {
    return 'إعادة الإرسال خلال $secondsث';
  }

  @override
  String otpAttemptsLeft(int count) {
    return 'تبقى $count محاولة';
  }

  @override
  String homeGreeting(String timeOfDay) {
    return 'مرحباً';
  }

  @override
  String get servicesTitle => 'الخدمات';

  @override
  String get servicesEmpty => 'لا توجد خدمات';

  @override
  String get servicesAll => 'الكل';

  @override
  String servicesDuration(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get servicesMobile => 'متوفرة للمنازل';

  @override
  String get servicesStartingFrom => 'يبدأ من';

  @override
  String get servicesAbout => 'عن هذه الخدمة';

  @override
  String get servicesIncludes => 'يشمل';

  @override
  String get slotPickerTitle => 'اختر الموعد';

  @override
  String get slotPickerNoSlots => 'لا توجد مواعيد متاحة';

  @override
  String get slotPickerNoSlotsHint => 'جرّب تاريخاً آخر.';

  @override
  String get slotFull => 'ممتلئ';

  @override
  String slotLeft(int count) {
    return 'تبقى $count';
  }

  @override
  String get locationTitle => 'اختر الموقع';

  @override
  String get locationBranch => 'زيارة الفرع';

  @override
  String get locationBranchSub => 'أحضر سيارتك إلى فرعنا';

  @override
  String get locationMobile => 'خدمة منزلية';

  @override
  String get locationMobileSub => 'نحن نأتي إليك';

  @override
  String get locationSelectBranch => 'اختر الفرع';

  @override
  String get locationMobileNote => 'ستؤكد عنوانك في الخطوة التالية.';

  @override
  String get confirmTitle => 'تأكيد الحجز';

  @override
  String get confirmService => 'الخدمة';

  @override
  String get confirmDate => 'التاريخ';

  @override
  String get confirmTime => 'الوقت';

  @override
  String get confirmLocation => 'الموقع';

  @override
  String get confirmPayment => 'طريقة الدفع';

  @override
  String get confirmCash => 'نقداً عند الخدمة';

  @override
  String get confirmPriceNote => 'يُحدَّد السعر النهائي عند تأكيد الحجز.';

  @override
  String get successTitle => 'تم تأكيد حجزك!';

  @override
  String get successSubtitle => 'موعد غسيل سيارتك محجوز. نراك قريباً.';

  @override
  String get successBookingId => 'رقم الحجز';

  @override
  String get successStatus => 'الحالة';

  @override
  String get successViewBookings => 'عرض حجوزاتي';

  @override
  String get successBackHome => 'العودة للرئيسية';

  @override
  String get historyTitle => 'حجوزاتي';

  @override
  String get historyUpcoming => 'القادمة';

  @override
  String get historyPast => 'السابقة';

  @override
  String get historyEmpty => 'لا توجد حجوزات';

  @override
  String get historyEmptySub => 'احجز أول خدمة غسيل لسيارتك.';

  @override
  String get historyCancelBooking => 'إلغاء الحجز';

  @override
  String get historyCancelConfirmTitle => 'إلغاء الحجز؟';

  @override
  String get historyCancelConfirmBody => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get historyKeep => 'احتفظ بالحجز';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusConfirmed => 'مؤكد';

  @override
  String get statusAssigned => 'تم التعيين';

  @override
  String get statusEnRoute => 'في الطريق';

  @override
  String get statusInProgress => 'جارٍ التنفيذ';

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get statusCancelled => 'ملغى';

  @override
  String get statusNoShow => 'لم يحضر';

  @override
  String get shopTitle => 'المتجر';

  @override
  String get shopSearchHint => 'ابحث عن منتج...';

  @override
  String get shopEmpty => 'لا توجد منتجات';

  @override
  String get shopInStock => 'متوفر';

  @override
  String get shopLowStock => 'كمية محدودة';

  @override
  String get shopOutOfStock => 'نفد المخزون';

  @override
  String get shopFrequentlyBought => 'يُشترى معاً';

  @override
  String get cartTitle => 'سلة التسوق';

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get cartEmptySub => 'أضف بعض المنتجات للبدء.';

  @override
  String get cartSubtotal => 'المجموع الجزئي';

  @override
  String get cartDiscount => 'الخصم';

  @override
  String get cartDelivery => 'التوصيل';

  @override
  String get cartTotal => 'الإجمالي';

  @override
  String get cartPromoHint => 'كود الخصم';

  @override
  String get cartPromoApply => 'تطبيق';

  @override
  String get cartPromoSuccess => 'تم تطبيق الكود!';

  @override
  String get cartPromoError => 'كود الخصم غير صالح.';

  @override
  String get cartRemoveItem => 'حذف';

  @override
  String get checkoutTitle => 'إتمام الشراء';

  @override
  String get checkoutDelivery => 'توصيل';

  @override
  String get checkoutPickup => 'استلام من الفرع';

  @override
  String get checkoutSelectAddress => 'اختر العنوان';

  @override
  String get checkoutPayWith => 'ادفع بـ';

  @override
  String get checkoutCard => 'بطاقة';

  @override
  String get checkoutWallet => 'المحفظة';

  @override
  String get checkoutCash => 'نقداً عند الاستلام';

  @override
  String get checkoutPlaceOrder => 'تأكيد الطلب';

  @override
  String get checkoutOrderSuccess => 'تم تقديم الطلب!';

  @override
  String get checkoutOrderSuccessSub => 'سنعالج طلبك قريباً.';

  @override
  String get ordersTitle => 'طلباتي';

  @override
  String get ordersEmpty => 'لا توجد طلبات';

  @override
  String get ordersTrack => 'تتبع الطلب';

  @override
  String get walletTitle => 'محفظتي';

  @override
  String get walletBalance => 'الرصيد';

  @override
  String get walletTransactions => 'آخر المعاملات';

  @override
  String get walletNoTransactions => 'لا توجد معاملات';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات';

  @override
  String get notificationsMarkAll => 'تعليم الكل مقروءاً';

  @override
  String get notificationSettings => 'إعدادات الإشعارات';

  @override
  String get notifBookingReminders => 'تذكيرات الحجز';

  @override
  String get notifOrderUpdates => 'تحديثات الطلبات';

  @override
  String get notifPromotions => 'العروض والخصومات';

  @override
  String get notifLoyalty => 'تحديثات الولاء';

  @override
  String get notifPushEnabled => 'الإشعارات الفورية';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileVehicles => 'سياراتي';

  @override
  String get profileAddresses => 'العناوين المحفوظة';

  @override
  String get profileNotifications => 'إعدادات الإشعارات';

  @override
  String get profileLoyalty => 'نقاط الولاء';

  @override
  String get profileMemberships => 'الاشتراكات';

  @override
  String get profileReferral => 'دعوة صديق';

  @override
  String get profileTheme => 'المظهر';

  @override
  String get profileThemeSystem => 'تلقائي';

  @override
  String get profileThemeLight => 'فاتح';

  @override
  String get profileThemeDark => 'داكن';

  @override
  String get vehiclesTitle => 'سياراتي';

  @override
  String get vehiclesAdd => 'إضافة سيارة';

  @override
  String get vehiclesEmpty => 'لا توجد سيارات';

  @override
  String get vehiclesEmptySub => 'أضف سيارتك لتسريع الحجز.';

  @override
  String get vehicleMake => 'الشركة المصنعة';

  @override
  String get vehicleModel => 'الطراز';

  @override
  String get vehicleYear => 'سنة الصنع';

  @override
  String get vehiclePlate => 'رقم اللوحة';

  @override
  String get vehicleColour => 'اللون';

  @override
  String get vehicleType => 'النوع';

  @override
  String get vehicleNotes => 'ملاحظات';

  @override
  String get vehicleDefault => 'افتراضي';

  @override
  String get vehicleSetDefault => 'تعيين كافتراضي';

  @override
  String get vehicleDelete => 'حذف السيارة';

  @override
  String get vehicleDeleteConfirm => 'حذف هذه السيارة؟';

  @override
  String get addressesTitle => 'العناوين المحفوظة';

  @override
  String get addressesAdd => 'إضافة عنوان';

  @override
  String get addressesEmpty => 'لا توجد عناوين';

  @override
  String get addressLabel => 'التسمية (مثال: المنزل)';

  @override
  String get addressLine1 => 'السطر الأول';

  @override
  String get addressLine2 => 'السطر الثاني (اختياري)';

  @override
  String get addressCity => 'المدينة';

  @override
  String get addressPostal => 'الرمز البريدي';

  @override
  String get addressDefault => 'افتراضي';

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
  String get errorGeneric => 'حدث خطأ. يرجى المحاولة مجدداً.';

  @override
  String get errorNetwork => 'لا يوجد اتصال بالإنترنت.';

  @override
  String get errorTimeout => 'انتهت مهلة الطلب.';

  @override
  String get errorSlotFull => 'هذا الموعد لم يعد متاحاً.';

  @override
  String get errorSessionExpired => 'انتهت جلستك. يرجى تسجيل الدخول مجدداً.';

  @override
  String get errorOfflineBooking => 'أنت غير متصل. اتصل بالإنترنت للحجز.';

  @override
  String get offlineBanner => 'لا يوجد اتصال بالإنترنت';
}
