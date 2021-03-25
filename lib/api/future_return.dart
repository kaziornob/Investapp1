import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FutureReturn {
  var expected_return = 0.07;

  // # 5, 10;


  calculate(expected_return, n_years, pmt, v_0) {
    // future value function to calculate the future value of a stream of payments (pmt)
    // and initial investment (v0)
    //
    // rate = rate of return per period
    // nper = number of periods
    // pmt = investment per period (payments per period)
    // v_0 = initial value (value at time 0)
    // print(nper);
    // print(pmt);
    // print(v_0);
    var rate = pow(1 + expected_return,1/12) - 1;
    var nper = n_years*12;
    // var nper = ;
    // # 12 months per year;
    // var pmt = 1000;
    // var v_0 = 100000;
    var v_n = pmt * ((pow(1+rate, nper)-1) / rate) + v_0*pow(1+rate,nper);
    // v_n = pmt*((1+rate)**nper-1)/rate + v_0*(1+rate)**nper;
    // print(v_n);
    return v_n;
    }
}