class Auth {
  String? session;
  String? sessionKey;
  String? wh_status;
  String? wh_message;
  String? wh_qrcode;
  String? wh_connect;
  Auth({
    this.session,
    this.sessionKey,
    this.wh_status,
    this.wh_message,
    this.wh_qrcode,
    this.wh_connect,
  });

  Auth copyWith({
    String? session,
    String? sessionKey,
    String? wh_status,
    String? wh_message,
    String? wh_qrcode,
    String? wh_connect,
  }) {
    return Auth(
      session: session ?? this.session,
      sessionKey: sessionKey ?? this.sessionKey,
      wh_status: wh_status ?? this.wh_status,
      wh_message: wh_message ?? this.wh_message,
      wh_qrcode: wh_qrcode ?? this.wh_qrcode,
      wh_connect: wh_connect ?? this.wh_connect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'session': session,
      'sessionKey': sessionKey,
      'wh_status': wh_status,
      'wh_message': wh_message,
      'wh_qrcode': wh_qrcode,
      'wh_connect': wh_connect,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      session: map['session'] != null ? map['session'] as String : null,
      sessionKey:
          map['sessionKey'] != null ? map['sessionKey'] as String : null,
      wh_status: map['wh_status'] != null ? map['wh_status'] as String : null,
      wh_message:
          map['wh_message'] != null ? map['wh_message'] as String : null,
      wh_qrcode: map['wh_qrcode'] != null ? map['wh_qrcode'] as String : null,
      wh_connect:
          map['wh_connect'] != null ? map['wh_connect'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Auth(session: $session, sessionKey: $sessionKey, wh_status: $wh_status, wh_message: $wh_message, wh_qrcode: $wh_qrcode, wh_connect: $wh_connect)';
  }

  @override
  bool operator ==(covariant Auth other) {
    if (identical(this, other)) return true;

    return other.session == session &&
        other.sessionKey == sessionKey &&
        other.wh_status == wh_status &&
        other.wh_message == wh_message &&
        other.wh_qrcode == wh_qrcode &&
        other.wh_connect == wh_connect;
  }

  @override
  int get hashCode {
    return session.hashCode ^
        sessionKey.hashCode ^
        wh_status.hashCode ^
        wh_message.hashCode ^
        wh_qrcode.hashCode ^
        wh_connect.hashCode;
  }
}
