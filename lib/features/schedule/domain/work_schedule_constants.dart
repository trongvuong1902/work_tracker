/// Default working-days bitmask used when no schedule has been saved yet.
/// Bit0..Bit6 correspond to DateTime.weekday 1..7 (Mon..Sun) via
/// `1 << (weekday - 1)`. This default covers Monday-Friday (0b0011111).
const int kDefaultWorkingDaysMask = 31;
