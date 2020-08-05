import 'dart:math' show pow;

class OwnMath {
  static List<int> _byteValues = [
    pow(10, 0),
    pow(10, 3),
    pow(10, 6),
    pow(10, 9),
    pow(10, 12),
  ];
  static List<String> _byteString = ["B", "KB", "MB", "GB", "TB"];
  static String bytesToHumanString(int bytes) {
    for (int i = (_byteValues.length - 1); i >= 0; i--) {
      int sizeType = _byteValues[i];
      if (sizeType < bytes) {
        return round(bytes / sizeType).toString() + _byteString[i];
      }
    }
    return "0B";
  }

  static String bytesToHumanCompareString(int smallByte, int bigByte) {
    for (int i = (_byteValues.length - 1); i >= 0; i--) {
      int sizeType = _byteValues[i];
      if (sizeType < bigByte) {
        return round(smallByte / sizeType).toString() +
            "/" +
            round(bigByte / sizeType).toString() +
            _byteString[i];
      }
    }
    return "";
  }

  static double round(double d, {int length = 1}) {
    return double.parse(d.toStringAsFixed(length));
  }

  static String secondsToHumanString(int ms) {
    if (ms <= 0) return "";

    List<int> allTimeSize = [86400, 3600, 60];
    List<String> allTimeSizeString = ["days", "hours", "minutes"];

    String humanTimeString = ""; //"5 hours, 1 min";
    for (int i = 0; i < allTimeSize.length; i++) {
      int timeSize = allTimeSize[i];
      int count = ms ~/ timeSize;

      if (count != 0) {
        String timeSizeString = allTimeSizeString[i];
        if (count == 1)
          timeSizeString =
              timeSizeString.substring(0, timeSizeString.length - 1);

        humanTimeString += count.toString() + " " + timeSizeString + ", ";
        ms -= (count * timeSize);
      }
    }
    return humanTimeString.substring(0, humanTimeString.length - 2);
  }
}
