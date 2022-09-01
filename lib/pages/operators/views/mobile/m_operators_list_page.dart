import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class MOperatorsListPage extends StatefulWidget {
  const MOperatorsListPage({Key? key}) : super(key: key);

  @override
  State<MOperatorsListPage> createState() => _MOperatorsListPageState();
}

class _MOperatorsListPageState extends State<MOperatorsListPage> {
  List<Operator> _operators = <Operator>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Operators'.translate()),
      body: BlocListener<OperatorBloc, OperatorState>(
        listener: (context, state) {
          if (state.status == FetchOperatorsStatus.initial) {
            _operators = (context.read<OperatorBloc>()
              ..add(const FetchOperatorData())) as List<Operator>;
          }
          if (state.status == FetchOperatorsStatus.loading) {
            // AppLoader(context).show(title: 'loading');
          }
          if (state.status == FetchOperatorsStatus.success) {
            // AppLoader(context).hide();
          }
          // TODO: implement listener
        },
        child: BlocBuilder<OperatorBloc, OperatorState>(
          builder: (context, state) {
            if (state.status == FetchOperatorsStatus.success) {
              _operators = state.operators ?? <Operator>[];
            }
            if (state.status == FetchOperatorsStatus.loading) {
              //TODO:// Here need to load the loader when the request goes to API
            }
            if (_operators.isEmpty) {
              return Center(
                child: Text("noDataFound".translate()),
              );
            }

            return ListView.builder(
              itemCount: _operators.length,
              itemBuilder: (BuildContext context, int index) {
                Operator _operator = _operators[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      "$index ${_operator.customerName} ${_operator.aircraftId}",
                    ),
                    subtitle: Text(
                      _operator.customerId.toString(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
