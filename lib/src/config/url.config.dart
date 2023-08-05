import '../db/isar.dart';
import 'get.platform.dart';

String get httpProtocol => appSettings.useSecureProtocol ? 'https' : 'http';
String get baseUrl => '$httpProtocol://${appSettings.baseUrl}/';

const globalBaseUrl = 'xvwvcxyfjqivzajzrzjm.supabase.co';
const devBaseUrl = '103.113.227.244:4200';
final localBaseUrl = pt.isNotAndroid ? '127.0.0.1:3000' : '10.0.2.2:3000';
