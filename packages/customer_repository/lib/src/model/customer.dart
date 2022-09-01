import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Customer extends Equatable {
  /*      final int         customerId ;
         final String        customerName ;
        final List<>        Organization ;
                    name ;
                },
                CustomerHasAircraft ;
                    customerId ;
                    aircraftId ;


 */

  @override
  List<Object?> get props => [];
}
