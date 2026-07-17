/// Default lead time (minutes) for the checkout reminder notification,
/// fired before the user's real expected checkout time.
const int kDefaultCheckoutReminderLeadMinutes = 15;

/// Selectable values (minutes) for the "notify before checkout" lead time.
const List<int> kCheckoutReminderLeadOptions = [5, 10, 15, 20, 30, 45, 60];

/// Local notification id for the checkout reminder alert.
const int kCheckoutReminderNotificationId = 9101;

/// Local notification id for the end-of-work alert, fired exactly at the
/// user's expected checkout time (no lead time).
const int kEndOfWorkNotificationId = 9102;
