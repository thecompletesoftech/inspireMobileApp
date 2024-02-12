String createAccountSchema = """
mutation createAccountInput(\$account: CreateAccountInput!, \$person: CreatePersonInput!, \$location: CreateLocationInput!) {
  createAccount(account: \$account, person: \$person, location: \$location) {
    token
    account {
      id
      userName
      email
      isActive
      isSoftDeleted
      isVerified
      created
      edited
    }
  }
}
""";
