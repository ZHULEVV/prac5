import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mock/devices_data.dart';
import '../../../models/device_item.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(const DevicesInitial()) {
    on<LoadDevicesEvent>(_onLoadDevices);
  }

  Future<void> _onLoadDevices(
    LoadDevicesEvent event,
    Emitter<DevicesState> emit,
  ) async {
    emit(const DevicesLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(DevicesLoaded(devices));
    } catch (e) {
      emit(const DevicesError('Не удалось загрузить данные'));
    }
  }
}
