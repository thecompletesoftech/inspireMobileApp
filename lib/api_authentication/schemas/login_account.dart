String loginAccountSchema = """
  mutation loginInput( \$user: String!, \$password: String!) {
  loginAccount(user: \$user, password: \$password) {
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
