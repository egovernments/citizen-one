class ConsumerDetails {
  int? id;
  String? consumerName;
  String? fatherName;
  int? mobileNumber;
  String? serviceTYpe;
  String? connectionType;

  ConsumerDetails(
      {this.id,
        this.consumerName,
        this.fatherName,
        this.mobileNumber,
        this.serviceTYpe,
        this.connectionType});

  ConsumerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consumerName = json['consumerName'];
    fatherName = json['fatherName'];
    mobileNumber = json['mobileNumber'];
    serviceTYpe = json['serviceTYpe'];
    connectionType = json['connectionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consumerName'] = this.consumerName;
    data['fatherName'] = this.fatherName;
    data['mobileNumber'] = this.mobileNumber;
    data['serviceTYpe'] = this.serviceTYpe;
    data['connectionType'] = this.connectionType;
    return data;
  }
}
