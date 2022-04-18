import 'package:edge_client/environments/env.dart';
import 'package:edge_client/localization/I18KeyConstants.dart';
import 'package:edge_client/models/connection/property.dart';
import 'package:edge_client/models/connection/water_connection.dart';
import 'package:edge_client/modules/water_service/ConsumerDetails/ConsumerDetailsWalkThrough/WalkFlowContainer.dart';
import 'package:edge_client/modules/water_service/ConsumerDetails/ConsumerDetailsWalkThrough/walkthrough.dart';
import 'package:edge_client/providers/common_provider.dart';
import 'package:edge_client/providers/consumer_details_provider.dart';
import 'package:edge_client/utils/TestingKeys/testing_keys.dart';
import 'package:edge_client/utils/constants.dart';
import 'package:edge_client/widgets/SideBar.dart';
import 'package:edge_client/widgets/customAppbar.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/localization/application_localizations.dart';
import 'package:egov_widgets/widgets/BottonButtonBar.dart';
import 'package:egov_widgets/widgets/DrawerWrapper.dart';
import 'package:egov_widgets/widgets/footer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:provider/provider.dart';

class ConsumerDetails extends StatefulWidget {
  final String? id;
  final WaterConnection? waterconnection;

  const ConsumerDetails({Key? key, this.id, this.waterconnection})
      : super(key: key);
  State<StatefulWidget> createState() {
    return _ConsumerDetailsState();
  }
}

class _ConsumerDetailsState extends State<ConsumerDetails> {
  FocusNode _numberFocus = new FocusNode();

  saveInput(context) async {}

