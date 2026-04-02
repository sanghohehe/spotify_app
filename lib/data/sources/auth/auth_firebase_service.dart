import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taxi_app/data/model/auth/create_user_req.dart';
import 'package:taxi_app/data/model/auth/sigin_user_req.dart';
import 'package:taxi_app/data/model/auth/user.dart';
import 'package:taxi_app/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUsserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );
      return Right('SignIn was success');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'Invalid-email') {
        message = 'Not user found for that email';
      } else if (e.code == 'Invalid-credential') {
        message = 'Wrong password provided for that user';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUsserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUsserReq.email,
        password: createUsserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUsserReq.fullName,
        'email': data.user?.email,
      });
      return Right('Signup was success');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provide is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exits with that email.';
      }

      return Left(message);
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var userDoc =
          await firebaseFirestore
              .collection('Users')
              .doc(firebaseAuth.currentUser?.uid)
              .get();

      if (userDoc.data() == null) {
        return Left('User data is null');
      }

      UserModel userModel = UserModel.fromJson(userDoc.data()!);

      userModel.imageUrl = firebaseAuth.currentUser?.photoURL;

      return Right(userModel.toEntity());
    } catch (e) {
      print("GET USER ERROR: $e");
      return Left('An error occurred while fetching user data');
    }
  }
}
