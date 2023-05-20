import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:servisgo_partner/features/auth/domain/usecases/update_partner_pfp_url_usecase.dart';
import 'package:servisgo_partner/features/profile/domain/usecases/upload_image_usecase.dart';

part 'partner_pfp_state.dart';

class PartnerPfpCubit extends Cubit<PartnerPfpState> {
  final UploadImageUsecase uploadImageUsecase;
  final UpdatePartnerPfpUrlUsecase updatePartnerPfpUrlUsecase;
  PartnerPfpCubit({
    required this.uploadImageUsecase,
    required this.updatePartnerPfpUrlUsecase,
  }) : super(PartnerPfpInitial());

  Future<String> uploadImage(Uint8List image) async {
    return await uploadImageUsecase.call(image);
  }

  Future<void> updatePartnerPfpUrl(String newPartnerPfpUrl) async {
    return await updatePartnerPfpUrlUsecase.call(newPartnerPfpUrl);
  }
}
