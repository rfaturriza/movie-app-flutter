
// String formatPrice(int priceInCents) {
//   // Create a NumberFormat instance for currency formatting
//   NumberFormat currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
//
//   // Convert price from cents to dollars
//   double priceInDollars = priceInCents / 100.0;
//
//   // Format the price as a currency string
//   return currencyFormat.format(priceInDollars);
// }

import 'package:intl/intl.dart';

extension IntExt on int? {
  String formatPrice() {
    if (this == null) return '';
    // Create a NumberFormat instance for currency formatting
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    // Format the price as a currency string
    return currencyFormat.format(this!);
  }

  String afterDiscount(double? discountPercentage) {
    if (this == null) return '';
    if (discountPercentage == null) return '';
    final priceAfterDiscount = this! - (this! * (discountPercentage/100));
    return priceAfterDiscount.formatPrice();
  }
}

extension DoubleExt on double? {
  String formatPrice() {
    if (this == null) return '';
    // Create a NumberFormat instance for currency formatting
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    // Format the price as a currency string
    return currencyFormat.format(this!);
  }

  String afterDiscount(double? discountPercentage) {
    if (this == null) return '';
    if (discountPercentage == null) return '';
    final priceAfterDiscount = this! - (this! * discountPercentage);
    return priceAfterDiscount.formatPrice();
  }
}
