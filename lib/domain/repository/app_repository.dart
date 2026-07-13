abstract class AppRepository {
  bool get isOnboardingCompleted;

  Future<void> completeOnboarding();
}
