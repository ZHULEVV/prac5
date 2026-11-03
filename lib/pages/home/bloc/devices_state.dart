part of 'devices_bloc.dart';

@immutable
sealed class DevicesState {
  const DevicesState();
}

final class DevicesInitial extends DevicesState {
  const DevicesInitial();
}

final class DevicesLoading extends DevicesState {
  const DevicesLoading();
}

final class DevicesLoaded extends DevicesState {
  final List<DeviceItem> devices;
  const DevicesLoaded(this.devices);
}

final class DevicesError extends DevicesState {
  final String message;
  const DevicesError(this.message);
}
