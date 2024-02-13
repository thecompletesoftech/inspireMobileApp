import '../Models/accountmodel/account_model.dart';

class TokenAccount {
  final String token;
  final Account account;

  TokenAccount({
    required this.token,
    required this.account,
  });
}

TokenAccount getTokenAccount(Map<String, dynamic> dataMap,
    {String mutationName = "loginAccount"}) {
  Map<String, dynamic>? accountMap =
      dataMap['data'][mutationName]['account'] as Map<String, dynamic>?;
  Account account = Account.fromJson(accountMap!).copyWith();
  TokenAccount tokenAccount = TokenAccount(
    token: "Bearer ${dataMap['data'][mutationName]['token'] as String}",
    account: account,
  );
  return tokenAccount;
}
