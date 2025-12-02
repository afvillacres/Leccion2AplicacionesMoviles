import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/character_viewmodel.dart';
import '../../domain/entities/character.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CharacterViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Raza de Gatones - Clean Architecture")),

      body: vm.loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Buscar razas de gatos...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                vm.search("");
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      vm.search(value);
                    },
                  ),
                ),
                
                // Lista paginada
                Expanded(
                  child: vm.paginatedItems.isEmpty
                      ? Center(
                          child: Text(
                            vm.searchQuery.isEmpty
                                ? "No hay datos"
                                : "No se encontraron resultados",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: vm.paginatedItems.length,
                          itemBuilder: (_, i) {
                            final CharacterEntity c = vm.paginatedItems[i];

                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(c.image),
                                  onBackgroundImageError: (_, __) {},
                                ),
                                title: Text(c.name),
                                subtitle: Text("${c.origin} • ${c.temperament}"),
                              ),
                            );
                          },
                        ),
                ),
                
                // Controles de paginación
                Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: vm.currentPage > 1 ? vm.previousPage : null,
                        child: Text("← Anterior"),
                      ),
                      Text(
                        "Página ${vm.currentPage} de ${vm.getTotalPages()}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: vm.currentPage < vm.getTotalPages()
                            ? vm.nextPage
                            : null,
                        child: Text("Siguiente →"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
