import 'package:flutter/material.dart';
import 'package:maqueta/widgets/HomeAppBar.dart';

class Formaddeequipts extends StatefulWidget {
  const Formaddeequipts({super.key});

  @override
  State<Formaddeequipts> createState() => _RegistroEquipoPageState();
}

class _RegistroEquipoPageState extends State<Formaddeequipts> {
  // Lista de opciones para el tipo de equipo
  final List<String> _equipmentTypes = ['Tablet', 'Desktop', 'Portatil'];
  String? _selectedType;

  // Lista de opciones para las marcas
  final List<String> _brands = ['Apple', 'Dell', 'HP', 'Asus', 'Acer', 'Lenovo'];
  String? _selectedBrand;

  // Controladores para los campos de texto
  final _modelController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              // HomeAppBar con la flecha de retroceso
              Stack(
                children: [
                  const HomeAppBar(),
                  Positioned(
                    top: 30,
                    left: 5,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      // Flecha para regresar a la pantalla anterior.
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título de la página
                    const Text(
                      'Registro de Equipo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00314D),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Por favor completa la siguiente información.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Dropdown para seleccionar el tipo de equipo
                    const Text(
                      'Tipo de Equipo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00314D),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      hint: const Text('Selecciona el tipo de equipo'),
                      items: _equipmentTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Dropdown para seleccionar la marca
                    const Text(
                      'Marca',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00314D),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedBrand,
                      hint: const Text('Selecciona la marca del equipo'),
                      items: _brands.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedBrand = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Campo de texto para el modelo
                    _buildTextField('Modelo', 'Ingresa el modelo del equipo', _modelController),
                    const SizedBox(height: 20),
                    
                    // Campo de texto para el número de serie
                    _buildTextField('Numero de serie', 'Ingresa el numero de serie del equipo', _serialNumberController),
                    const SizedBox(height: 20),
                    
                    // Campo de texto para el color
                    _buildTextField('Color', 'Ingresa el color del equipo', _colorController),
                    const SizedBox(height: 30),
                    
                    // Botón de registro
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para registrar el equipo
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00314D),
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Método para construir los campos de texto
  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00314D),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
      ],
    );
  }
}