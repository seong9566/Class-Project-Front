import 'package:logger/logger.dart';

import '../service/local_service.dart';
import '../dto/response/user_resp_dto.dart';

// main 시작전에 확인이 필요해서 provider가 아닌 static으로 관리
class UserSession {
  static UserRespDto? user;
  static String? jwtToken;
  static bool isLogin = false;

  static void login(UserRespDto userParam, String jwtTokenParam) {
    user = userParam;
    jwtToken = jwtTokenParam;
    isLogin = true;
  }

  static Future<void> logout() async {
    user = null;
    jwtToken = null;
    isLogin = false;

    await LocalService().removeShardJwtToken();
    Logger().d("세션 종료 및 디바이스 토큰 삭제");
  }

  static Map<String, String> getTokenHeader(Map<String, String> headers) {
    // 토큰 값이 null이면 토큰 값 추가, ...header => 깊은 복사
    return UserSession.jwtToken == null ? headers : {...headers, "Authorization": UserSession.jwtToken!};
  }
}