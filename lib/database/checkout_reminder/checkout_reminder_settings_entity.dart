import 'package:objectbox/objectbox.dart';

@Entity()
class CheckoutReminderSettingsEntity {
  @Id()
  int id = 0;

  bool enabled;

  int leadMinutes;

  CheckoutReminderSettingsEntity({this.enabled = false, this.leadMinutes = 15});
}
