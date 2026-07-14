/// Maps an Open-Meteo WMO weather code to a short headline used inside
/// leave-reminder notification copy.
///
/// See https://open-meteo.com/en/docs (WMO Weather interpretation codes).
String weatherHeadline(int openMeteoWeatherCode) {
  switch (openMeteoWeatherCode) {
    case 0:
      return '☀️ Clear skies';
    case 1:
    case 2:
    case 3:
      return '🌤️ Partly cloudy';
    case 45:
    case 48:
      return '🌫️ Foggy';
    case 51:
    case 52:
    case 53:
    case 54:
    case 55:
    case 56:
    case 57:
    case 61:
    case 62:
    case 63:
    case 64:
    case 65:
    case 66:
    case 67:
    case 80:
    case 81:
    case 82:
      return '🌧️ Rain expected';
    case 71:
    case 72:
    case 73:
    case 74:
    case 75:
    case 76:
    case 77:
    case 85:
    case 86:
      return '❄️ Snow expected';
    case 95:
    case 96:
    case 97:
    case 98:
    case 99:
      return '⛈️ Thunderstorms';
    default:
      return '🌡️ Check the forecast';
  }
}
