import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maqueta/models/equipment.dart';
import 'package:maqueta/providers/token_storage.dart';
import 'package:maqueta/providers/url_storage.dart';

class EquipmentService {
  final String virtualPort = UrlStorage().virtualPort;
  final String urlEquipment = UrlStorage().urlEquipment;
  final TokenStorage tokenStorage = TokenStorage();

  Future<void> addEquipment(
      Equipment equipment, Map<dynamic, dynamic> token) async {
    var token = await tokenStorage.getToken();
    var decodeToken = await tokenStorage.decodeJwtToken();
    var document = decodeToken['sub'];

    final String baseUrl = '$virtualPort$urlEquipment';
    final url = Uri.parse('$baseUrl/add');

    try {
      equipment.setDocumentId = document;

      // Crea el objeto con 'data'
      final Map<String, dynamic> payload = {
        'data': equipment.toJson(),
      };

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(payload),
      );

      print(response.body);

      if (response.statusCode != 200) {
        print('Equipo registrado exitosamente');
      } else {
        print('Error en la respuesta del servidor: ${response.body}');
        throw Exception('Error al registrar el equipo: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception al registrar equipo: $e');
      rethrow;
    }
  }

  Future<List<Equipment>> fetchEquipments(List<int> equipmentIds) async {
    var token = await tokenStorage.getToken();
    final String baseUrl = '$virtualPort$urlEquipment/by-id/';
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      var responses = await Future.wait(equipmentIds.map((id) {
        return http.get(Uri.parse('$baseUrl$id'), headers: headers);
      }));

      return responses
          .where((response) => response.statusCode == 200)
          .map((response) {
        var jsonResponse = json.decode(response.body);
        return Equipment.fromJson(jsonResponse['data']);
      }).toList();
    } catch (e) {
      print('Error fetching equipments: $e');
      return [];
    }
  }

  Future<void> editEquipment(
    Equipment equipment,
  ) async {
    var token = await tokenStorage.getToken();
    final String baseUrl = '$virtualPort$urlEquipment';
    final url = Uri.parse('$baseUrl/update/${equipment.id}');

    var decodeToken = await tokenStorage.decodeJwtToken();
    var document = decodeToken['sub'];
    equipment.setDocumentId = document;

    final Map<String, dynamic> payload = {
      'data': equipment.toJson(),
    };

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al editar el equipo');
    }
  }

  Future<void> toggleEquipmentState(Equipment equipment) async {
    // Cambia el estado localmente (de activo a inactivo o viceversa)
    equipment.state = equipment.state == true ? false : true;

    // Realiza una actualización en el backend con el nuevo estado
    await editEquipment(equipment);
  }
}
