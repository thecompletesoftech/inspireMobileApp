import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'account_model.g.dart';
part 'account_model.freezed.dart';

@freezed
class Account with _$Account {
  // userName
  // email
  // isVerified
  // isActive
  // isSoftDeleted
  // created
  // edited
  const factory Account(
      {required String id,
      required String userName,
      required String email,
      required bool isVerified,
      required bool isActive,
      required bool isSoftDeleted,
      required int created,
      required int? edited}) = _Account;

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}
