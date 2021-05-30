library easy_auth;

export 'src/app.dart' show AuthenticationBasedApp;
export 'src/builder.dart' show EasyAuthBuilder;
export 'src/instance.dart' show EasyAuth;

export 'src/models/abstract_user.dart' show EquatableUser;
export 'src/repositories/abstract_auth.dart' show AuthenticationRepository;
export 'src/repositories/basic_firebase_auth.dart' show BasicFirebaseAuth;
export 'src/utils/exception.dart' show AuthException;
export 'src/utils/provider.dart';
export 'src/utils/status.dart' show AuthStatus;
//TODO: finish writing the README
//TODO: change the README icons and add a title