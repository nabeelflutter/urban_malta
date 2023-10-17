import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/serializable_model/OrderListResponse.dart';

class DataNotifier<T> extends ChangeNotifier {
  T? _data;

  T? get data => _data;

  void updateData(T newData) {
    if (_data != newData) {
      _data = newData;
      notifyListeners();
    }
  }
}

class FutureListener<T> extends StatelessWidget {
  final Future<List<OrderListResponse>> future;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      builder;
  final void Function(T newData)? onData;

  const FutureListener({
    required this.future,
    required this.builder,
    this.onData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderListResponse>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final newData = snapshot.data;
          if (newData != null) {
            if (onData != null) {
              onData!(newData as T);
            }
            return builder(context, snapshot as AsyncSnapshot<T>);
          } else {
            return Text('No data available');
          }
        }
      },
    );
  }
}
