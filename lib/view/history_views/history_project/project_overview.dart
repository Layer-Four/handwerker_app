import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_overview.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/view/widgets/empty_result_message.dart';
import 'package:handwerker_app/view/widgets/hinged_widget.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';

class CostumerOverviewBody extends StatelessWidget {
  const CostumerOverviewBody({super.key});
  @override
  Widget build(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: delete headline "Kunde Übersicht"???
            _buildCustomerOverviewHeadLin(context),
            _buildAsyncProjectOverview(),
            const LogoWidget(assetString: 'assets/images/img_techtool.png'),
          ],
        ),
      );

  Widget _buildAsyncProjectOverview() => Consumer(builder: (context, ref, child) {
        Future<List<ProjectCustomer>> futureProjects;
        futureProjects = ref.read(projectVMProvider.notifier).getAllProjectEntries();
        return FutureBuilder<List<ProjectCustomer?>>(
            future: futureProjects,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (snapshot.data!.isEmpty) return const ShowEmptyMessage();
                final customerProjectList = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: customerProjectList!.length,
                    itemBuilder: (BuildContext context, i) {
                      final customer = customerProjectList[i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text(customer?.customer ?? 'Kein Kunde??'),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height - 300,
                              child: _buildProjectDetails(customer)),
                        ],
                      );
                    },
                  ),
                );
              }
              return const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            });
      });

  Widget _buildCustomerOverviewHeadLin(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(
          'ÜBERSICHT',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  Row _buildHeadLine(ProjectOverview j, BuildContext context) {
    final initDate = '${j.projectCreated.day}.${j.projectCreated.month}.${j.projectCreated.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            j.projectName!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            initDate,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  ListView _buildProjectDetails(ProjectCustomer? customer) {
    return ListView.builder(
        itemCount: customer?.projects.length,
        itemBuilder: (context, int j) {
          final project = customer?.projects[j];
          return HingedWidget(
            contentLength: project!.timeViewModels.length,
            header: _buildHeadLine(project, context),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var work in project.timeViewModels)
                  SizedBox(
                    height: 18,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              '${work.start.day < 10 ? "0${work.start.day}" : work.start.day}.${work.start.month < 10 ? "0${work.start.month}" : work.start.month}-${work.end.day < 10 ? "0${work.end.day}" : work.end.day}.${work.end.month < 10 ? "0${work.end.month}" : work.end.month}.${work.end.year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              work.serviceName ?? 'kein Service ausgewählt',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              '${work.durationTotal} Stunden',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColor.kTextfieldBorder),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // TODO: ask for, project, all entries need own update card
                ProjectDetails(project: project),
              ],
            ),
          );
        });
  }
}

class ProjectDetails extends ConsumerStatefulWidget {
  final ProjectOverview project;
  const ProjectDetails({super.key, required this.project});

  @override
  ConsumerState<ProjectDetails> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectDetails> {
  final consumables = [
    const Consumable(),
    // const Consumable(name: 'Bottle of Beer', amount: 99, unitTypeName: 'Stück'),
    const Consumable(),
    // const Consumable(name: 'Bottle of Wine', amount: 98, unitTypeName: 'Meter'),
    const Consumable(),
    // const Consumable(name: 'Bottle if Rum', amount: 97, unitTypeName: 'Kilo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _showProjectDocumentation(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
            child: Text(
              'Material',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: consumables.length,
                itemBuilder: ((context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(
                          'name des Consumables',
                          // consumables[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.kTextfieldBorder),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          '${consumables[index].amount} ', //${consumables[index].unitTypeName}
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.kTextfieldBorder),
                        ),
                      ),
                    ],
                  );
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [Text('${consumables[index]}')],
                  // );
                })),
          )
        ],
      ),
    );
  }

  Widget _showProjectDocumentation(BuildContext context) {
    final project = widget.project;
    return InkWell(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.kTextfieldBorder)),
        ),
        child: Text('Dokumentation', style: Theme.of(context).textTheme.bodyMedium),
      ),
      onTap: () {
        ref
            .read(projectVMProvider.notifier)
            .loadDocumentationForProject(
              project.projectID,
            )
            .then(
          (value) {
            return showDialog(
              context: context,
              builder: (context) {
                int currentIndex = 0;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                  child: Material(
                    child: value == null || value.isEmpty
                        ? const SizedBox.expand(
                            child: Center(
                              child: Text('keine Dokumentationen gefunden'),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  List<Image> image = value[index]
                                      .imagesUrl
                                      .map((e) => Image.network(
                                            e,
                                            height: 130,
                                            width: 130,
                                          ))
                                      .toList();
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      // !
                                      height: image.isEmpty ? 60 : 210,
                                      child: Column(
                                        children: [
                                          Text(value[index].description ?? 'Keine Beschreibung'),
                                          image.isEmpty
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: CarouselSlider.builder(
                                                    itemCount: image.length,
                                                    itemBuilder: (context, i, _) => image[i],
                                                    options: CarouselOptions(
                                                      viewportFraction: 1,
                                                      height: 150,
                                                      enableInfiniteScroll: false,
                                                      // enlargeCenterPage: true,
                                                      onPageChanged: (index, _) =>
                                                          setState(() => currentIndex = index),
                                                    ),
                                                  ),
                                                ),
                                          image.length > 1
                                              ? Utilits.buildIndicator(
                                                  selectedIndex: currentIndex,
                                                  length: image.length,
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
