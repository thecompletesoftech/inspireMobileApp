import 'package:hasura_connect/hasura_connect.dart';
import 'api_constants.dart';
import 'get_token_account.dart';
import 'schemas/create_account.dart';

String url = ApiAppConstants.urlPublicAuthenticationCtx;

HasuraConnect hasuraConnect = HasuraConnect(url);

createAccount({
  required String email,
  required String password,
  required String name,
  required String surname,
  required String phoneNumber,
  required String address,
  required String zipcode,
  required String unitno,
  required String city,
}) async {
  Map<String, dynamic> variables = {
    "account": {"password": password, "email": email},
    "person": {"surname": surname, "name": name, "phoneNumber": phoneNumber},
    "location": {
      "address": "$address Unit: $unitno",
      "city": city,
      "zipcode": zipcode,
    }
  };

  Map<String, dynamic> dataMap =
      await hasuraConnect.mutation(createAccountSchema, variables: variables);
  TokenAccount tokenAccount =
      getTokenAccount(dataMap, mutationName: "createAccount");
  return tokenAccount;
}
