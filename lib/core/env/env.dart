import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'DEV_API_URL')
  static final String devApiUrl = _Env.devApiUrl;
}
