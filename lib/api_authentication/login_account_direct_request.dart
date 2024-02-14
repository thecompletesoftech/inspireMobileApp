import 'package:hasura_connect/hasura_connect.dart';
import 'package:public_housing/api_authentication/get_token_account.dart';
import 'api_constants.dart';
import 'schemas/login_account.dart';

String url = ApiAppConstants.urlPublicAuthenticationCtx;
HasuraConnect hasuraConnect = HasuraConnect(url);

loginAccount(
  String user,
  String password,
) async {
  Map<String, dynamic> variables = {"user": user, "password": password};

  Map<String, dynamic> dataMap =
      await hasuraConnect.mutation(loginAccountSchema, variables: variables);
  print("datamap" + dataMap.toString());
  TokenAccount tokenAccount = getTokenAccount(dataMap);
  return tokenAccount;
}
