import 'dart:math';

class FutureReturn {
  var expectedReturn = 0.07;

  calculate(expectedReturn, nYears, pmt, v_0) {
    var rate = pow(1 + expectedReturn, 1 / 12) - 1;
    var nPer = nYears * 12;

    var vN =
        pmt * ((pow(1 + rate, nPer) - 1) / rate) + v_0 * pow(1 + rate, nPer);

    return vN;
  }
}
