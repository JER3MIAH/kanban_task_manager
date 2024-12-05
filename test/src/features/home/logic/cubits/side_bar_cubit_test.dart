import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';

void main() {
  late SideBarCubit sideBarCubit;

  setUp(() {
    sideBarCubit = SideBarCubit();
  });

  tearDown(() {
    sideBarCubit.close();
  });

  group(
    'SideBar Cubit',
    () {
      blocTest(
        'emits true with when [showSideBar] function is called',
        build: () => sideBarCubit,
        act: (bloc) => bloc.showSideBar(),
        expect: () => [true],
      );

      blocTest(
        'emits false with when [hideSideBar] function is called',
        build: () => sideBarCubit,
        act: (bloc) => bloc.hideSideBar(),
        expect: () => [false],
      );
    },
  );
}
