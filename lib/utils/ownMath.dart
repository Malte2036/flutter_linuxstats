import 'dart:math' show pow;

mixin OwnMath {
  static final List<int> _byteValues = <int>[
    pow(10, 0),
    pow(10, 3),
    pow(10, 6),
    pow(10, 9),
    pow(10, 12),
  ];
  static final List<String> _byteString = <String>['B', 'KB', 'MB', 'GB', 'TB'];
  static String bytesToHumanString(int bytes) {
    for (int i = _byteValues.length - 1; i >= 0; i--) {
      final int sizeType = _byteValues[i];
      if (sizeType < bytes) {
        return round(bytes / sizeType).toString() + _byteString[i];
      }
    }
    return '0B';
  }

  static String bytesToHumanCompareString(int smallByte, int bigByte) {
    for (int i = _byteValues.length - 1; i >= 0; i--) {
      final int sizeType = _byteValues[i];
      if (sizeType < bigByte) {
        return round(smallByte / sizeType).toString() +
            '/' +
            round(bigByte / sizeType).toString() +
            _byteString[i];
      }
    }
    return '';
  }

  static double round(double d, {int length = 1}) {
    return double.parse(d.toStringAsFixed(length));
  }

  static String secondsToHumanString(int sec) {
    if (sec <= 0) {
      return '';
    }
    if (sec <= 59) {
      return '0 minutes';
    }

    final List<int> allTimeSize = <int>[86400, 3600, 60];
    final List<String> allTimeSizeString = <String>['days', 'hours', 'minutes'];

    String humanTimeString = '';
    for (int i = 0; i < allTimeSize.length; i++) {
      final int timeSize = allTimeSize[i];
      final int count = sec ~/ timeSize;

      if (count != 0) {
        String timeSizeString = allTimeSizeString[i];
        if (count == 1)
          timeSizeString =
              timeSizeString.substring(0, timeSizeString.length - 1);

        humanTimeString += count.toString() + ' ' + timeSizeString + ', ';
        sec -= count * timeSize;
      }
    }
    return humanTimeString.substring(0, humanTimeString.length - 2);
  }
}
