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
