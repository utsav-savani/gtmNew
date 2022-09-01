class ScheduleView {
  final String pairName;
  final String eventIn;
  final String eventOut;
  final String parentPairName;

  const ScheduleView(
    this.eventIn,
    this.eventOut,
    this.pairName,
    this.parentPairName,
  );
}
