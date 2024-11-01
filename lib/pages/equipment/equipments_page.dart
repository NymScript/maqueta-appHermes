import 'package:flutter/material.dart';
import 'package:maqueta/models/equipment.dart';
import 'package:maqueta/pages/equipment/add_equipment_page.dart';
import 'package:maqueta/services/people_service.dart';
import 'package:maqueta/widgets/equipment_card.dart';
import 'package:maqueta/widgets/home_app_bar.dart';

class Equipmentspage extends StatefulWidget {
  final Equipment? newEquipment;
  const Equipmentspage({super.key, this.newEquipment});

  @override
  State<Equipmentspage> createState() => _EquipmentspageState();
}

class _EquipmentspageState extends State<Equipmentspage> {
  final PeopleService _peopleService = PeopleService();
  final List<Equipment> _equipments = [];

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = await _peopleService.getUser();
    if (user != null) {
      setState(() {
        _equipments.addAll(user.equipments);
      });
    }
  }

  Future<void> _navigateToAddEquipmentPage() async {
    // Navegar a la página de agregar equipo y esperar el resultado
    final newEquipment = await Navigator.push<Equipment>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEquipmentPage(),
      ),
    );

    // Si se retorna un equipo, añadirlo a la lista
    if (newEquipment != null) {
      setState(() {
        _equipments.add(newEquipment);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mis Equipos",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF39A900),
                    ),
                  ),
                  // Botón "Agregar equipo" siempre en el header
                  ElevatedButton(
                    onPressed: _navigateToAddEquipmentPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF39A900),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Agregar equipo",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _equipments.isEmpty
                  ? _buildEmptyEquipmentView() // Vista alternativa si no hay equipos
                  : _buildEquipmentList(), // Lista de equipos si existen
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyEquipmentView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices_other,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            "No tienes equipos registrados.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEquipmentList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: _equipments.length,
      itemBuilder: (context, index) {
        final equipment = _equipments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: EquipmentCard(
            type: equipment.model,
            brand: equipment.brand,
            model: equipment.model,
            color: equipment.color,
            serialNumber: equipment.serial,
            onEdit: () {
              // Lógica para editar equipo
            },
            onDeactivate: () {
              // Lógica para desactivar equipo
            },
          ),
        );
      },
    );
  }
}
