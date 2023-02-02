// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Country {
  final String name;
  final String flag;
  final String code;
  final String dialCode;
  final int minLength;
  final int maxLength;

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.minLength,
    required this.maxLength,
  });

  Country copyWith({
    String? name,
    String? flag,
    String? code,
    String? dialCode,
    int? minLength,
    int? maxLength,
  }) {
    return Country(
      name: name ?? this.name,
      flag: flag ?? this.flag,
      code: code ?? this.code,
      dialCode: dialCode ?? this.dialCode,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'flag': flag,
      'code': code,
      'dialCode': dialCode,
      'minLength': minLength,
      'maxLength': maxLength,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] as String,
      flag: map['flag'] as String,
      code: map['code'] as String,
      dialCode: map['dialCode'] as String,
      minLength: map['minLength'] as int,
      maxLength: map['maxLength'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Country(name: $name, flag: $flag, code: $code, dialCode: $dialCode, minLength: $minLength, maxLength: $maxLength)';
  }

  @override
  bool operator ==(covariant Country other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.flag == flag &&
        other.code == code &&
        other.dialCode == dialCode &&
        other.minLength == minLength &&
        other.maxLength == maxLength;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        flag.hashCode ^
        code.hashCode ^
        dialCode.hashCode ^
        minLength.hashCode ^
        maxLength.hashCode;
  }
}
