part of 'devices_bloc.dart';

@immutable
sealed class DevicesEvent {
  const DevicesEvent();
}

final class LoadDevicesEvent extends DevicesEvent {
  const LoadDevicesEvent();
}
