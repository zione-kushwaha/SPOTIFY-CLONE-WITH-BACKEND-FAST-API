import 'package:day6/features/auth/model/user_model.dart';
import 'package:day6/features/auth/repositories/auth_local_repository.dart';
import 'package:day6/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
part 'auth_viewModel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.initSharedPreferences();
  }

  Future<void> signupUser(
      {required String name,
      required String email,
      required String password}) async {
    // call signupUser from AuthRemoteRepository

    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signupUser(
        name: name, email: email, password: password);

    final val = switch (res) {
      fpdart.Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      fpdart.Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    // call signupUser from AuthRemoteRepository

    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.loginUser(email, password);

    final val = switch (res) {
      fpdart.Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      fpdart.Right(value: final r) => _loginSuccess(r),
    };
    print(val);
  }

  _loginSuccess(UserModel userModel) {
    // save user to local storage
    state = AsyncValue.data(userModel);
    _authLocalRepository.setToken(userModel.token);
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if (token == null) {
      // TODO: handle this case

      return null;
    }
  }
}