  @override
  void initState() {
    var consumerProvider = Provider.of<ConsumerProvider>(context, listen: false)
      ..phoneNumberAutoValidation = false
      ..selectedcycle = ''
      ..waterconnection = WaterConnection()
      ..isfirstdemand = false
      ..property = Property();

    if (widget.waterconnection != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        var commonProvider = Provider.of<CommonProvider>(
            navigatorKey.currentContext!,
            listen: false);
        consumerProvider
          ..setModel()
          ..setWaterConnection(widget.waterconnection)
          ..getConnectionTypePropertyTypeTaxPeriod()
          ..fetchBoundary()
          ..getProperty({
            "tenantId": commonProvider.userDetails!.selectedtenant!.code,
            "propertyIds": widget.waterconnection!.propertyId
          })
          ..autoValidation = false
          ..formKey = GlobalKey<FormState>()
          ..setwallthrough(ConsumerWalkThrough().consumerWalkThrough.map((e) {
            e.key = GlobalKey();
            return e;
          }).toList());
      });
    } else if (widget.id != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Provider.of<CommonProvider>(navigatorKey.currentContext!,
            listen: false);
        consumerProvider
          ..setModel()
          ..getWaterConnection(widget.id)
          ..fetchBoundary()
          ..getConnectionTypePropertyTypeTaxPeriod()
          ..autoValidation = false
          ..formKey = GlobalKey<FormState>()
          ..setwallthrough(ConsumerWalkThrough().consumerWalkThrough.map((e) {
            e.key = GlobalKey();
            return e;
          }).toList());
      });
    } else {
      WidgetsBinding.instance?.addPostFrameCallback((_) => afterViewBuild());
    }

    _numberFocus.addListener(_onFocusChange);
    super.initState();
  }

  dispose() {
    _numberFocus.addListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    if (!_numberFocus.hasFocus) {
      Provider.of<ConsumerProvider>(context, listen: false)
        ..phoneNumberAutoValidation = true
        ..callNotifyer();
    }
  }

  afterViewBuild() {
    Provider.of<ConsumerProvider>(context, listen: false)
      ..setModel()
      ..getConnectionTypePropertyTypeTaxPeriod()
      ..fetchBoundary()
      ..getConsumerDetails()
      ..autoValidation = false
      ..formKey = GlobalKey<FormState>()
      ..setwallthrough(ConsumerWalkThrough().consumerWalkThrough.map((e) {
        e.key = GlobalKey();
        return e;
      }).toList());
  }

  Widget buildconsumerView(Property property) {
    return Column(
      children: [
        FormWrapper(
            Consumer<ConsumerProvider>(builder: (_, consumerProvider, child) {
          return Form(
              key: consumerProvider.formKey,
              autovalidateMode: consumerProvider.autoValidation
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HomeBack(
                    //     widget: Help(
                    //   callBack: () => showGeneralDialog(
                    //     barrierLabel: "Label",
                    //     barrierDismissible: false,
                    //     barrierColor: Colors.black.withOpacity(0.5),
                    //     transitionDuration: Duration(milliseconds: 700),
                    //     context: context,
                    //     pageBuilder: (context, anim1, anim2) {
                    //       return WalkThroughContainer((index) =>
                    //           consumerProvider.incrementindex(
                    //               index,
                    //               consumerProvider
                    //                   .consmerWalkthrougList[index + 1].key));
                    //     },
                    //     transitionBuilder: (context, anim1, anim2, child) {
                    //       return SlideTransition(
                    //         position:
                    //             Tween(begin: Offset(0, 1), end: Offset(0, 0))
                    //                 .animate(anim1),
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    //   walkThroughKey: Constants.CREATE_CONSUMER_KEY,
                    // )),
                    Card(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          //Heading
                          LabelText(consumerProvider.isEdit
                              ? i18.consumer.CONSUMER_EDIT_DETAILS_LABEL
                              : i18.consumer.CONSUMER_DETAILS_LABEL),
                          //Sub Heading
                          SubLabelText(consumerProvider.isEdit
                              ? i18.consumer.CONSUMER_EDIT_DETAILS_SUB_LABEL
                              : i18.consumer.CONSUMER_DETAILS_SUB_LABEL),
                          //Conniction ID displayed based in Edit Mode
                          consumerProvider.isEdit
                              ? BuildTableText(
                                  i18.consumer.CONSUMER_CONNECTION_ID,
                                  consumerProvider.waterconnection.connectionNo
                                      .toString())
                              : Container(),
                          //Consumer Name Field
                          BuildTextField(
                            i18.consumer.CONSUMER_NAME,
                            property.owners!.first.consumerNameCtrl,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[A-Za-z ]"))
                            ],
                            isRequired: true,
                            contextkey:
                                consumerProvider.consmerWalkthrougList[0].key,
                            key: Keys.createConsumer.CONSUMER_NAME_KEY,
                          ),

                          RadioButtonFieldBuilder(
                            context,
                            i18.common.GENDER,
                            property.owners!.first.gender,
                            '',
                            '',
                            false,
                            Constants.GENDER,
                            (val) => consumerProvider.onChangeOfGender(
                                val, property.owners!.first),
                            contextkey:
                                consumerProvider.consmerWalkthrougList[1].key,
                          ),

                          BuildTextField(
                            i18.consumer.FATHER_SPOUSE_NAME,
                            property.owners!.first.fatherOrSpouseCtrl,
                            isRequired: true,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[A-Za-z ]"))
                            ],
                            contextkey:
                                consumerProvider.consmerWalkthrougList[2].key,
                            key: Keys.createConsumer.CONSUMER_SPOUSE_PARENT_KEY,
                          ),

                          //Consumer Phone Number Field

                          BuildTextField(
                            i18.common.PHONE_NUMBER,
                            property.owners!.first.phoneNumberCtrl,
                            prefixText: '+91-',
                            isRequired: true,
                            textInputType: TextInputType.number,
                            maxLength: 10,
                            focusNode: _numberFocus,
                            validator: Validators.mobileNumberValidator,
                            autoValidation:
                                consumerProvider.phoneNumberAutoValidation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            contextkey:
                                consumerProvider.consmerWalkthrougList[3].key,
                            key: Keys.createConsumer.CONSUMER_PHONE_NUMBER_KEY,
                          ),

                          //Consumer Old Connection Field
                          Consumer<ConsumerProvider>(
                            builder: (_, consumerProvider, child) =>
                                BuildTextField(
                              i18.consumer.OLD_CONNECTION_ID,
                              consumerProvider
                                  .waterconnection.OldConnectionCtrl,
                              contextkey:
                                  consumerProvider.consmerWalkthrougList[4].key,
                                  key: Keys.createConsumer.CONSUMER_OLD_ID_KEY,
                                  isDisabled: consumerProvider.isfirstdemand,
                            ),
                          ),
                          Consumer<ConsumerProvider>(
                            builder: (_, consumerProvider, child) =>
                                SelectFieldBuilder(
                                    i18.consumer.CONSUMER_CATEGORY,
                                    consumerProvider.waterconnection
                                        .additionalDetails?.category,
                                    '',
                                    '',
                                    consumerProvider.onChangeOfCategory,
                                    consumerProvider.getCategoryList(),
                                    false,
                                    // contextkey: consumerProvider
                                    //     .consmerWalkthrougList[6].key,
                                    controller: consumerProvider
                                        .waterconnection.categoryCtrl,
                                key: Keys.createConsumer.CONSUMER_CATEORY_KEY,),
                          ),

                          Consumer<ConsumerProvider>(
                            builder: (_, consumerProvider, child) =>
                                SelectFieldBuilder(
                                    i18.consumer.CONSUMER_SUBCATEGORY,
                                    consumerProvider.waterconnection
                                        .additionalDetails?.subCategory,
                                    '',
                                    '',
                                    consumerProvider.onChangeOfSubCategory,
                                    consumerProvider.getSubCategoryList(),
                                    false,
                                    // contextkey: consumerProvider
                                    //     .consmerWalkthrougList[6].key,
                                    controller: consumerProvider
                                        .waterconnection.subCategoryCtrl,
                                key: Keys.createConsumer.CONSUMER_SUB_CATEORY_KEY),
                          ),
                          //Consumer Door Number Field
                          BuildTextField(
                            i18.consumer.DOOR_NO,
                            property.address.doorNumberCtrl,
                          ),

                          //Consumer Street Field
                          BuildTextField(
                            i18.consumer.STREET_NUM_NAME,
                            property.address.streetNameOrNumberCtrl,
                          ),
                          BuildTextField(
                            i18.consumer.GP_NAME,
                            property.address.gpNameCtrl,
                            isRequired: true,
                            readOnly: true,
                            isDisabled: true,
                          ),

                          //Consumer Ward Field
                          Consumer<ConsumerProvider>(
                              builder: (_, consumerProvider, child) =>
                                  consumerProvider.boundaryList.length > 1
                                      ? SelectFieldBuilder(
                                          i18.consumer.WARD,
                                          property.address.localityCtrl,
                                          '',
                                          '',
                                          consumerProvider.onChangeOflocaity,
                                          consumerProvider.getBoundaryList(),
                                          true,
                                          contextkey: consumerProvider
                                              .consmerWalkthrougList[5].key)
                                      : Container()),

                          //Consumer Property Type Field
                          Consumer<ConsumerProvider>(
                            builder: (_, consumerProvider, child) =>
                                SelectFieldBuilder(
                                    i18.consumer.PROPERTY_TYPE,
                                    property.propertyType,
                                    '',
                                    '',
                                    consumerProvider.onChangeOfPropertyType,
                                    consumerProvider.getPropertTypeList(),
                                    true,
                                    contextkey: consumerProvider
                                        .consmerWalkthrougList[6].key,
                                    controller: property.address.propertyCtrl,
                                key: Keys.createConsumer.CONSUMER_PROPERTY_KEY,),
                          ),
                          //Consumer Service Type Field
                          Consumer<ConsumerProvider>(
                              builder: (_, consumerProvider, child) => Column(
                                    children: [
                                      SelectFieldBuilder(
                                        i18.consumer.SERVICE_TYPE,
                                        consumerProvider
                                            .waterconnection.connectionType,
                                        '',
                                        '',
                                        consumerProvider
                                            .onChangeOfConnectionType,
                                        consumerProvider
                                            .getConnectionTypeList(),
                                        true,
                                        contextkey: consumerProvider
                                            .consmerWalkthrougList[7].key,
                                        controller: consumerProvider
                                            .waterconnection.ServiceTypeCtrl,
                                        isEnabled: consumerProvider.isEdit ==
                                                false ||
                                            consumerProvider.isfirstdemand ==
                                                false,
                                        key: Keys.createConsumer.CONSUMER_SERVICE_KEY,
                                      ),

                                      //Consumer Service Type Field),
                                      consumerProvider.waterconnection
                                                  .connectionType !=
                                              'Metered'
                                          ? Container()
                                          : Column(
                                              children: [
                                                //Consumer Previous MeterReading Date Picker Field
                                                consumerProvider.isEdit ==
                                                            false ||
                                                        consumerProvider.isfirstdemand ==
                                                            false
                                                    ? BasicDateField(
                                                        i18.consumer
                                                            .PREV_METER_READING_DATE,
                                                        true,
                                                        consumerProvider
                                                            .waterconnection
                                                            .previousReadingDateCtrl,
                                                        lastDate:
                                                            DateTime.now(),
                                                        onChangeOfDate:
                                                            consumerProvider
                                                                .onChangeOfDate,
                                                key: Keys.createConsumer.CONSUMER_PREVIOUS_READING_DATE_KEY,)
                                                    : Text(""),
                                                BuildTextField(
                                                  i18.consumer.METER_NUMBER,
                                                  consumerProvider
                                                      .waterconnection
                                                      .meterIdCtrl,
                                                  isRequired: true,
                                                  inputFormatter: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            "[a-zA-Z0-9]"))
                                                  ],
                                                  key: Keys.createConsumer.CONSUMER_METER_NUMBER_KEY,
                                                ),
                                                consumerProvider.isEdit ==
                                                            false ||
                                                        consumerProvider
                                                                .isfirstdemand ==
                                                            false
                                                    ? MeterReading(
                                                        i18.demandGenerate
                                                            .PREV_METER_READING_LABEL,
                                                        consumerProvider
                                                            .waterconnection
                                                            .om_1Ctrl,
                                                        consumerProvider
                                                            .waterconnection
                                                            .om_2Ctrl,
                                                        consumerProvider
                                                            .waterconnection
                                                            .om_3Ctrl,
                                                        consumerProvider
                                                            .waterconnection
                                                            .om_4Ctrl,
                                                        consumerProvider
                                                            .waterconnection
                                                            .om_5Ctrl,
                                                        isRequired: false,
                                                      )
                                                    : Text(""),
                                              ],
                                            ),
                                      consumerProvider.waterconnection
                                                  .connectionType !=
                                              'Non_Metered'
                                          ? Container()
                                          : Consumer<ConsumerProvider>(
                                              builder: (_, consumerProvider,
                                                      child) =>
                                                  consumerProvider.isEdit ==
                                                              false ||
                                                          consumerProvider
                                                                  .isfirstdemand ==
                                                              false
                                                      ? SelectFieldBuilder(
                                                          i18.consumer
                                                              .CONSUMER_BILLING_CYCLE,
                                                          consumerProvider
                                                              .selectedcycle,
                                                          '',
                                                          '',
                                                          consumerProvider
                                                              .onChangeBillingcycle,
                                                          consumerProvider
                                                              .getBillingCycle(),
                                                          true,
                                                          controller: consumerProvider
                                                              .waterconnection
                                                              .BillingCycleCtrl,
                                                    key: Keys.createConsumer.CONSUMER_LAST_BILLED_CYCLE,
                                                        )
                                                      : Text("")),
                                    ],
                                  )),
                          consumerProvider.isEdit == false ||
                                  consumerProvider.isfirstdemand == false
                              ? BuildTextField(i18.consumer.ARREARS,
                                  consumerProvider.waterconnection.arrearsCtrl,
                                  textInputType: TextInputType.number,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9.]"))
                                  ],
                                  contextkey: consumerProvider
                                      .consmerWalkthrougList[8].key,
                          key: Keys.createConsumer.CONSUMER_ARREARS_KEY,)
                              : Text(""),
                          if (consumerProvider.isEdit)
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                              child: Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Checkbox(
                                        value: consumerProvider
                                                    .waterconnection.status ==
                                                'Active'
                                            ? false
                                            : true,
                                        onChanged: (_) => consumerProvider
                                            .onChangeOfCheckBox(_, context)),
                                  ),
                                  Text(
                                      ApplicationLocalizations.of(context)
                                          .translate(
                                              i18.consumer.MARK_AS_INACTIVE),
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                        ])),
                  ]));
        })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<ConsumerProvider>(context, listen: false);
    return FocusWatcher(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
          appBar: CustomAppBar(),
          drawer: DrawerWrapper(
            Drawer(child: SideBar()),
          ),
          body: SingleChildScrollView(
              child: Container(
                  child: Column(children: [
                    StreamBuilder(
                    stream: userProvider.streamController.stream,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return buildconsumerView(snapshot.data);
                      } else if (snapshot.hasError) {
                        return Notifiers.networkErrorPage(context, () {});
                      } else {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Loaders.CircularLoader();
                          case ConnectionState.active:
                            return Loaders.CircularLoader();
                          default:
                            return Container();
                        }
                      }
                    }),
                    Footer(imageUrl: '${Environment().config?.apiHost}${Constants.DIGIT_FOOTER_WHITE_ENDPOINT}'),
      ]))),
          bottomNavigationBar: BottomButtonBar(i18.common.SUBMIT,
          () => {userProvider.validateConsumerDetails(context)},
          key: Keys.createConsumer.CREATE_CONSUMER_BTN_KEY,),
    ));
  }
}
