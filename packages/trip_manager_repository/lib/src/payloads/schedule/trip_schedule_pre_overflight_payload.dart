class TripSchedulePreOverflightPayload {
  int? _overflightId;
  late String _countryName;
  late String _entryPoint;
  late String _exitPoint;
  late String _code;
  late int _sequenceNum;

  void setOverflightId(value) => _overflightId = value;
  void setCountryName(value) => _countryName = value;
  void setEntryPoint(value) => _entryPoint = value;
  void setExitPoint(value) => _exitPoint = value;
  void setCode(value) => _code = value;
  void setSequenceNum(value) => _sequenceNum = value;

  overflightId() => _overflightId;
  countryName() => _countryName;
  entryPoint() => _entryPoint;
  exitPoint() => _exitPoint;
  code() => _code;
  sequenceNum() => _sequenceNum;
}
