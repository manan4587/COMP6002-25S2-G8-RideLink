
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'app_config.dart';

class ApiService {
  ApiService._();
  static final instance = ApiService._();
  Future<Map<String,String>> _headers() async {
    final h = {'Content-Type':'application/json'};
    if (AppConfig.useFirebaseAuth) {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) h['Authorization'] = 'Bearer $token';
    }
    return h;
  }
  Future<Map<String,dynamic>> get(String p) async => _handle(await http.get(Uri.parse('${AppConfig.apiBaseUrl}$p'), headers: await _headers()));
  Future<Map<String,dynamic>> post(String p, Map<String,dynamic> b) async => _handle(await http.post(Uri.parse('${AppConfig.apiBaseUrl}$p'), headers: await _headers(), body: jsonEncode(b)));
  Future<Map<String,dynamic>> patch(String p, Map<String,dynamic> b) async => _handle(await http.patch(Uri.parse('${AppConfig.apiBaseUrl}$p'), headers: await _headers(), body: jsonEncode(b)));
  Map<String,dynamic> _handle(http.Response r){ final d=jsonDecode(r.body) as Map<String,dynamic>; if(r.statusCode>=400) throw Exception(d['error']??'API error'); return d; }
  Future<Map<String,dynamic>> login(String email,String password) async { if(AppConfig.useFirebaseAuth){ await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password); return post('/auth/firebase-login',{});} return post('/auth/demo-login',{'email':email}); }
  Future<Map<String,dynamic>> register(String name,String email,String password,String phone,String role) async { if(AppConfig.useFirebaseAuth){ await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password); await FirebaseAuth.instance.currentUser?.updateDisplayName(name); return post('/auth/register-profile',{'name':name,'phone':phone,'role':role}); } return post('/auth/demo-login',{'email':role=='driver'?'kasper@ridelink.com':'manan@ridelink.com'}); }
  Future<Map<String,dynamic>> createRideRequest() => post('/ride-requests',{'pickupLocation':'Landsdale','destination':'Curtin University','preferredTime':'2026-09-17T08:00:00','flexibilityMinutes':15,'seatsNeeded':2,'extraPassengerNote':'Manan + 1 passenger'});
  Future<Map<String,dynamic>> getMatches(String id)=>get('/ride-requests/$id/matches');
  Future<Map<String,dynamic>> requestJoin(String tripId)=>post('/bookings',{'tripId':tripId,'pickupLocation':'Shell Station, Landsdale','dropoffLocation':'Curtin University','seatsNeeded':2,'extraPassengerNote':'Manan + 1 passenger'});
  Future<Map<String,dynamic>> createTrip()=>post('/trips',{'startLocation':'Landsdale','destination':'Curtin University','departureTime':'2026-09-17T08:00:00','availableSeats':3,'costPerSeat':7});
  Future<Map<String,dynamic>> approve()=>patch('/bookings/booking_demo_confirmed',{'status':'confirmed'});
  Future<Map<String,dynamic>> sos()=>post('/safety/sos',{'tripId':'trip_001','lat':-31.8070,'lng':115.8620});
  Future<Map<String,dynamic>> mapboxRoute()=>get('/mapbox/route?start=Landsdale WA&destination=Curtin University WA');
}
