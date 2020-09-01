import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskhanloapp/models/UserModel.dart';

class ScopModel extends Model {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _LoginProgress = false;

  bool get loginProgress => _LoginProgress;

  Future<Map<String, dynamic>> regUser(UserMod user) async {
    _isLoading = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      FirebaseUser result = ((await auth.createUserWithEmailAndPassword(
              email: user.email, password: user.pass))
          .user) as FirebaseUser;
//      FirebaseUser loginUser = result.user;
//    String uid = loginUser.uid;
      _isLoading = false;
      return {'success': true, 'message': 'Logged In Seccessful'};
    } catch (e) {
      return {'failure': true, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signinUser(UserMod user) async {
    _LoginProgress = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      FirebaseUser result = ((await auth.signInWithEmailAndPassword(
              email: user.email, password: user.pass))
          .user) as FirebaseUser;
//      FirebaseUser loginUser = result.user;
//    String uid = loginUser.uid;
      _LoginProgress = false;
      return {'success': true, 'message': 'Logged In Seccessful'};
    } catch (e) {
      return {'failure': true, 'message': e.toString()};
    }
  }
}
