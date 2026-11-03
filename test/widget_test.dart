import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prac5/main.dart';
import 'package:prac5/mock/devices_data.dart';
import 'package:prac5/pages/detail_page.dart';
import 'package:prac5/pages/home/bloc/devices_bloc.dart';
import 'package:prac5/pages/home/home_page.dart';
import 'package:prac5/routes.dart';

class TestDevicesBloc extends DevicesBloc {
  void show(DevicesState state) => emit(state);
}

void main() {
  test('Событие загрузки выдаёт loading и список устройств', () async {
    final bloc = DevicesBloc();
    addTearDown(bloc.close);
    expect(bloc.state, isA<DevicesInitial>());
    final result = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<DevicesLoading>(),
        isA<DevicesLoaded>().having(
          (state) => state.devices,
          'devices',
          devices,
        ),
      ]),
    );
    bloc.add(const LoadDevicesEvent());
    await result;
  });

  testWidgets('Начальное состояние, загрузка, ошибка и пустой список', (
    tester,
  ) async {
    final bloc = TestDevicesBloc();
    addTearDown(bloc.close);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DevicesBloc>.value(
          value: bloc,
          child: const HomePage(),
        ),
      ),
    );
    expect(find.text('Данные еще не загружены'), findsOneWidget);
    bloc.show(const DevicesLoading());
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    bloc.show(const DevicesError('Не удалось загрузить данные'));
    await tester.pump();
    expect(find.text('Не удалось загрузить данные'), findsOneWidget);
    bloc.show(const DevicesLoaded([]));
    await tester.pump();
    expect(find.text('Список пуст'), findsOneWidget);
  });

  for (final width in [390.0, 900.0]) {
    testWidgets('Загрузка и переход к устройству при ширине $width', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(900, 900);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pushReplacementNamed(Routes.home);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      tester.view.physicalSize = Size(width, 900);
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(devices.length));
      expect(
        find.byType(GridView),
        width > 600 ? findsOneWidget : findsNothing,
      );
      final card = find.widgetWithText(ListTile, devices.first.title);
      await tester.ensureVisible(card);
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(find.byType(DetailPage), findsOneWidget);
      expect(find.text(devices.first.description), findsOneWidget);
      navigator.pop();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
