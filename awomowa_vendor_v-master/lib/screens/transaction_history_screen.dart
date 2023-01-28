import 'package:awomowa_vendor/providers/TransactionHistoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static const routeName = '/transactionHistory';
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<TransactionHistoryProvider>(context, listen: false)
            .getHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionHistoryProvider>(
      builder: (BuildContext context,
          TransactionHistoryProvider transactionHistoryProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Payment History'),
          ),
          body: transactionHistoryProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: transactionHistoryProvider
                      .transactionHistoryResponse.transactionHistory.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                        child: ListTile(
                      title: Text(transactionHistoryProvider
                          .transactionHistoryResponse
                          .transactionHistory[index]
                          .packageInforamtion
                          .packageName),
                      subtitle: Text(transactionHistoryProvider
                          .transactionHistoryResponse
                          .transactionHistory[index]
                          .subscribeStartDate),
                      trailing: Text(
                          '\$ ${transactionHistoryProvider.transactionHistoryResponse.transactionHistory[index].packageInforamtion.packageAmountwithTax}'),
                    ));
                  }),
        );
      },
    );
  }
}
