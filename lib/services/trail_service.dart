import 'package:TreeTrek/models/trail.dart';

class TrailService {
  List<Trail> _trails;

  TrailService();

  List<Trail> get trails => [..._trails];
}
