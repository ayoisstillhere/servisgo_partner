import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:servisgo_partner/features/auth/domain/usecases/update_name_usecase.dart';
import 'package:servisgo_partner/features/auth/domain/usecases/update_phone_usecase.dart';
import 'package:servisgo_partner/features/home/domain/usecases/get_partners_usecase.dart';
import 'package:servisgo_partner/features/home/domain/usecases/update_status_usecase.dart';

import '../../../../auth/domain/entities/partner_entity.dart';

part 'partner_state.dart';

class PartnerCubit extends Cubit<PartnerState> {
  final GetPartnersUsecase getPartnersUsecase;
  final UpdateStatusUsecase updateStatusUsecase;
  final UpdateNameUsecase updateNameUsecase;
  final UpdatePhoneUsecase updatePhoneUsecase;
  PartnerCubit({
    required this.getPartnersUsecase,
    required this.updateStatusUsecase,
    required this.updateNameUsecase,
    required this.updatePhoneUsecase,
  }) : super(PartnerInitial());

  Future<void> getPartners() async {
    try {
      final partner = getPartnersUsecase.call();
      partner.listen((partners) {
        emit(PartnerLoaded(partners: partners));
      });
    } on SocketException catch (_) {}
  }

  Future<void> updateStatus(String status) async {
    try {
      await updateStatusUsecase.call(status);
    } on SocketException catch (_) {}
  }

  Future<void> updateName(String name) async {
    try {
      await updateNameUsecase.call(name);
    } on SocketException catch (_) {}
  } 

  Future<void> updatePhone(String phone) async {
    try {
      await updatePhoneUsecase.call(phone);
    } on SocketException catch (_) {}
  }
}
