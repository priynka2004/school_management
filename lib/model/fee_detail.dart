class FeeDetail {
  final int id;
  final String session;
  final String name;
  final String month;
  final String fee;
  final String totalFee;
  final String transportFee;
  final String payableFee;
  final String paidAmount;
  final String mode;
  final String date;
  final String balance;

  FeeDetail({
    required this.id,
    required this.session,
    required this.name,
    required this.month,
    required this.fee,
    required this.totalFee,
    required this.transportFee,
    required this.payableFee,
    required this.paidAmount,
    required this.mode,
    required this.date,
    required this.balance,
  });

  factory FeeDetail.fromJson(Map<String, dynamic> json) {
    return FeeDetail(
      id: json['ID'] ?? 0,
      session: json['Session'] ?? '',
      name: json['Name'] ?? '',
      month: json['Month'] ?? '',
      fee: json['Fee'] ?? '',
      totalFee: json['TotalFee'] ?? '',
      transportFee: json['TransportFee'] ?? '',
      payableFee: json['PayableFee'] ?? '',
      paidAmount: json['PaidAmount'] ?? '',
      mode: json['Mode'] ?? '',
      date: json['Date'] ?? '',
      balance: json['Balance'] ?? '',
    );
  }

  @override
  String toString() => "$name ($month - $session)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FeeDetail && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
