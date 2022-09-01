part of 'person_bloc.dart';

class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class FetchPersonDetailEvent extends PersonEvent {
  final String? guid;
  final bool isPassenger;
  const FetchPersonDetailEvent({this.guid, required this.isPassenger});

  @override
  List<Object> get props => [];
}

class UploadPassportEvent extends PersonEvent {
  final List<Object> filesToUpload;
  final UploadDoc documentDetails;

  const UploadPassportEvent(this.filesToUpload, this.documentDetails);
}

class UploadVisaEvent extends PersonEvent {
  final List<Object> filesToUpload;
  final UploadDoc documentDetails;

  const UploadVisaEvent(this.filesToUpload, this.documentDetails);
}

class UpdateCustomerDataEvent extends PersonEvent {
  final Object formData;
  final int customerId;
  final String guid;
  final bool isPassenger;

  const UpdateCustomerDataEvent(
      {required this.formData,
      required this.customerId,
      required this.guid,
      required this.isPassenger});
}

class UpdateBirthCity extends PersonEvent {
  final String country;

  const UpdateBirthCity(this.country);
}

class UpdateAddressCity extends PersonEvent {
  final String country;

  const UpdateAddressCity(this.country);
}
