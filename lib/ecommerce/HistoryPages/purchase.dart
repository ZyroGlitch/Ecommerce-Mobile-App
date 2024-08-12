import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../No_DirectToPage_FetchData/fetchData.dart';
import 'historyDatabase.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  var columnStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue);
  var rowStyle = TextStyle(fontSize: 16);

  String? getUserID;
  Stream? PendingStream;

  Future<void> getontheload() async {
    PendingStream = await FetchHistoryDB().getPendingDetails(getUserID!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userIDProvider =
          Provider.of<UserIDProvider>(context, listen: false);
      setState(() {
        getUserID = userIDProvider.userID;
      });
      getontheload();
    });
  }

  Widget TableContent() {
    return StreamBuilder(
      stream: PendingStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          final data = snapshot.data.docs;
          return PaginatedDataTable(
            columns: [
              DataColumn(label: Text('Product ID', style: columnStyle)),
              DataColumn(label: Text('Product', style: columnStyle)),
              DataColumn(label: Text('Size', style: columnStyle)),
              DataColumn(label: Text('Price', style: columnStyle)),
              DataColumn(label: Text('Quantity', style: columnStyle)),
              DataColumn(label: Text('Subtotal', style: columnStyle)),
              DataColumn(label: Text('Status', style: columnStyle)),
            ],
            source: _DataSource(data, context),
            rowsPerPage: 12, // Number of rows per page
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the User ID by using provider in fetchData.dart
    final userIDProvider = Provider.of<UserIDProvider>(context);
    getUserID = userIDProvider.userID;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        title: Text(
          'Purchase History',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: TableContent(),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<DocumentSnapshot> data;
  final BuildContext context;

  _DataSource(this.data, this.context);

  @override
  DataRow getRow(int index) {
    final ds = data[index];
    var rowStyle = TextStyle(fontSize: 18);
    return DataRow(
      cells: [
        DataCell(Center(
          child: Text(
            ds['purchaseID'] ?? 'N/A',
            style: rowStyle,
          ),
        )),
        DataCell(Center(
          child: Text(
            ds['itemName'] ?? 'N/A',
            style: rowStyle,
          ),
        )),
        DataCell(Center(
          child: Text(
            ds['size'] ?? 'N/A',
            style: rowStyle,
          ),
        )),
        DataCell(Center(
          child: Text(
            '₱${ds['itemPrice']?.toString()}' ?? 'N/A',
            style: rowStyle,
          ),
        )),
        DataCell(Center(
          child: Text(
            ds['quantity']?.toString() ?? '0',
            style: rowStyle,
          ),
        )),
        DataCell(Center(
          child: Text(
            '₱${(ds['itemPrice'] * ds['quantity']).toString()}' ?? 'N/A',
            style: rowStyle,
          ),
        )),
        DataCell(Center(
          child: Text(
            'Complete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  void setSelectedRowCount(int count) {}
}
