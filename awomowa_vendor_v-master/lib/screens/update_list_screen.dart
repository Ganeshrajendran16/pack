import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/UpdateListProvider.dart';
import 'package:awomowa_vendor/reponse_models/update_list_response.dart';
import 'package:awomowa_vendor/screens/update_dialog.dart';
import 'package:awomowa_vendor/widgets/empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatesListScreen extends StatefulWidget {
  static const routeName = '/UpdateListScreen';
  @override
  _UpdatesListScreenState createState() => _UpdatesListScreenState();
}

class _UpdatesListScreenState extends State<UpdatesListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UpdateListProvider>(context, listen: false).getUpdates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateListProvider>(builder: (BuildContext context,
        UpdateListProvider subscriptionInfoProvider, Widget child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Updates'),
        ),
        backgroundColor: Provider.of<DarkThemeProvider>(context).darkTheme
            ? null
            : Colors.grey.shade200,
        body: subscriptionInfoProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : subscriptionInfoProvider.isEmpty
                ? Center(
                    child: EmptyState(
                    title: 'No Updates Published',
                    subtitle: 'Publish new updates to view here',
                  ))
                : ListView.builder(
                    itemCount:
                        subscriptionInfoProvider.updatesListResponse == null
                            ? 0
                            : subscriptionInfoProvider
                                .updatesListResponse.histories.length,
                    itemBuilder: (ctx, index) {
                      return UpdateItem(
                          update: subscriptionInfoProvider
                              .updatesListResponse.histories[index]);
                    }),
      );
    });
  }
}

class UpdateItem extends StatelessWidget {
  final Histories update;

  const UpdateItem({this.update});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateDialog(update: update);
          },
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.yellow,
                  backgroundImage: NetworkImage(update.imageUrl),
                ),
                trailing: Column(
                  children: [
                    Text(
                      'Published On',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    Text(update.createdAt),
                  ],
                ),
                title: Text(
                  update.comments,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
