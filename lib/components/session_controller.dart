

class secssion_controller{

  static final secssion_controller session = secssion_controller._internal();
   String? uerid;
   factory secssion_controller(){
     return session;
   }

  secssion_controller._internal(){

  }
}