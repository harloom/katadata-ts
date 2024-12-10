import 'package:flutter/material.dart';
import 'package:ilham_kata_data_test/module/data/models/news_model.dart';
import 'package:ilham_kata_data_test/module/data/models/post_response_model.dart';
import 'package:ilham_kata_data_test/module/domain/usecases/post_usecase.dart';
import 'package:ilham_kata_data_test/module/presentation/widgets/card_news.dart';
import 'package:ilham_kata_data_test/module/shareds/register.dart';
import 'package:ilham_kata_data_test/module/shareds/untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// variable
  List<PostModel> posts = [];
  List<PostModel> postsTmp = [];
  late ScrollController _scrollController;
  int page = 1;
  final int limit = 10;
  bool _isLoading = false;
  bool _hasMoreData = true;
  bool _isError = false;
  final _debouncer = Debouncer(milliseconds: 500);
  Future<PostResponse>? future;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    future = getDataInitial();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> getDataMore({bool reset = false}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    if (reset == true) {
      page = 1;
      var newPost = await getIt.get<PostUseCase>().getPost(limit: limit, start: page);
      setState(() {
        posts = newPost.post ?? [];
        _isLoading = false;
        _isError = newPost.isError ?? false;
      });
      return;
    }

    var newPost = await getIt.get<PostUseCase>().getPost(limit: limit, start: page);

    setState(() {
      posts.addAll(newPost.post ?? []);
      page++;
      _isLoading = false;
      if (posts.length >= 100) {
        _hasMoreData = false;
      }
    });
  }

  Future<PostResponse> getDataInitial() async {
    var newPost = await getIt.get<PostUseCase>().getPost(limit: limit, start: page);
    posts.addAll(newPost.post ?? []);
    setState(() {
      _isError = newPost.isError ?? false;
    });
    return newPost;
  }

  Future<void> search(String s) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final regex = RegExp(s, caseSensitive: false);
      var res = await getIt.get<PostUseCase>().searchPost(regExp: regex);
      setState(() {
        posts = res.post ?? [];
      });
    } catch (e) {
      ///
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.0.h),
            child: TextFormField(
              maxLength: 50,
              onChanged: (s) {
                if (s.isEmpty) {
                  _debouncer.run(() => getDataMore(reset: true));
                } else {
                  _debouncer.run(() => search(s));
                }
              },
              decoration: const InputDecoration(
                labelText: 'Cari',
                hintText: 'Inputkan teks',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Total : ${posts.length} ${_isLoading == true ? 'Loading..' : ''}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              getDataMore(reset: true);
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: FutureBuilder(
                future: future,
                builder: (c, s) {
                  if (s.connectionState == ConnectionState.done) {
                    /// handle error
                    if (_isError) {
                      return Center(
                        child: Column(
                          children: [
                            Text(s.data?.message ?? ''),
                            GestureDetector(
                                onTap: () {
                                  getDataMore(reset: true);
                                },
                                child: const Text('Tap disni,  untuk muat ulang'))
                          ],
                        ),
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(posts.length + 1, (i) {
                          if (i < posts.length) {
                            return CardNews(post: posts[i]);
                          } else {
                            return _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: _hasMoreData == false
                                        ? ListTile(
                                            title: const Text('Sudah Habis'),
                                            onTap: () {},
                                          )
                                        : ListTile(
                                            title: Text('Muat Lagi',style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).primaryColor,
                                            )),
                                            onTap: getDataMore,
                                          ),
                                  );
                          }
                        })
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
