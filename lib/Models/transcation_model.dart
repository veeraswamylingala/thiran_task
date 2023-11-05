class Transaction {
  final String tDescription;
  final String tDateTime;
  final String tStatus;

  const Transaction({
    required this.tDescription,
    required this.tDateTime,
    required this.tStatus,
  });

  Map<String, dynamic> mapTransaction() {
    return {
      'description': tDescription,
      'status': tStatus,
      'datetime': tDateTime,
    };
  }
}
