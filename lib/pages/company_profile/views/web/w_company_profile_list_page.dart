import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/cubit/company_profile_cubit.dart';
import 'package:gtm/pages/company_profile/views/web/w_company_profile_page.dart';
import 'package:gtm/pages/home/models/gtm_tab.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';

class WCompanyProfileListPage extends StatefulWidget {
  const WCompanyProfileListPage({Key? key}) : super(key: key);

  @override
  State<WCompanyProfileListPage> createState() =>
      _WCompanyProfileListPageState();
}

class _WCompanyProfileListPageState extends State<WCompanyProfileListPage> {
  final TextEditingController _searchBoxController = TextEditingController();

  List<CompanyProfile>? companyProfileList;

  @override
  void didChangeDependencies() {
    context.read<CompanyProfileCubit>().fetchCompanyProfileInitial();
    super.didChangeDependencies();
  }

  searchCompany({String searchText = ''}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CompanyProfileCubit, CompanyProfileState>(
        listener: (context, state) {},
        child: BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == CompanyProfileStatus.success) {
              companyProfileList = state.companyProfiles;
            }
            return companyProfileList == null
                ? loadingWidget()
                // : companyProfileList?.length == 1
                //     ? WCompanyProfileDetailPage(
                //         companyProfile: companyProfileList![0],
                //       )
                : _buildCompaniesTable();
          },
        ),
      ),
    );
  }

  Widget _buildCompaniesTable() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: TextField(
            controller: _searchBoxController,
            onChanged: (value) {
              // TODO: Search
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text('Search'.translate()),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  if (_searchBoxController.text.isNotEmpty) {
                    _searchBoxController.clear();
                  }
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        Expanded(
          child: CompaniesCustomListView(data: companyProfileList),
        ),
      ],
    );
  }
}

class CompaniesCustomListView extends StatefulWidget {
  const CompaniesCustomListView({Key? key, required this.data})
      : super(key: key);

  final List<CompanyProfile>? data;
  @override
  State<CompaniesCustomListView> createState() => _CompaniesCustomListView();
}

class _CompaniesCustomListView extends State<CompaniesCustomListView> {
  ScrollController mainListController = ScrollController();
  List<String> tableColumns = [
    'Company Name',
    'Region',
    'Country',
    'BDM',
    'Status',
    'Action'
  ];
  List<double> tableColumnsWidth = [
    0,
    100,
    200,
    200,
    200,
    200,
  ];

  @override
  Widget build(BuildContext context) {
    List<CompanyProfile> _peopleList = widget.data ?? [];

    _peopleList.sort((a, b) {
      return a.customerName!
          .toLowerCase()
          .compareTo(b.customerName!.toLowerCase());
    });
    List<List<Widget>> rows = [];
    for (var val in _peopleList) {
      List<String> bdms = [];
      if (val.bdm != null && val.bdm!.isNotEmpty) {
        for (int i = 0; i < val.bdm!.length; i++) {
          if (val.bdm![i].name != null) {
            bdms.add(val.bdm![i].name!);
          }
        }
      }
      rows.add([
        appText(val.customerName, color: AppColors.charcoalGrey),
        appText(val.regionName, color: AppColors.charcoalGrey),
        appText(val.country?.name ?? "", color: AppColors.charcoalGrey),
        appText(bdms.join(', '), color: AppColors.charcoalGrey),
        appText(val.status, color: AppColors.charcoalGrey),
        appText('', color: AppColors.charcoalGrey),
      ]);
    }
    return Padding(
      padding: const EdgeInsets.all(spacing8),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: mainListController,
            child: Column(
              children: [
                CmsTableHeader(
                  columns: tableColumns,
                  columnsWidth: tableColumnsWidth,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      Widget actions = Container();
                      Widget expWidget = Container();
                      GtmTab gtmTab = GtmTab(
                        isActive: true,
                        name: widget.data![index].customerName ?? '',
                        tab: tabHeader(false,
                            widget.data![index].customerName ?? '', context),
                        page: WCompanyProfileDetailPage(
                          companyProfile: widget.data![index],
                        ),
                        shortname: widget.data![index].customerName ?? '',
                      );
                      return CmsTableRow(
                        isExpandable: false,
                        expandedWidget: expWidget,
                        editBool: false,
                        actions: actions,
                        columns: tableColumns,
                        columnsWidth: tableColumnsWidth,
                        row: rows[index],
                        itemIndex: index,
                        onTapAction: () => openTab(gtmTab, context),
                      );
                    }),
                CmsTableFooter(
                  columnsWidth: tableColumnsWidth,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                closeTab("Company Profile", context);
              },
              child: const Text('Exit'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.redColor)),
            ),
          ),
        ],
      ),
    );
  }
}
