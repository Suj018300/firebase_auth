import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // sign up user
    signUpUser ( {
        required String email,
        required String password,
        required String username,
        required Uint8List file,
    } ) async {
        String res = "Some error occurred";

        try {
          if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && file != null) {
            UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  
            String photoURL = await StorageMethods().uploadImageToStorage('Profile_pic', file, cred.user!.uid);

            if (file.isEmpty) {
  return "Selected image is empty or invalid.";
}
  
            // add user to our database
            await _firestore.collection('users').doc(cred.user!.uid).set({
              'username': username,
              'uid': cred.user!.uid,
              'email': email,
              'followers': [],
              'followings': [],
              'photoURL': photoURL,
            });

            res = 'Success';
          }
        } catch(err) {
            res = err.toString();
        }
        return res;
    }

  // login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter all the field';
      }
    } 
    catch(err){
      res = err.toString();
    }
    return res;
  }
}
