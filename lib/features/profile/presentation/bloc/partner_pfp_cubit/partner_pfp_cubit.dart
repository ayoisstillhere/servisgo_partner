import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/domain/usecases/update_partner_pfp_url_usecase.dart';
import '../../../domain/usecases/upload_image_usecase.dart';

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
