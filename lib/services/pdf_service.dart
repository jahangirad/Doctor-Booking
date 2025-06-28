import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  // এই মেথডটি মূল PDF ফাইলটি বাইট (bytes) আকারে তৈরি করবে
  Future<Uint8List> generateBookingSlip(Map<String, dynamic> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    'Appointment Booking Slip',
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 20),

                // ডেটা দেখানোর জন্য একটি হেল্পার ফাংশন ব্যবহার করা হলো
                _buildPdfRow('Booking ID:', data['slip_number']?.toString() ?? 'N/A'),
                _buildPdfRow('Patient Name:', data['patient_name'] ?? 'N/A'),
                _buildPdfRow('Patient Phone:', data['patient_phone'] ?? 'N/A'),
                pw.SizedBox(height: 15),
                pw.Divider(),
                pw.SizedBox(height: 15),
                _buildPdfRow('Doctor Name:', data['doctor_name'] ?? 'N/A'),
                _buildPdfRow('Specialty:', data['specialty'] ?? 'N/A'),
                _buildPdfRow('Appointment Date:', data['date'] ?? 'N/A'),
                _buildPdfRow('Appointment Time:', data['time'] ?? 'N/A'),
                pw.SizedBox(height: 15),
                pw.Divider(),
                pw.SizedBox(height: 15),
                _buildPdfRow('Payment Status:', data['payment_status'] ?? 'N/A'),
                if (data['pay_amount'] != null)
                  _buildPdfRow('Amount Paid:', '${data['pay_amount']} BDT'),
                if (data['trx_id'] != null)
                  _buildPdfRow('Transaction ID:', data['trx_id']),

                pw.Spacer(),
                pw.Center(
                  child: pw.Text(
                    '--- Thank you for choosing us ---',
                    style: const pw.TextStyle(color: PdfColors.grey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // PDF ফাইলটিকে বাইট হিসেবে রিটার্ন করা
    return pdf.save();
  }

  // PDF ভিউ করার জন্য
  Future<void> viewBookingSlip(Map<String, dynamic> data) async {
    try {
      final bytes = await generateBookingSlip(data);
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
    } catch (e) {
      Get.snackbar('Error', 'Could not display PDF: ${e.toString()}');
    }
  }


  // PDF এর জন্য একটি রো ডিজাইন করার হেল্পার
  pw.Widget _buildPdfRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.Text(value, style: const pw.TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}