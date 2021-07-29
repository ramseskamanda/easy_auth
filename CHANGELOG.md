## 0.2.1

Removed unnecassary dependencies: cloud_firestore, firebase_auth, and another_flushbar

## 0.1.4

Formatted files with `dartfmt -w .`

## 0.1.3

Fix type references across the code base, thus allowing for more custom user types extends `EquatableUser`.

## 0.1.2

Fix missing event propagation when listening to `AuthenticationRepository.user` `Stream<T>`.

## 0.1.1

Moved `AuthenticationRepository.currentUser` to `EasyAuthBloc.currentUser`, not a breaking change, but fixes the unreliability of the previous architecture.

## 0.1.0

Initial version of the library.

Includes:

- Widgets for easy integration of an authentication service, like `AuthenticationBaseApp`
- Abstract classes like `AuthenticationRepository` and example implementations like `BasicFirebaseAuth`
- A plug-and-play mechanic for authentication providers, including some commonly used ones like `EmailPasswordAuth` and `GoogleAuth`
