import 'package:flutter/material.dart';
import 'package:wakeamole/Utils/AppColors.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.MAIN),
        title: Text(
          "Rankings",
          style: TextStyle(color: AppColors.MAIN),
        ),
      ),
      body: DataTableTheme(
        data: DataTableThemeData(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: AppColors.ACCENT),
        ),
        child: DataTable(
          rows: [
            DataRow(
              cells: [
                DataCell(Text("1")),
                DataCell(Text("Shihab Uddin")),
                DataCell(Text("100")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("2")),
                DataCell(Text("Shahed Oali Noor")),
                DataCell(Text("94")),
              ],
            ),
          ],
          columns: [
            DataColumn(label: Text('Rank'), numeric: true),
            DataColumn(label: Text('Username'), numeric: false),
            DataColumn(label: Text('Score'), numeric: true),
          ],
        ),
      ),
    );
  }
}
