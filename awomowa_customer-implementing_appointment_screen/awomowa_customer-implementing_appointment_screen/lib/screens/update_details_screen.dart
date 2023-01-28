import 'package:awomowa/model/UpdateDetailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateDetails extends StatefulWidget {
  final String broadCastId;

  const UpdateDetails({this.broadCastId});
  @override
  _UpdateDetailsState createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.broadCastId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UpdateDetailsProvider>(context, listen: false).getUpdateDetails(
      widget.broadCastId,
    );

    return Consumer<UpdateDetailsProvider>(
      builder: (BuildContext context,
          UpdateDetailsProvider updateDetailsProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(updateDetailsProvider.updateDetailsResponse == null
                ? ''
                : updateDetailsProvider
                    .updateDetailsResponse.offerStores[0].shopName),
          ),
          body: updateDetailsProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          updateDetailsProvider
                              .updateDetailsResponse.offerStores[0].imageUrl,
                          width: 200.0,
                          height: 200.0,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        //Text("Ganesh"),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Published On',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            updateDetailsProvider.updateDetailsResponse
                                .offerStores[0].publishedDate,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Divider(
                          height: 36.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            updateDetailsProvider
                                .updateDetailsResponse.offerStores[0].comments,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
