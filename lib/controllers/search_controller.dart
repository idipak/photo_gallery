import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_search/models/photo_model.dart';

import '../services/photo_services.dart';

final keywords = ["All", "Mountains", "Birds", "Animals", "Food"];

final tabProvider = StateProvider<String>((ref) => "All");

final searchText = StateProvider<String>((ref) => "");

final photoController = StateNotifierProvider((ref){
  final tag = ref.watch(tabProvider);
  final search = ref.watch(searchText);
  return PhotoController(PhotoService(), search.isNotEmpty ? search : tag);
});

class PhotoController extends StateNotifier<PhotoBaseState>{
  final PhotoService _service;
  final String _tag;
  PhotoController(this._service, this._tag): super(PhotoInitialState()){
    init();
  }

  init() async{
    try{
      state = PhotoLoadingState();

      final data = await _service.getPhotoByTag(_tag);

      final photos = data.map((e){
        return Photo(title: e.tags.isNotEmpty ? e.tags.first.title : "Untitled", tag: "Mountain", url: e.urls.regular);
      }).toList();

      // state = PhotoLoadedState([]);
      state = PhotoLoadedState(photos);
    } catch(e){
      state = PhotoErrorState(e.toString());
    }
  }

}

abstract class PhotoBaseState{}

class PhotoInitialState extends PhotoBaseState{}

class PhotoLoadingState extends PhotoBaseState{}

class PhotoErrorState extends PhotoBaseState{
  final String msg;
  PhotoErrorState(this.msg);
}

class PhotoLoadedState extends PhotoBaseState{
  final List<Photo> photos;
  PhotoLoadedState(this.photos);
}

