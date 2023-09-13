import 'package:money_formatter/money_formatter.dart';

extension PriceExtension on String {
  String formatPrice() {
    MoneyFormatter fmf = new MoneyFormatter(
        amount: double.parse(this),
        settings: MoneyFormatterSettings(
            symbol: 'IDR',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 2,
            compactFormatType: CompactFormatType.sort));
    return fmf.output.symbolOnLeft;
  }
}
