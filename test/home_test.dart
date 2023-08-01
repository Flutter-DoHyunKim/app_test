import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/home.dart';
Widget createHomeScreen() => ChangeNotifierProvider<Favorites>( //createHomeScreen 위제 생성
  create: (context) => Favorites(),
  child: const MaterialApp(
    home:  HomePage(),
  ),
);
void main(){
  group('HomePage 위젯을 테스트합니다.', (){
    // BEGINNING OF NEW CONTENT
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    // END OF NEW CONTENT


    testWidgets('Scrolling을 테스트합니다', (widgetTester)async{
      await widgetTester.pumpWidget(createHomeScreen()); //테스트 위젯을 생성하고 렌더링하는데 사용되는 pumpWidget
      expect(find.text('Item 0'),findsOneWidget); //1개가 있는지 찾는다
      await widgetTester.fling(find.byType(ListView),  Offset(0,-200), 3000);
      await widgetTester.pumpAndSettle();
      expect(find.text('Item 0'),findsNothing);
    });
    testWidgets('Testing IconButtons', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.favorite), findsNothing);
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(const Duration(seconds: 1)); //테스트에서 비동기 작업이 완료될 때까지 대기하는 데 사용.
      expect(find.text('Added to favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}