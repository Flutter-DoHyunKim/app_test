import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/main.dart';

///앱의 개별요소가 전체적으로 연동되는 방식을 테스트할때 사용 flutter_diver를 사용하여 기기에서 테스트 구동
///
void main(){
  group('앱 자체를 테스트합니다', () {
    testWidgets('Favorite operation을 테스트합니다', (widgetTester) async {
      await widgetTester.pumpWidget(const TestingApp());
      final iconKeys=[
        'icon_0',
        'icon_1',
        'icon_2',
      ];
      for(var icon in iconKeys){
        await widgetTester.tap(find.byKey(ValueKey(icon)));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Added to favorites.'),findsOneWidget);
      }
      await widgetTester.tap(find.text('Favorites')); //favorites

      
      // screen 으로 이동
      await widgetTester.pumpAndSettle();

      final removeIconKeys = [
      'remove_icon_0',
      'remove_icon_1',
      'remove_icon_2',
      ];

      for (final iconKey in removeIconKeys) {
      await widgetTester.tap(find.byKey(ValueKey(iconKey)));
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });

  });

}