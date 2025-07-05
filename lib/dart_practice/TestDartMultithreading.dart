

void main(){

  // Phone is running - Main UI thread
  print("---------- 1 HIT SERVER FROM PHONE MAIN THREAD -----------");
  hitNetworkApi();
  print("---------- 2 PHONE MAIN THREAD TERMINATES -----------");
}

// Network Server Call
void hitNetworkApi() async {

  print("---------- 3 SWITCH TO SERVER or DIFFERENT THREAD -----------");
  String output =  await downloadFileFromDummyNetwork();
  print("OUTPUT --- $output");
  print("---------- 4 SERVER THREAD TERMINATES -----------");
}

Future<String> downloadFileFromDummyNetwork() {
  Future<String> objectFuture = Future.delayed(Duration(seconds: 15), (){
    return "MY FILE CONTENT";
  });
  return objectFuture;
}