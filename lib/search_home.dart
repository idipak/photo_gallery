import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_search/controllers/search_controller.dart';
import 'package:photo_search/utils/debouncer.dart';
import 'package:photo_search/widgets/image_preview.dart';
import 'package:photo_search/widgets/selection_button.dart';

class SearchHome extends ConsumerWidget {
  SearchHome({Key? key}) : super(key: key);

  final _debounce = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabSelection = ref.watch(tabProvider);
    final search = ref.watch(searchText);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search, color: Colors.black87,),
                  label: const Text("Search keywords...", style: TextStyle(color: Colors.black26),),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6)
                  )
                ),
                onChanged: (value){
                  _debounce.run(() {
                    ref.read(searchText.notifier).state = value;
                  });
                },
              ),
            ),

            ///Hides tags when search is active
            search.isNotEmpty
                ? Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
                  child: Text("Sear results for \"$search\"", style: const TextStyle(fontWeight: FontWeight.bold),),
                ))
                : Container(
              padding: const EdgeInsets.only(top: 28, bottom: 18, left: 8),
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  ...keywords.map((key) => SelectionButton(
                      label: key,
                      onTap: (){
                        ref.read(tabProvider.notifier).state = key;
                      },
                      isSelected: tabSelection == key),).toList(),

                ],
              ),
            ),

            Expanded(
              child: Consumer(
                builder: (context, ref, _){
                  final photos = ref.watch(photoController);
                  if(photos is PhotoErrorState){
                    return Text(photos.msg, style: const TextStyle(color: Colors.redAccent),);
                  }
                  if(photos is PhotoLoadingState){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(photos is PhotoLoadedState){
                    return GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        ...photos.photos.map((e) => ImagePreview(url: e.url,)).toList()
                      ],
                    );
                  }else{
                    return const Center(child: Text("Loading..."),);
                  }



                },
              ),
            )


          ],
        ),
      ),
    );
  }
}



