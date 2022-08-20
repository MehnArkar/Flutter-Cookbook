import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDownloadBtn extends StatefulWidget {
  const MyDownloadBtn({Key? key}) : super(key: key);

  @override
  State<MyDownloadBtn> createState() => _MyDownloadBtnState();
}

enum DownloadStatus { download, fetching, downloading, downloaded }

class _MyDownloadBtnState extends State<MyDownloadBtn> {
  late Rx<List<DownloadStatus>> statusList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statusList = Rx<List<DownloadStatus>>(
        List<DownloadStatus>.generate(20, (index) => DownloadStatus.download));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Animate Download'),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) => eachDownloadItem(index),
          separatorBuilder: (ctx, index) => const Divider(),
          itemCount: 20),
    );
  }

  Widget eachDownloadItem(int index) {
    final theme = Theme.of(context);
    Rx<double> progress = 0.0.obs;
    return ListTile(
        leading: const DemoAppIcon(),
        title: Text(
          'Item ${index + 1}',
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline6,
        ),
        subtitle: Text(
          'Lorem ipsum dolor #${index + 1}',
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.caption,
        ),
        trailing: Obx(
          () => GestureDetector(
            onTap: () async {
              await Future.delayed(Duration(milliseconds: 200)).then((value) {
                statusList.value[index] = DownloadStatus.fetching;
                statusList.refresh();
              });

              await Future.delayed(const Duration(seconds: 1))
                  .then((value) async {
                statusList.value[index] = DownloadStatus.downloading;
                statusList.refresh();
              });
              const downloadProgressStops = [0.1, 0.15, 0.45, 0.8, 1.0];
              for (double tem in downloadProgressStops) {
                progress.value = tem;
                await Future<void>.delayed(const Duration(seconds: 1));
              }
              statusList.value[index] = DownloadStatus.downloaded;
              statusList.refresh();
            },
            child: SizedBox(
              width: 96,
              height: 40,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration:
                      statusList.value[index] != DownloadStatus.downloading &&
                              statusList.value[index] != DownloadStatus.fetching
                          ? const ShapeDecoration(
                              shape: StadiumBorder(),
                              color: CupertinoColors.lightBackgroundGray)
                          : ShapeDecoration(
                              shape: CircleBorder(),
                              color: Colors.white.withOpacity(0)),
                  child: Stack(children: [
                    Center(
                      child: AnimatedOpacity(
                        opacity:
                            statusList.value[index] == DownloadStatus.fetching
                                ? 1.0
                                : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: const CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity:
                          statusList.value[index] == DownloadStatus.downloading
                              ? 1.0
                              : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progress.value,
                              color: Colors.blue,
                              backgroundColor: Colors.grey,
                            ),
                            const Icon(
                              Icons.stop,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: AnimatedOpacity(
                        opacity: statusList.value[index] ==
                                    DownloadStatus.downloading ||
                                statusList.value[index] ==
                                    DownloadStatus.fetching
                            ? 0.0
                            : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          statusList.value[index] != DownloadStatus.download &&
                                  statusList.value[index] !=
                                      DownloadStatus.downloading &&
                                  statusList.value[index] !=
                                      DownloadStatus.fetching
                              ? 'Open'
                              : 'Get',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}

@immutable
class DemoAppIcon extends StatelessWidget {
  const DemoAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        child: SizedBox(
          width: 80,
          height: 80,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
