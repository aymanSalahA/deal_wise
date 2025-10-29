 

abstract class OtpVerificationState {
  final int timer;
  final bool canResend;

  const OtpVerificationState({this.timer = 60, this.canResend = false});
}

class OtpInitial extends OtpVerificationState {
  const OtpInitial({super.timer, super.canResend});

  OtpInitial copyWith({int? timer, bool? canResend}) {
    return OtpInitial(
      timer: timer ?? this.timer,
      canResend: canResend ?? this.canResend,
    );
  }
}

class OtpVerificationLoading extends OtpInitial {

  const OtpVerificationLoading({super.timer, super.canResend});
}

class OtpVerificationSuccess extends OtpVerificationState {
  const OtpVerificationSuccess() : super(timer: 0, canResend: false);
}


class OtpVerificationFailure extends OtpInitial {
  final String errorMessage;
  const OtpVerificationFailure(this.errorMessage, {super.timer, super.canResend});
}