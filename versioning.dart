import "dart:math";

import "package:http/http.dart" as http;
import "dart:convert";

void main() async {
  print(await fetchLatestVersion());
}

Future<String> fetchLatestVersion() async {
  var response = await http.get(
    Uri.parse("https://api.github.com/repos/mcmineyc/taxi_native/tags")
  );
  if(response.statusCode != 200){
    return Future.error("Failed to get version information");
  }
  var desponse = jsonDecode(response.body);
  RegExp version_exp = RegExp(r'^v([0-9]+.+)*');
  List versions = desponse.map((v) => (v["name"] ?? "") as String).where((v) => version_exp.hasMatch(v)).where((v) => v != "").toList();
  // List<String> versions = [];
  // for(int i = 1; i <= 10; i++){
  //   for(int ii = 1; ii <= 10; ii++){
  //     for(int iii = 1; iii <= 10; iii++){
  //       for(int iiii = 1; iiii <= 10; iiii++){
  //         versions.add("v${i}.${ii}.${iii}.${iiii}");
  //       }
  //     }
  //   }
  // }
  // versions.sort((_, __) => Random().nextBool() ? 1 : -1); // scramble for testing
  versions.sort((a, b) => compareSemver(a, b));
  return versions[0];
}

int compareSemver(String va, String vb) { // if va bigger than vb returns true
  int returnVal = 0;
  Iterable<int> vaPieces = va[0] == "v" ? va.substring(1).split(".").map((e) => int.parse(e)) : va.split(".").map((e) => int.parse(e));
  Iterable<int> vbPieces = va[0] == "v" ? vb.substring(1).split(".").map((e) => int.parse(e)) : vb.split(".").map((e) => int.parse(e));
  for(int i = 0; i < vaPieces.length; i++) {
    int val = vaPieces.elementAt(i);
    if(vbPieces.length > i){
      int valB = vbPieces.elementAt(i);
      if(valB > val){
        return 1;
      } else if (valB < val){
        return -1;
      }
    }
  }
  return 0;
}