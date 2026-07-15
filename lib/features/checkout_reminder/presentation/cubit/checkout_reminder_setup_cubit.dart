import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/checkout_reminder/checkout_reminder_constants.dart';
import 'package:work_tracker/features/checkout_reminder/domain/checkout_reminder_repository.dart';

part 'checkout_reminder_setup_state.dart';
part 'checkout_reminder_setup_cubit.freezed.dart';

@injectable
class CheckoutReminderSetupCubit extends Cubit<CheckoutReminderSetupState> {
  CheckoutReminderSetupCubit(this._repository)
    : super(const CheckoutReminderSetupState()) {
    _loadSettings();
  }

  final CheckoutReminderRepository _repository;

  Future<void> _loadSettings() async {
    emit(state.copyWith(isLoading: true));
    final settings = await _repository.getSettings();
    emit(
      state.copyWith(
        isLoading: false,
        enabled: settings.enabled,
        leadMinutes: settings.leadMinutes,
      ),
    );
  }

  Future<void> toggleEnabled(bool value) async {
    emit(state.copyWith(isTogglingEnabled: true, errorMessage: null));
    final result = await _repository.setEnabled(value);
    switch (result) {
      case EnableCheckoutReminderResult.success:
        emit(state.copyWith(isTogglingEnabled: false, enabled: value));
      case EnableCheckoutReminderResult.notificationPermissionDenied:
        emit(
          state.copyWith(
            isTogglingEnabled: false,
            errorMessage:
                'Notifications are disabled for WorkTracker. Enable them in '
                'system settings to turn on checkout reminders.',
          ),
        );
    }
  }

  Future<void> updateLeadMinutes(int minutes) async {
    final settings = await _repository.setLeadMinutes(minutes);
    emit(state.copyWith(leadMinutes: settings.leadMinutes));
  }
}
