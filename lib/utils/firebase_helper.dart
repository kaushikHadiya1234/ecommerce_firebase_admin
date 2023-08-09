import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/Model/product_model.dart';
import 'package:ecommerce_firebase/utils/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper helper = FirebaseHelper();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> SignInGuest() async {
    try {
      await auth.signInAnonymously();
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  bool checkuser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<String> logOut() async {
    try {
      await auth.signOut();
      GoogleSignIn().signOut();
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await auth.signInWithCredential(credential);
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

 Map<String, String?> userDetaile()
 {
   User? user = auth.currentUser;

   return {
     'photo':user!.photoURL,
     'name':user.displayName,
     'email':user.email,
     'phone':user.phoneNumber,
   };
 }
//==============================Firestore Database===============

FirebaseFirestore firestore =FirebaseFirestore.instance;

 void insert(ProductModel model)
 {
   firestore.collection("Product").add({
     "name":model.name,
     "price":model.price,
     "category":model.cate,
     "image":model.img,
     "desc":model.desc,
   });
 }

 Stream<QuerySnapshot<Map<String, dynamic>>> readProductData()
 {
   return firestore.collection("Product").snapshots();
 }

 void deleteData(String id)
 {
   print(id);
    firestore.collection('Product').doc("$id").delete();
 }

 void updateData(ProductModel model)
 {
   firestore.collection('Product').doc(model.id).set(
     {
       "name":model.name,
       "price":model.price,
       "category":model.cate,
       "image":model.img,
       "desc":model.desc,
     }
   );
 }

 Future<void> fireNotification()
 async {
   final fcmToken = await FirebaseMessaging.instance.getToken();
   print(fcmToken);
   FirebaseMessaging.onMessage.listen((msg) {
     if(msg.notification!=null)
       {
         var title = msg.notification!.title;
         var body = msg.notification!.body;
         NotificationHelper.notificationHelper.fireSimpleNotification(title, body);
       }
   });

 }

}
