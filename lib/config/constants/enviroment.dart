import 'package:envied/envied.dart';

part 'enviroment.g.dart';

@Envied(path: '.env', useConstantCase: true) //, allowOptionalFields: true
abstract class Env {
  @EnviedField(varName: 'GEMINI_KEY', obfuscate: true)
  static final String geminiKey = _Env.geminiKey; //String?
}
