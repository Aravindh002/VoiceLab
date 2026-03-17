import 'package:cloud_firestore/cloud_firestore.dart';

class SignalingService {
  SignalingService(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> sendOffer(String callId, Map<String, dynamic> payload) {
    return _firestore.collection('signals').doc(callId).set(payload);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchSignal(String callId) {
    return _firestore.collection('signals').doc(callId).snapshots();
  }
}
