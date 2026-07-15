import 'package:freezed_annotation/freezed_annotation.dart';

import '../../checkout_reminder_constants.dart';

part 'checkout_reminder_settings.freezed.dart';

@freezed
abstract class CheckoutReminderSettings with _$CheckoutReminderSettings {
  const factory CheckoutReminderSettings({
    @Default(false) bool enabled,
    @Default(kDefaultCheckoutReminderLeadMinutes) int leadMinutes,
  }) = _CheckoutReminderSettings;
}
