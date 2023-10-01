import 'package:flutter_test/flutter_test.dart';
import 'package:mikolo_notes/services/auth/auth_user.dart';
import 'package:mikolo_notes/services/auth/auth_provider.dart';
import 'package:mikolo_notes/services/auth/auth_exceptions.dart';

void main() {
  // Group testing of our MockAuthProvider authProvider
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should Not Be Initialized To Begin With', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot Log Out If Not Initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Should Be Able To Initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'Should be able to initialized after 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('Create user should delegate to login function', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@gmail.com',
        password: 'mikemike',
      );
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = provider.createUser(
        email: 'somebody@gmail.com',
        password: 'foobar',
      );
      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));
      final AuthUser user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test('Logged in users should be able to get verified', () async {
      await provider.initialize(); // Ensure the provider is initialized

      // Log in or set the user to some non-null value
      await provider.logIn(
        email: 'email',
        password: 'password',
      );

      // Send email verification
      await provider.sendEmailVerification();

      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    // test('Logged in users should be able to get verified', () async {
    //    await provider.initialize();
    //   await provider.sendEmailVerification();
    //   final user = provider.currentUser;
    //   expect(user, isNotNull);
    //   expect(user!.isEmailVerified, true);
    // });

    test('Should be able to log out and log in again', () async {
      // Log out by setting the current user to null
      await provider.initialize();
      provider._user = null;

      // Log in again
      await provider.logIn(
        email: 'email',
        password: 'password',
      );

      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

// creating a class of notinitialized and mockauthprovider

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@gmail.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<AuthUser> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    _user = null;
    return logOut();
  }

  @override
  Future<AuthUser> sendEmailVerification() {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    _user = AuthUser(isEmailVerified: true);
    return Future.value(_user);
  }
}
