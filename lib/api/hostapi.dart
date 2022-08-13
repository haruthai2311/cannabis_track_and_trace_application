import 'package:flutter_dotenv/flutter_dotenv.dart';

String hostAPI = dotenv.get('API_HOST', fallback: null);