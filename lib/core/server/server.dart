import 'package:appwrite/appwrite.dart';
import '../../config/constants/constants.dart';

class AppServer {
  static final client = Client()
    ..setEndpoint(AppWriteConstants.endpoint)
    ..setProject(AppWriteConstants.projectId)
    ..setSelfSigned(status: true);
  static final account = Account(client);
  static final databases = Databases(client);
}
