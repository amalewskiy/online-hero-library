import 'package:flutter/material.dart';
import 'package:library_online/components/hero_cover.dart';
import 'package:library_online/components/helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExampleHero> heroList = [], filteredList = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<Helper>(context, listen: false).changeAllFutureData();
  }

  List<ExampleHero> searchFilter(String text) {
    List<ExampleHero> filterList = [];
    for (var hero in heroList) {
      if (text.trim().isNotEmpty &&
          (hero.name.contains(text) ||
              hero.name.contains(text.toUpperCase()))) {
        filterList.add(hero);
      }
    }
    return filterList;
  }

  Widget searchField() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: TextField(
            controller: searchController,
            onChanged: (content) {
              filteredList = searchFilter(content);
              filteredList.isNotEmpty || searchController.text.isNotEmpty
                  ? Provider.of<Helper>(context, listen: false)
                      .changeIsFiltered(true)
                  : Provider.of<Helper>(context, listen: false)
                      .changeIsFiltered(false);
              build(context);
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: const Color(0xff457b9d))));
  }

  Widget allCharacters(Map<String, dynamic> data) {
    if (Provider.of<Helper>(context).isFiltered == false &&
        Provider.of<Helper>(context).isOpened == false) {
      final List allCharacters = data['results'];
      heroList.addAll(List.generate(allCharacters.length,
          (index) => ExampleHero.fromList(allCharacters[index])));
      Provider.of<Helper>(context, listen: false).changeIsOpened();
    }
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Provider.of<Helper>(context).isFiltered
            ? filteredList.length
            : heroList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 40.0,
            mainAxisSpacing: 25.0,
            maxCrossAxisExtent: 180.0,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return Provider.of<Helper>(context).isFiltered
              ? filteredList[index].getHeroCard(context)
              : heroList[index].getHeroCard(context);
        });
  }

  Widget showMoreButton(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        data['next'] != null
            ? Provider.of<Helper>(context, listen: false)
                .changeAllFutureData(link: data['next'])
            : Provider.of<Helper>(context, listen: false).changeIsNext();
      },
      child: Container(
        height: 50.0,
        width: 220.0,
        decoration: BoxDecoration(
          color: const Color(0xffa8dadc),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Show more...',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: Provider.of<Helper>(context).allFutureData,
          builder: (context, snaphot) {
            switch (snaphot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color(0xffe63946),
                ));
              default:
                final Map<String, dynamic> data = snaphot.data ?? {};
                return SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          searchField(),
                          const SizedBox(height: 25.0),
                          allCharacters(data),
                          const SizedBox(height: 35.0),
                          if (Provider.of<Helper>(context).isNext)
                            showMoreButton(data)
                        ],
                      ),
                    ));
            }
          },
        ),
      ),
    );
  }
}
