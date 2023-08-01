import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_app/main.dart';
///flutter driver를 이용하여 앱의 성능을 테스트
void main() {
  group('앱 성능을 테스트 합니다', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized(); //통합 테스트 드라이버가 초기화 되고 필요시 드라이버를 다시 초기화 하는지 확인
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive; //애니메이션 코드를 테스트하기에 좋다

    testWidgets('스크롤을 테스트합니다. 가장 아래로 내렸다가 위로 올립니다', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final listFinder = find.byType(ListView);

      await binding.traceAction(() async { //작업을 기록하고 타임라인 요약을 생성
        await tester.fling(listFinder, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(listFinder, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');
    });
  });
}