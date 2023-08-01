import 'package:test/test.dart';
import 'package:testing_app/models/favorites.dart';
void main(){
  group('App provider를 테스트합니다', (){
    var favorites=Favorites();
    test('새로운 아이템을 추가합니다', (){
      var num=35;
      favorites.add(num);
      expect(favorites.items.contains(num), true);
    });
    test('아이템을 삭제합니다', (){
      var num=35;
      favorites.add(num);
      expect(favorites.items.contains(num), true);
      favorites.remove(num);
      expect(favorites.items.contains(num), false);
    });
  });
}

//flutter test test/models/favorites_test.dart 명령어 입력시 테스트 된다
//flutter test 입력 시 test directory 의 모든 테스트 실행