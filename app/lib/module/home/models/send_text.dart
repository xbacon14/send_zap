// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendText {
  String? url;
  String? session;
  String? number;
  String? text;
  SendText({
    this.url,
    this.session,
    this.number,
    this.text,
  });

  SendText copyWith({
    String? sessionkey,
    String? session,
    String? number,
    String? text,
  }) {
    return SendText(
      url: sessionkey ?? this.url,
      session: session ?? this.session,
      number: number ?? this.number,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionkey': url,
      'session': session,
      'number': number,
      'text': text,
    };
  }

  factory SendText.fromMap(Map<String, dynamic> map) {
    return SendText(
      url: map['sessionkey'] != null ? map['sessionkey'] as String : null,
      session: map['session'] != null ? map['session'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendText.fromJson(String source) =>
      SendText.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SendText( session: $session, number: $number, text: $text)';
  }

  @override
  bool operator ==(covariant SendText other) {
    if (identical(this, other)) return true;

    return other.session == session &&
        other.number == number &&
        other.text == text;
  }

  @override
  int get hashCode {
    return session.hashCode ^ number.hashCode ^ text.hashCode;
  }
}
