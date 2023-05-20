import 'package:get_it/get_it.dart';
import 'features/auth/domain/usecases/update_name_usecase.dart';
import 'features/auth/domain/usecases/update_partner_pfp_url_usecase.dart';
import 'features/auth/domain/usecases/update_phone_usecase.dart';
import 'features/home/domain/usecases/get_partners_usecase.dart';
import 'features/home/domain/usecases/update_status_usecase.dart';
import 'features/home/presentation/bloc/partner_cubit/partner_cubit.dart';
import 'features/profile/data/datasources/firebase_storage_remote_datasource.dart';
import 'features/profile/domain/repositories/firebase_storage_repository.dart';
import 'features/profile/domain/usecases/upload_image_usecase.dart';
import 'features/profile/presentation/bloc/partner_pfp_cubit/partner_pfp_cubit.dart';

import 'features/auth/data/datasources/firebase_remote_datasource.dart';
import 'features/auth/data/repositories/firebase_repository_impl.dart';
import 'features/auth/domain/repositories/firebase_repository.dart';
import 'features/auth/domain/usecases/create_current_user_usecase.dart';
import 'features/auth/domain/usecases/get_current_uid_usecas.dart';
import 'features/auth/domain/usecases/google_signin_usecase.dart';
import 'features/auth/domain/usecases/google_signup_usecase.dart';
import 'features/auth/domain/usecases/is_signin_usecase.dart';
import 'features/auth/domain/usecases/reset_password_usecase.dart';
import 'features/auth/domain/usecases/set_phone_usecase.dart';
import 'features/auth/domain/usecases/set_service_class_usecase.dart';
import 'features/auth/domain/usecases/signin_usecase.dart';
import 'features/auth/domain/usecases/signout_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'features/auth/presentation/bloc/signin_cubit/signin_cubit.dart';
import 'features/profile/data/repositories/firebase_storage_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features bloc,
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(isSigninUsecase: sl.call(), getCurrentUidUsecase: sl.call()));
  sl.registerFactory<SigninCubit>(() => SigninCubit(
        signupUsecase: sl.call(),
        signinUsecase: sl.call(),
        createCurrentUserUsecase: sl.call(),
        signoutUsecase: sl.call(),
        googleSigninUsecase: sl.call(),
        googleSignupUsecase: sl.call(),
        setPhoneUsecase: sl.call(),
        resetPasswordUsecase: sl.call(),
        setServiceClassUsecase: sl.call(),
      ));
  sl.registerFactory<PartnerCubit>(() => PartnerCubit(
        getPartnersUsecase: sl.call(),
        updateStatusUsecase: sl.call(),
        updateNameUsecase: sl.call(),
        updatePhoneUsecase: sl.call(),
      ));
  sl.registerFactory<PartnerPfpCubit>(() => PartnerPfpCubit(
        updatePartnerPfpUrlUsecase: sl.call(),
        uploadImageUsecase: sl.call(),
      ));

  //!useCae
  sl.registerLazySingleton<IsSigninUsecase>(
      () => IsSigninUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUsecase>(
      () => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton<CreateCurrentUserUsecase>(
      () => CreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<SigninUsecase>(
      () => SigninUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignupUsecase>(
      () => SignupUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignoutUsecase>(
      () => SignoutUsecase(repository: sl.call()));
  sl.registerLazySingleton<GoogleSigninUsecase>(
      () => GoogleSigninUsecase(repository: sl.call()));
  sl.registerLazySingleton<GoogleSignupUsecase>(
      () => GoogleSignupUsecase(repository: sl.call()));
  sl.registerLazySingleton<SetPhoneUsecase>(
      () => SetPhoneUsecase(repository: sl.call()));
  sl.registerLazySingleton<SetServiceClassUsecase>(
      () => SetServiceClassUsecase(repository: sl.call()));
  sl.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetPartnersUsecase>(
      () => GetPartnersUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdateStatusUsecase>(
      () => UpdateStatusUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdateNameUsecase>(
      () => UpdateNameUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdatePhoneUsecase>(
      () => UpdatePhoneUsecase(repository: sl.call()));
  sl.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(firebaseStorageRepository: sl.call()));
  sl.registerLazySingleton<UpdatePartnerPfpUrlUsecase>(
      () => UpdatePartnerPfpUrlUsecase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDatasource: sl.call()));
  sl.registerLazySingleton<FirebaseStorageRepository>(() =>
      FirebaseStorageRepositoryImpl(
          firebaseStorageRemoteDatasource: sl.call()));

  //datasource
  sl.registerLazySingleton<FirebaseRemoteDatasource>(
      () => FirebaseRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseStorageRemoteDatasource>(
      () => FirebaseStorageRemoteDataSourceImpl());

  //external
  //e.g final shared Preference = await SharedPreferences.getInstance();
}
