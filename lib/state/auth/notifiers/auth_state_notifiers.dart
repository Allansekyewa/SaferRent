import 'package:riverpod/riverpod.dart';
import 'package:saferent/state/auth/backend/authenticator.dart';
import 'package:saferent/state/auth/modesls/auth_result.dart';
import 'package:saferent/state/auth/modesls/auth_state.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';
import 'package:saferent/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

  final _userinfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.successs,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }
  Future<void> logOut() async {
    state = state.copiedWithIsloading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsloading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.successs && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsloading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.successs && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  ///TODO apple login but still lack packages and apple certificates
  // Future<void> loginWithApple() async {
  //   state = state.copiedWithIsloading(true);
  // }
  // final result = await _authenticator.loginWithApple();
  // final userId=_authenticator.userId;
  // if(result==AuthResult.success && userId!=null){
  //   await saveUserInfo(userId:userId);
  // }
  // state=AuthState(result: result, isLoading: true, userId: _authenticator.userId);

  Future<void> saveUserInfo({required UserId userId}) =>
      _userinfoStorage.saveUserInfo(
          userId: userId,
          displayName: _authenticator.displayName,
          email: _authenticator.email);
}
