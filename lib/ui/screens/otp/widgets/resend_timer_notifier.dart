part of '../otp_verification_screen.dart';

const int _tickDurationInSeconds = 1;
const int _countTimerInSeconds = 60;

class _ResendOtpTimerNotifier extends ChangeNotifier
    implements ValueListenable<_ResendOtpNotifierValue> {
  Timer? _timer;
  int _timeRemainingInSeconds = _countTimerInSeconds;

  void startTimer() {
    _timer?.cancel();
    _timer = null;
    _timeRemainingInSeconds = _countTimerInSeconds;
    _timer = Timer.periodic(const Duration(seconds: _tickDurationInSeconds),
        (timer) {
      _timeRemainingInSeconds =
          _countTimerInSeconds - (timer.tick * _tickDurationInSeconds);

      if (_checkIfHasEnded) {
        timer.cancel();
      }

      notifyListeners();
    });
  }

  bool get _checkIfHasEnded {
    if (_countTimerInSeconds > 600) {
      _timer?.cancel();
      return false;
    }
    return _timeRemainingInSeconds <= 0;
  }

  String get _timerText {
    if (_countTimerInSeconds > 600) {
      return "00";
    }
    final int minutesToInt = _minutes.floor();
    String minute = minutesToInt.toString().length <= 1
        ? "0$minutesToInt"
        : "$minutesToInt";
    String second =
        _seconds.toString().length <= 1 ? "0$_seconds" : "$_seconds";
    return "$minute:$second";
  }

  int get _seconds {
    if (_countTimerInSeconds > 600) {
      return 0;
    }
    return _timeRemainingInSeconds % 60;
  }

  double get _minutes {
    if (_countTimerInSeconds > 600) {
      return 0;
    }
    return _timeRemainingInSeconds / 60;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  @override
  _ResendOtpNotifierValue get value => _ResendOtpNotifierValue(
        isEnded: _checkIfHasEnded,
        timerText: _timerText,
        timeRemainingInSeconds: _timeRemainingInSeconds,
        minutes: _minutes,
        seconds: _seconds,
      );
}

class _ResendOtpNotifierValue extends Equatable {
  final String timerText;
  final bool isEnded;
  final int timeRemainingInSeconds;
  final int seconds;
  final double minutes;

  const _ResendOtpNotifierValue(
      {required this.timerText,
      required this.isEnded,
      required this.timeRemainingInSeconds,
      required this.seconds,
      required this.minutes});

  _ResendOtpNotifierValue copyWith({
    String? timerText,
    bool? isEnded,
    int? timeRemainingInSeconds,
    int? seconds,
    double? minutes,
  }) {
    return _ResendOtpNotifierValue(
      isEnded: isEnded ?? this.isEnded,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      timeRemainingInSeconds:
          timeRemainingInSeconds ?? this.timeRemainingInSeconds,
      timerText: timerText ?? this.timerText,
    );
  }

  @override
  List<Object?> get props =>
      [timerText, isEnded, timeRemainingInSeconds, seconds, minutes];
}
