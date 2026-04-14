// // lib/models/payment_model.dart
 
// // ── Initiate Payment ───────────────────────────────────────────
// class InitiatePaymentModel {
//   final bool status;
//   final String checkoutUrl;
//   final String tracker;
//   final String paymentId;
 
//   InitiatePaymentModel({
//     required this.status,
//     required this.checkoutUrl,
//     required this.tracker,
//     required this.paymentId,
//   });
 
//   factory InitiatePaymentModel.fromJson(Map<String, dynamic> json) {
//     return InitiatePaymentModel(
//       status: json['status'] ?? false,
//       checkoutUrl: json['checkout_url'] ?? '',
//       tracker: json['tracker'] ?? '',
//       paymentId: json['payment_id'] ?? '',
//     );
//   }
// }
 
// // ── Verify Payment ─────────────────────────────────────────────
// class VerifyPaymentModel {
//   final bool status;
//   final String paymentStatus; // paid | pending | cancelled
 
//   VerifyPaymentModel({
//     required this.status,
//     required this.paymentStatus,
//   });
 
//   factory VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
//     return VerifyPaymentModel(
//       status: json['status'] ?? false,
//       paymentStatus: json['payment_status'] ?? 'pending',
//     );
//   }
 
//   bool get isPaid => paymentStatus.toLowerCase() == 'paid';
//   bool get isPending => paymentStatus.toLowerCase() == 'pending';
//   bool get isCancelled => paymentStatus.toLowerCase() == 'cancelled';
// }
 
// // ── Payment Status ─────────────────────────────────────────────
// class PaymentStatusModel {
//   final bool status;
//   final String message;
//   final PaymentStatusData? data;
 
//   PaymentStatusModel({
//     required this.status,
//     required this.message,
//     this.data,
//   });
 
//   factory PaymentStatusModel.fromJson(Map<String, dynamic> json) {
//     return PaymentStatusModel(
//       status: json['status'] ?? false,
//       message: json['message'] ?? '',
//       data: json['data'] != null
//           ? PaymentStatusData.fromJson(json['data'])
//           : null,
//     );
//   }
// }
 
// class PaymentStatusData {
//   final String paymentId;
//   final String status; // paid | pending | cancelled
//   final int amount;
//   final String currency;
//   final String createdAt;
//   final String updatedAt;
 
//   PaymentStatusData({
//     required this.paymentId,
//     required this.status,
//     required this.amount,
//     required this.currency,
//     required this.createdAt,
//     required this.updatedAt,
//   });
 
//   factory PaymentStatusData.fromJson(Map<String, dynamic> json) {
//     return PaymentStatusData(
//       paymentId: json['payment_id'] ?? '',
//       status: json['status'] ?? 'pending',
//       amount: (json['amount'] as num?)?.toInt() ?? 0,
//       currency: json['currency'] ?? 'PKR',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//     );
//   }
 
//   bool get isPaid => status.toLowerCase() == 'paid';
//   bool get isPending => status.toLowerCase() == 'pending';
//   bool get isCancelled => status.toLowerCase() == 'cancelled';
 
//   /// Amount in actual currency units (API returns paisa — divide by 100)
//   double get displayAmount => amount / 100;
// }
 

// lib/models/payment_model.dart

// ── Initiate Payment ───────────────────────────────────────────
class InitiatePaymentModel {
  final bool status;
  final String checkoutUrl;
  final String tracker;
  final String paymentId;

  InitiatePaymentModel({
    required this.status,
    required this.checkoutUrl,
    required this.tracker,
    required this.paymentId,
  });

  factory InitiatePaymentModel.fromJson(Map<String, dynamic> json) {
    return InitiatePaymentModel(
      status: json['status'] ?? false,
      checkoutUrl: json['checkout_url'] ?? '',
      tracker: json['tracker'] ?? '',
      paymentId: json['payment_id'] ?? '',
    );
  }
}

// ── Verify Payment ─────────────────────────────────────────────
class VerifyPaymentModel {
  final bool status;
  final String paymentStatus; // paid | pending | cancelled

  VerifyPaymentModel({
    required this.status,
    required this.paymentStatus,
  });

  factory VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentModel(
      status: json['status'] ?? false,
      paymentStatus: json['payment_status'] ?? 'pending',
    );
  }

  bool get isPaid => paymentStatus.toLowerCase() == 'paid';
  bool get isPending => paymentStatus.toLowerCase() == 'pending';
  bool get isCancelled => paymentStatus.toLowerCase() == 'cancelled';
}

// ── Payment Status ─────────────────────────────────────────────
class PaymentStatusModel {
  final bool status;
  final String message;
  final PaymentStatusData? data;

  PaymentStatusModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatusModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? PaymentStatusData.fromJson(json['data'])
          : null,
    );
  }
}

class PaymentStatusData {
  final String paymentId;
  final String status; // paid | pending | cancelled
  final int amount;
  final String currency;
  final String createdAt;
  final String updatedAt;

  PaymentStatusData({
    required this.paymentId,
    required this.status,
    required this.amount,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentStatusData.fromJson(Map<String, dynamic> json) {
    return PaymentStatusData(
      paymentId: json['payment_id'] ?? '',
      status: json['status'] ?? 'pending',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      currency: json['currency'] ?? 'PKR',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  bool get isPaid => status.toLowerCase() == 'paid';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  /// Amount in actual currency units (API returns paisa — divide by 100)
  double get displayAmount => amount / 100;
}

 











































































































