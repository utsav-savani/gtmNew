import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/_shared/selectors/m_country_selector.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MAddOverflightWidget extends StatefulWidget {
  final TripManagerScheduleRepository tripManagerScheduleRepository;
  final TripSchedulePrePayload tripSchedulePrePayload;
  final TripSchedulePreOverflightPayload? overflightPayload;
  final int index;
  final Function overflightSaveHandler;
  const MAddOverflightWidget({
    Key? key,
    required this.tripManagerScheduleRepository,
    required this.tripSchedulePrePayload,
    required this.index,
    required this.overflightSaveHandler,
    this.overflightPayload,
  }) : super(key: key);

  @override
  State<MAddOverflightWidget> createState() => _MAddOverflightWidgetState();
}

class _MAddOverflightWidgetState extends State<MAddOverflightWidget> {
  TripSchedulePreOverflightPayload _overflightPayload =
      TripSchedulePreOverflightPayload();
  late TripManagerScheduleRepository _tripManagerScheduleRepository;
  int? _overflightId;
  late TripSchedulePrePayload _tripSchedulePrePayload;
  String? _countryName;
  String? _countryCode;
  int _sequenceNumber = 0;

  final TextEditingController _entryPointTextController =
      TextEditingController();
  final TextEditingController _exitPointTextController =
      TextEditingController();

  @override
  void initState() {
    _tripManagerScheduleRepository = widget.tripManagerScheduleRepository;
    _tripSchedulePrePayload = widget.tripSchedulePrePayload;
    if (widget.overflightPayload != null) {
      _overflightPayload = widget.overflightPayload!;
      _overflightId = _overflightPayload.overflightId();
      _countryName = _overflightPayload.countryName();
      _countryCode = _overflightPayload.code();
      _entryPointTextController.text =
          _overflightPayload.entryPoint().toString().toUpperCase();
      _exitPointTextController.text =
          _overflightPayload.exitPoint().toString().toUpperCase();
      _sequenceNumber = _overflightPayload.sequenceNum();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: label(
          "Add Overflight",
          color: AppColors.defaultColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          InkWell(
            onTap: () => _saveOverflight(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              child: label("Add"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildCountryDropdown(),
              height(8),
              Row(
                children: [
                  Expanded(child: _buildEntryPointTextField()),
                ],
              ),
              height(12),
              Row(
                children: [
                  Expanded(child: _buildExitPointTextField()),
                ],
              ),
              height(24),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: label("Cancel", color: AppColors.redColor),
              ),
              height(8),
            ],
          ),
        ),
      ),
    );
  }

  void _saveOverflight() async {
    if (_overflightId == null) {
      _sequenceNumber = _tripSchedulePrePayload.overflights().length + 1;
    }
    _overflightPayload.setCode(_countryCode);
    _overflightPayload.setCountryName(_countryName);
    _overflightPayload.setEntryPoint(_entryPointTextController.text);
    _overflightPayload.setExitPoint(_exitPointTextController.text);
    _overflightPayload.setOverflightId(_overflightId);
    _overflightPayload.setSequenceNum(_sequenceNumber);
    if (_overflightId != null) {
      _tripManagerScheduleRepository.updateOverFlight(
        index: widget.index,
        payload: _overflightPayload,
        overflightId: _overflightId!,
      );
    } else {
      _tripManagerScheduleRepository.addOverFlight(
        index: widget.index,
        payload: _overflightPayload,
      );
    }
    widget.overflightSaveHandler();
  }

  Widget _buildCountryDropdown() {
    return InkWell(
      onTap: () => _openCountrySelector(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.powderBlue),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: spacing64,
                child: label("Country"),
              ),
              Expanded(
                child: Text(
                  _countryName ?? "",
                  style: const TextStyle(
                    fontSize: spacing13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.powderBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCountrySelector() async {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: MCountrySelector(
            countrySelectHandler: (Country country) async {
              _countryName = country.name;
              _countryCode = country.code;
              setState(() {});
            },
          ),
        );
      },
    );
  }

  Widget _buildEntryPointTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.powderBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: spacing68,
              child: label("Entry Point"),
            ),
            Expanded(
              child: TextFormField(
                controller: _entryPointTextController,
                maxLength: 5,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: "Enter Entry Point",
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExitPointTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.powderBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: spacing64,
              child: label("Exit Point"),
            ),
            Expanded(
              child: TextFormField(
                controller: _exitPointTextController,
                maxLength: 5,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: "Enter Exit Point",
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
