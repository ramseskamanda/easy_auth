///AuthStatus represents the current state of the authentication
enum AuthStatus {
  ///AuthStatus.uninitialized
  uninitialized,

  ///AuthStatus.authenticated
  authenticated,

  ///AuthStatus.authenticating
  authenticating,

  ///AuthStatus.unauthenticated
  unauthenticated,

  ///AuthStatus.newAccount
  newAccount,
}
