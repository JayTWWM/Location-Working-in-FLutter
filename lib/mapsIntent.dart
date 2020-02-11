import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String lat, String long) async {
    var mapSchema = 'http://maps.google.com/maps?saddr=20.344,34.34&daddr=' + lat + "," + long;
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }
}
