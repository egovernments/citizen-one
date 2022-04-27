import 'package:edge_client/models/localization/language.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:edge_client/service/utils/api_end_points.dart';
import 'package:edge_client/utils/enums.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/global_variables.dart';
import 'package:egov_widgets/utils/models.dart';

import '../service/utils/request_info.dart';

class CoreRepository extends BaseService {
  Future<List<LocalizationLabel>> getLocilisation(
      Map<String, dynamic> query) async {
    late List<LocalizationLabel> labelList;
    var res = await makeRequest(
        url: ApiEndPoints.LOCALIZATION,
        queryParameters: query,
        requestInfo: RequestInfo(
            APIConstants.API_MODULE_NAME,
            APIConstants.API_VERSION,
            APIConstants.API_TS,
            "_search",
            APIConstants.API_DID,
            APIConstants.API_KEY,
            APIConstants.API_MESSAGE_ID,
            ""),
        method: RequestType.POST);
    if (res != null) {
      labelList = res['messages']
          .map<LocalizationLabel>((e) => LocalizationLabel.fromJson(e))
          .toList();
    }
    return labelList;
  }

  Future<LanguageList> getMdms(Map body) async {
    late LanguageList languageList;
    var res = await makeRequest(
        url: ApiEndPoints.MDMS,
        body: body,
        method: RequestType.POST,
        storeResponseInDb: true,
        headers: {
          'serviceType': ServiceType.coreService
              .toString()
              .split('.')
              .last
        },
        requestInfo: RequestInfo(
            APIConstants.API_MODULE_NAME,
            APIConstants.API_VERSION,
            APIConstants.API_TS,
            "_search",
            APIConstants.API_DID,
            APIConstants.API_KEY,
            APIConstants.API_MESSAGE_ID,
            ""));
    if (res != null) {
      languageList = LanguageList.fromJson(res);
    }
    return languageList;
  }

