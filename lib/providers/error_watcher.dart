import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

void handleError(WidgetRef ref, ProviderBase prov, BeamerDelegate b) {
  if(ref.read(prov).error != null){
    print("Refreshing provider cause it errored out before startup");
    ref.refresh(prov);
  }
  ref.listen(prov, (_, state) async {
    if (state.error != null && _.error == null) {
      if(state.error is TypeError) {
        print("Provider errored out: ${state.error}");
        return;
      }
      if((state.error as Map<String, dynamic>)["code"] == 401) {
        b.beamToNamed('/login');
      }
    }
  });
}
