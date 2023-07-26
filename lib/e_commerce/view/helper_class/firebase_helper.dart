// import 'package:cloud_firestore/src/collection_reference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/e_commerce/view/add_product_screen/model/product_model.dart';
import 'package:e_commerce_firebase/e_commerce/view/helper_class/notification_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> guestSignIn() async {
    try {
      await auth.signInAnonymously();
      return "SignIn Successfully";
    } catch (e) {
      return "$e";
    }
  }

  bool checkUser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<String> signInEmail(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "SignIn Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Future<String> signUpEmail(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "SignUp Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Future<UserCredential> signInGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "SignOut Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Map<String, String?> userDetails() {
    User? user = auth.currentUser;

    return {
      "name": user!.displayName,
      "email": user.email,
      "phone": user.phoneNumber,
      "photo": user.photoURL,
    };
  }

  //=================================data base===============================//

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void insertData(ProductModel model) {
    firestore.collection("products").add({
      "name": model.name,
      "image": model.img,
      "price": model.price,
      "description": model.desc,
      "category": model.cate,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> selectData() {
    return firestore.collection("products").snapshots();
  }

  void deleteData(id) {
    firestore.collection("products").doc("$id").delete();
  }

  void updateData(ProductModel model) {
    firestore.collection("products").doc("${model.id}").set({
      "name": model.name,
      "price": model.price,
      "category": model.cate,
      "description": model.desc,
      "image": model.img,
    });
  }

  //======================= firebase notification ===================

  Future<void> initFirebaseNotification() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message != null) {
          var title = message.notification!.title;
          var body = message.notification!.body;

          NotificationHelper.helper.showFireSimpleNotification(title, body);
        }
      },
    );


  }
}
