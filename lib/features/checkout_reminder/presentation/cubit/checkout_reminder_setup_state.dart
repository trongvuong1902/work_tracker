part of 'checkout_reminder_setup_cubit.dart';

@freezed
abstract class CheckoutReminderSetupState with _$CheckoutReminderSetupState {
  const factory CheckoutReminderSetupState({
    @Default(true) bool isLoading,
    @Default(false) bool enabled,
    @Default(false) bool isTogglingEnabled,
    @Default(kDefaultCheckoutReminderLeadMinutes) int leadMinutes,
    DateTime? scheduledFireTime,
    String? errorMessage,
  }) = _CheckoutReminderSetupState;
}