  // Future<List<FileStore>> uploadFiles(
  //     List<dynamic>? _paths, String moduleName) async {
  //   Map? respStr;
  //   var commonProvider = Provider.of<CommonProvider>(
  //       navigatorKey.currentContext!,
  //       listen: false);
  //
  //   var postUri = Uri.parse("$apiBaseUrl${Url.FILE_UPLOAD}");
  //   var request = new http.MultipartRequest("POST", postUri);
  //   if (_paths != null && _paths.isNotEmpty) {
  //     if (_paths is List<PlatformFile>) {
  //       for (var i = 0; i < _paths.length; i++) {
  //         var path = _paths[i];
  //         var fileName = '${path.name}.${path.extension?.toLowerCase()}';
  //         http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
  //             'file', path.bytes!,
  //             contentType: CommonMethods().getMediaType(fileName),
  //             filename: fileName);
  //         request.files.add(multipartFile);
  //       }
  //     } else if (_paths is List<File>) {
  //       _paths.forEach((file) async {
  //         request.files.add(await http.MultipartFile.fromPath('file', file.path,
  //             contentType: CommonMethods().getMediaType(file.path),
  //             filename: '${file.path.split('/').last}'));
  //       });
  //     }else if(_paths is List<CustomFile>){
  //       for (var i = 0; i < _paths.length; i++) {
  //         var path = _paths[i];
  //         var fileName = '${path.name}.${path.extension.toLowerCase()}';
  //         http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
  //             'file', path.bytes,
  //             contentType: CommonMethods().getMediaType(fileName),
  //             filename: fileName);
  //         request.files.add(multipartFile);
  //       }
  //     }
  //     request.fields['tenantId'] =
  //         commonProvider.userDetails!.selectedtenant!.code!;
  //     request.fields['module'] = moduleName;
  //     await request.send().then((response) async {
  //       if (response.statusCode == 201)
  //         respStr = json.decode(await response.stream.bytesToString());
  //     });
  //     if (respStr != null && respStr?['files'] != null) {
  //       return respStr?['files']
  //           .map<FileStore>((e) => FileStore.fromJson(e))
  //           .toList();
  //     }
  //   }
  //   return <FileStore>[];
  // }
  //
  // Future<List<FileStore>?> fetchFiles(List<String> storeId) async {
  //   List<FileStore>? fileStoreIds;
  //   var commonProvider = Provider.of<CommonProvider>(
  //       navigatorKey.currentContext!,
  //       listen: false);
  //
  //   var res = await makeRequest(
  //       url:
  //           '${Url.FILE_FETCH}?tenantId=${commonProvider.userDetails!.selectedtenant!.code!}&fileStoreIds=${storeId.join(',')}',
  //       method: RequestType.GET);
  //
  //   if (res != null) {
  //     fileStoreIds = res['fileStoreIds']
  //         .map<FileStore>((e) => FileStore.fromJson(e))
  //         .toList();
  //   }
  //   return fileStoreIds;
  // }
  //
  // Future<String?> urlShotner(String inputUrl) async {
  //   Map<String, String> header = {
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };
  //   try {
  //     var response = await http.post(
  //         Uri.parse(apiBaseUrl + '${Url.URL_SHORTNER}'),
  //         headers: header,
  //         body: jsonEncode({"url": inputUrl}));
  //
  //     if (response.body != null) {
  //       return response.body;
  //     }
  //   } catch (e, s) {
  //     ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e);
  //   }
  // }
  //
  // Future<PDFServiceResponse?> getFileStorefromPdfService(body, params) async {
  //   var languageProvider = Provider.of<LanguageProvider>(
  //       navigatorKey.currentContext!,
  //       listen: false);
  //   PDFServiceResponse? pdfServiceResponse;
  //   try {
  //     var commonProvider = Provider.of<CommonProvider>(
  //         navigatorKey.currentContext!,
  //         listen: false);
  //     var res = await makeRequest(
  //       url: '${Url.FETCH_FILESTORE_ID_PDF_SERVICE}',
  //       body: body,
  //       queryParameters: params,
  //       method: RequestType.POST,
  //       requestInfo: RequestInfo(
  //           APIConstants.API_MODULE_NAME,
  //           APIConstants.API_VERSION,
  //           APIConstants.API_TS,
  //           "_create",
  //           APIConstants.API_DID,
  //           APIConstants.API_KEY,
  //           "string|" + languageProvider.selectedLanguage!.value!,
  //           commonProvider.userDetails!.accessToken),
  //     );
  //
  //     if (res != null) {
  //       pdfServiceResponse = PDFServiceResponse.fromJson(res);
  //       return pdfServiceResponse;
  //     }
  //   } catch (e, s) {
  //     ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e);
  //   }
  // }
  //
  // Future<EventsList?> fetchNotifications(params) async {
  //   EventsList? eventsResponse;
  //   try {
  //     var commonProvider = Provider.of<CommonProvider>(
  //         navigatorKey.currentContext!,
  //         listen: false);
  //
  //     var res = await makeRequest(
  //         url: Url.FETCH_EVENTS,
  //         method: RequestType.POST,
  //         body: {},
  //         queryParameters: params,
  //         requestInfo: RequestInfo(
  //             APIConstants.API_MODULE_NAME,
  //             APIConstants.API_VERSION,
  //             APIConstants.API_TS,
  //             "_search",
  //             APIConstants.API_DID,
  //             APIConstants.API_KEY,
  //             APIConstants.API_MESSAGE_ID,
  //             commonProvider.userDetails!.accessToken));
  //
  //     if (res != null) {
  //       eventsResponse = EventsList.fromJson((res));
  //
  //       return eventsResponse;
  //     }
  //   } catch (e, s) {
  //     ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e);
  //   }
  // }
  //
  // Future<bool?> updateNotifications(events) async {
  //   EventsList? eventsResponse;
  //   try {
  //     var commonProvider = Provider.of<CommonProvider>(
  //         navigatorKey.currentContext!,
  //         listen: false);
  //
  //     var res = await makeRequest(
  //         url: Url.UPDATE_EVENTS,
  //         method: RequestType.POST,
  //         body: events,
  //         requestInfo: RequestInfo(
  //             APIConstants.API_MODULE_NAME,
  //             APIConstants.API_VERSION,
  //             APIConstants.API_TS,
  //             "_update",
  //             APIConstants.API_DID,
  //             APIConstants.API_KEY,
  //             APIConstants.API_MESSAGE_ID,
  //             commonProvider.userDetails!.accessToken));
  //
  //     if (res != null) {
  //       return true;
  //     }
  //     else {
  //       return false;
  //     }
  //   } catch (e, s) {
  //     ErrorHandler().allExceptionsHandler(navigatorKey.currentContext!, e);
  //   }
  // }
  //
  // Future<bool?> fileDownload(BuildContext context, String url,
  //     [String? fileName]) async {
  //   if (url.contains(',')) {
  //     url = url.split(',').first;
  //   }
  //
  //   fileName = fileName ?? CommonMethods.getExtension(url);
  //   try {
  //     var downloadPath;
  //     if (kIsWeb) {
  //       html.AnchorElement anchorElement = new html.AnchorElement(href: url);
  //       anchorElement.download = url;
  //       anchorElement.target = '_blank';
  //       anchorElement.click();
  //       return true;
  //     } else if (Platform.isIOS) {
  //       downloadPath = (await getApplicationDocumentsDirectory()).path;
  //     } else {
  //       downloadPath = (await getExternalStorageDirectory())?.path;
  //     }
  //     var status = await Permission.storage.status;
  //     if (!status.isGranted) {
  //       await Permission.storage.request();
  //     }
  //     final response = await FlutterDownloader.enqueue(
  //       url: url,
  //       savedDir: downloadPath,
  //       fileName: '$fileName',
  //       showNotification: true,
  //       openFileFromNotification: true,
  //     );
  //     if (response != null) {
  //       return true;
  //     }
  //     return false;
  //   } catch (e, s) {
  //     ErrorHandler().allExceptionsHandler(context, e);
  //   }
  // }
  //
  // Future<String?> submitFeedBack(Map body) async {
  //   var response = await makeRequest(
  //       url: Url.POST_PAYMENT_FEEDBACK, body: body, method: RequestType.POST);
  //   return response;
  // }
}
