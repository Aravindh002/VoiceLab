import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  Future<void> init() async {
    _localStream = await navigator.mediaDevices.getUserMedia({'audio': true, 'video': false});
    _peerConnection = await createPeerConnection({'iceServers': []});
    for (final track in _localStream!.getAudioTracks()) {
      await _peerConnection?.addTrack(track, _localStream!);
    }
  }

  Future<void> dispose() async {
    await _localStream?.dispose();
    await _peerConnection?.close();
  }
}
