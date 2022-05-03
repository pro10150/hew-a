import 'dart:convert';

import 'package:http/http.dart' as http;

String pathAddress = "https://hew-a.herokuapp.com/"; //ปอเอง

// class HewaAPI {
//   query(String table,
//       {bool? distinct,
//       List<String>? columns,
//       String? where,
//       List<Object?>? whereArgs,
//       String? groupBy,
//       String? having,
//       String? orderBy,
//       int? limit,
//       int? offset}) {
//     if (groupBy == null && having != null) {
//       throw ArgumentError(
//           'HAVING clauses are only permitted when using a groupBy clause');
//     }
//     checkWhereArgs(whereArgs);

//     final query = StringBuffer();

//     query.write('SELECT ');
//     if (distinct == true) {
//       query.write('DISTINCT ');
//     }
//     if (columns != null && columns.isNotEmpty) {
//       _writeColumns(query, columns);
//     } else {
//       query.write('* ');
//     }
//     query.write('FROM ');
//     query.write(_escapeName(table));
//     _writeClause(query, ' WHERE ', where);
//     _writeClause(query, ' GROUP BY ', groupBy);
//     _writeClause(query, ' HAVING ', having);
//     _writeClause(query, ' ORDER BY ', orderBy);
//     if (limit != null) {
//       _writeClause(query, ' LIMIT ', limit.toString());
//     }
//     if (offset != null) {
//       _writeClause(query, ' OFFSET ', offset.toString());
//     }

//     sql = query.toString();
//     arguments = whereArgs != null ? List<Object?>.from(whereArgs) : null;
//   }

//   rawQuery(String query) async {
//     var maps = [];

//     var response = await http.get(Uri.parse(pathAddress + query));
//     if (response.statusCode == 200) {
//       print(jsonDecode(response.body));
//       maps = jsonDecode(response.body);
//     }

//     return maps;
//   }
// }
