class CallHistoryItem {
  const CallHistoryItem({
    required this.number,
    required this.duration,
    required this.effectName,
    required this.time,
  });

  final String number;
  final Duration duration;
  final String effectName;
  final DateTime time;
}
