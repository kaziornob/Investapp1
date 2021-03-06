import 'package:auroim/widgets/invest_tab/auro_star/portfolio_statistics.dart';

final List<ChartData> chartData = <ChartData>[
  ChartData(DateTime(2020, 8, 6), -0.35, -0.76, 0.41, 11760.05),
  ChartData(DateTime(2020, 8, 7), -0.31, -2.36, 2.04, 11570.89),
  ChartData(DateTime(2020, 8, 8), 0.16, -1.07, 1.22, 11723.43),
  ChartData(DateTime(2020, 8, 9), 0.18, -1.77, 1.96, 11639.71),
  ChartData(DateTime(2020, 8, 10), 0.43, 0.14, 0.29, 11866.27),
  ChartData(DateTime(2020, 8, 11), 0.57, -3.71, 4.27, 11410.88),
  ChartData(DateTime(2020, 8, 12), 0.26, -2.34, 2.60, 11573.11),
  ChartData(DateTime(2020, 8, 13), 0.80, -0.61, 1.40, 11778.21),
  ChartData(DateTime(2020, 8, 14), 3.00, -0.77, 3.76, 11759.01),
  ChartData(DateTime(2020, 8, 15), 3.38, 0.03, 3.34, 11853.95),
  ChartData(DateTime(2020, 8, 16), 3.75, 0.30, 3.46, 11885.13),
  ChartData(DateTime(2020, 8, 17), 6.45, 3.36, 3.09, 12248.17),
  ChartData(DateTime(2020, 8, 18), 5.61, 1.11, 4.50, 11982.04),
  ChartData(DateTime(2020, 8, 19), 5.33, -1.10, 6.43, 11719.61),
  ChartData(DateTime(2020, 8, 20), 10.74, -0.05, 10.78, 11844.48),
  ChartData(DateTime(2020, 8, 21), 12.37, -2.84, 15.21, 11513.73),
  ChartData(DateTime(2020, 8, 22), 14.71, -1.46, 16.17, 11677.24),
  ChartData(DateTime(2020, 8, 23), 13.77, -1.57, 15.34, 11663.63),
  ChartData(DateTime(2020, 8, 24), 12.13, -0.68, 12.81, 11769.29),
  ChartData(DateTime(2020, 8, 25), 8.36, -4.12, 12.48, 11361.94),
  ChartData(DateTime(2020, 8, 26), 9.55, -3.25, 12.80, 11465.01),
  ChartData(DateTime(2020, 8, 27), 9.45, -4.55, 13.99, 11311.19),
  ChartData(DateTime(2020, 8, 28), 8.16, -2.70, 10.86, 11530.02),
  ChartData(DateTime(2020, 8, 29), 9.40, -3.09, 12.49, 11483.83),
  ChartData(DateTime(2020, 8, 30), 10.25, -1.46, 11.71, 11677.56),
  ChartData(DateTime(2020, 8, 31), 9.62, -1.39, 11.01, 11685.65),
  ChartData(DateTime(2020, 9, 1), 12.65, 1.12, 11.53, 11983.17),
  ChartData(DateTime(2020, 9, 2), 12.07, -3.78, 15.85, 11402.14),
  ChartData(DateTime(2020, 9, 3), 3.70, -14.49, 18.19, 10133.26),
  ChartData(DateTime(2020, 9, 4), 4.26, -11.51, 15.77, 10486.35),
  ChartData(DateTime(2020, 9, 5), 3.44, -14.31, 17.76, 10154.22),
  ChartData(DateTime(2020, 9, 6), 6.44, -12.49, 18.94, 10369.72),
  ChartData(DateTime(2020, 9, 7), 6.43, -14.60, 21.03, 10119.59),
  ChartData(DateTime(2020, 9, 8), 10.79, -13.52, 24.31, 10247.89),
  ChartData(DateTime(2020, 9, 9), 10.77, -12.29, 23.07, 10393.28),
  ChartData(DateTime(2020, 9, 10), 15.59, -12.19, 27.78, 10405.25),
  ChartData(DateTime(2020, 9, 11), 19.46, -11.99, 31.45, 10428.82),
  ChartData(DateTime(2020, 9, 12), 17.03, -12.84, 29.86, 10328.86),
  ChartData(DateTime(2020, 9, 13), 19.38, -9.92, 29.30, 10674.95),
  ChartData(DateTime(2020, 9, 14), 16.09, -8.98, 25.07, 10785.72),
  ChartData(DateTime(2020, 9, 15), 17.01, -7.35, 24.37, 10978.52),
  ChartData(DateTime(2020, 9, 16), 21.15, -7.57, 28.72, 10952.87),
  ChartData(DateTime(2020, 9, 17), 21.11, -7.92, 29.04, 10911.20),
  ChartData(DateTime(2020, 9, 18), 22.68, -6.39, 29.08, 11092.44),
  ChartData(DateTime(2020, 9, 19), 22.61, -7.71, 30.33, 10935.96),
  ChartData(DateTime(2020, 9, 20), 14.90, -11.52, 26.42, 10484.92),
  ChartData(DateTime(2020, 9, 21), 14.73, -11.19, 25.92, 10524.37),
  ChartData(DateTime(2020, 9, 22), 15.25, -13.52, 28.77, 10248.40),
  ChartData(DateTime(2020, 9, 23), 24.41, -9.18, 33.59, 10762.04),
  ChartData(DateTime(2020, 9, 24), 24.32, -9.84, 34.16, 10683.89),
  ChartData(DateTime(2020, 9, 25), 30.28, -9.32, 39.60, 10745.88),
  ChartData(DateTime(2020, 9, 26), 30.95, -9.09, 40.04, 10773.09),
  ChartData(DateTime(2020, 9, 27), 37.14, -9.37, 46.50, 10740.14),
  ChartData(DateTime(2020, 9, 28), 41.91, -8.49, 50.39, 10844.39),
  ChartData(DateTime(2020, 9, 29), 41.68, -8.87, 50.55, 10799.15),
  ChartData(DateTime(2020, 9, 30), 41.92, -10.47, 52.38, 10609.79),
  ChartData(DateTime(2020, 10, 01), 40.78, -10.87, 51.64, 10562.40),
  ChartData(DateTime(2020, 10, 02), 38.58, -10.97, 49.55, 10550.15),
  ChartData(DateTime(2020, 10, 03), 38.55, -10.00, 48.55, 10664.97),
  ChartData(DateTime(2020, 10, 04), 42.54, -9.01, 51.55, 10782.64),
  ChartData(DateTime(2020, 10, 05), 37.61, -10.57, 48.18, 10597.16),
  ChartData(DateTime(2020, 10, 06), 37.60, -9.91, 47.51, 10675.75),
  ChartData(DateTime(2020, 10, 07), 38.09, -7.92, 46.01, 10911.16),
  ChartData(DateTime(2020, 10, 08), 40.57, -6.62, 47.19, 11065.05),
  ChartData(DateTime(2020, 10, 09), 45.47, -4.62, 50.09, 11302.48),
  ChartData(DateTime(2020, 10, 10), 54.23, -3.96, 58.19, 11381.27),
  ChartData(DateTime(2020, 10, 11), 54.32, -2.45, 56.77, 11559.19),
  ChartData(DateTime(2020, 10, 12), 58.40, -3.53, 61.93, 11431.50),
  ChartData(DateTime(2020, 10, 13), 56.96, -3.58, 60.54, 11425.43),
  ChartData(DateTime(2020, 10, 14), 57.57, -3.01, 60.58, 11493.87),
  ChartData(DateTime(2020, 10, 15), 57.49, -4.30, 61.79, 11340.86),
  ChartData(DateTime(2020, 10, 16), 52.55, -4.17, 56.72, 11355.99),
  ChartData(DateTime(2020, 10, 17), 56.93, -3.12, 60.05, 11480.70),
  ChartData(DateTime(2020, 10, 18), 56.77, -1.00, 57.77, 11731.46),
  ChartData(DateTime(2020, 10, 19), 59.23, 0.37, 58.86, 11894.41),
  ChartData(DateTime(2020, 10, 20), 55.33, 8.10, 47.23, 12809.78),
  ChartData(DateTime(2020, 10, 21), 68.68, 9.70, 58.98, 12999.57),
  ChartData(DateTime(2020, 10, 22), 67.53, 9.17, 58.36, 12936.62),
  ChartData(DateTime(2020, 10, 23), 68.94, 10.55, 58.39, 13100.42),
  ChartData(DateTime(2020, 10, 24), 67.25, 9.97, 57.28, 13030.96),
  ChartData(DateTime(2020, 10, 25), 66.36, 10.33, 56.02, 13074.42),
  ChartData(DateTime(2020, 10, 26), 66.37, 15.24, 51.13, 13656.48),
  ChartData(DateTime(2020, 10, 27), 70.21, 12.00, 58.21, 13272.56),
  ChartData(DateTime(2020, 10, 28), 65.13, 13.59, 51.55, 13460.31),
  ChartData(DateTime(2020, 10, 29), 65.50, 14.60, 50.89, 13580.50),
  ChartData(DateTime(2020, 10, 30), 65.40, 16.48, 48.92, 13803.46),
  ChartData(DateTime(2020, 10, 31), 67.34, 15.67, 51.67, 13706.82),
  ChartData(DateTime(2020, 11, 01), 70.38, 14.55, 55.83, 13574.23),
  ChartData(DateTime(2020, 11, 02), 66.96, 17.40, 49.56, 13912.24),
  ChartData(DateTime(2020, 11, 03), 69.64, 19.09, 50.55, 14112.12),
  ChartData(DateTime(2020, 11, 04), 69.76, 31.31, 38.45, 15559.90),
  ChartData(DateTime(2020, 11, 05), 76.82, 31.42, 45.40, 15573.74),
  ChartData(DateTime(2020, 11, 06), 78.70, 25.20, 53.50, 14836.35),
  ChartData(DateTime(2020, 11, 07), 78.79, 30.90, 47.89, 15511.11),
  ChartData(DateTime(2020, 11, 08), 93.55, 29.18, 64.37, 15307.99),
  ChartData(DateTime(2020, 11, 09), 90.62, 29.00, 61.62, 15286.19),
  ChartData(DateTime(2020, 11, 10), 90.60, 32.50, 58.10, 15700.97),
  ChartData(DateTime(2020, 11, 11), 91.58, 37.34, 54.24, 16275.08),
  ChartData(DateTime(2020, 11, 12), 96.39, 37.80, 58.59, 16329.86),
  ChartData(DateTime(2020, 11, 13), 94.19, 35.71, 58.48, 16081.11),
  ChartData(DateTime(2020, 11, 14), 89.68, 34.82, 54.86, 15976.17),
  ChartData(DateTime(2020, 11, 15), 89.73, 41.01, 48.72, 16710.02),
  ChartData(DateTime(2020, 11, 16), 94.00, 49.05, 44.95, 17662.20),
  ChartData(DateTime(2020, 11, 17), 97.12, 50.50, 46.62, 17834.15),
  ChartData(DateTime(2020, 11, 18), 96.96, 50.22, 46.74, 17800.98),
  ChartData(DateTime(2020, 11, 19), 103.23, 57.38, 45.85, 18650.00),
  ChartData(DateTime(2020, 11, 20), 119.39, 58.02, 61.37, 18725.14),
  ChartData(DateTime(2020, 11, 21), 113.70, 55.80, 57.91, 18461.74),
  ChartData(DateTime(2020, 11, 22), 128.69, 54.68, 74.01, 18329.83),
  ChartData(DateTime(2020, 11, 23), 128.84, 61.08, 67.76, 19088.35),
  ChartData(DateTime(2020, 11, 24), 144.42, 58.86, 85.57, 18824.40),
  ChartData(DateTime(2020, 11, 25), 110.17, 43.98, 66.19, 17061.60),
  ChartData(DateTime(2020, 11, 26), 110.26, 44.09, 66.17, 17074.75),
  ChartData(DateTime(2020, 11, 27), 123.89, 49.08, 74.81, 17666.44),
  ChartData(DateTime(2020, 11, 28), 124.63, 53.26, 71.37, 18161.53),
  ChartData(DateTime(2020, 11, 29), 135.39, 66.64, 68.76, 19746.40),
  ChartData(DateTime(2020, 11, 30), 134.56, 59.11, 75.44, 18854.77),
  ChartData(DateTime(2020, 12, 01), 123.99, 62.21, 61.78, 19222.17),
  ChartData(DateTime(2020, 12, 02), 130.05, 64.00, 66.05, 19433.62),
  ChartData(DateTime(2020, 12, 03), 115.40, 57.60, 57.80, 18675.55),
  ChartData(DateTime(2020, 12, 04), 120.46, 61.49, 58.98, 19136.15),
  ChartData(DateTime(2020, 12, 05), 120.47, 63.03, 57.44, 19318.64),
  ChartData(DateTime(2020, 12, 06), 120.30, 62.03, 58.27, 19200.03),
  ChartData(DateTime(2020, 12, 07), 110.05, 55.12, 54.93, 18381.72),
  ChartData(DateTime(2020, 12, 08), 112.96, 56.60, 56.36, 18557.10),
  ChartData(DateTime(2020, 12, 09), 112.99, 54.36, 58.63, 18291.49),
  ChartData(DateTime(2020, 12, 10), 106.13, 52.61, 53.52, 18084.06),
  ChartData(DateTime(2020, 12, 11), 106.05, 58.65, 47.40, 18800.22),
  ChartData(DateTime(2020, 12, 12), 113.24, 61.60, 51.64, 19149.96),
  ChartData(DateTime(2020, 12, 13), 117.64, 62.40, 55.25, 19243.85),
  ChartData(DateTime(2020, 12, 14), 119.40, 63.88, 55.52, 19419.76),
  ChartData(DateTime(2020, 12, 15), 139.00, 80.06, 58.94, 21336.92),
  ChartData(DateTime(2020, 12, 16), 152.24, 92.28, 59.96, 22784.68),
  ChartData(DateTime(2020, 12, 17), 152.36, 94.40, 57.95, 23036.86),
  ChartData(DateTime(2020, 12, 18), 162.12, 101.32, 60.80, 23856.52),
  ChartData(DateTime(2020, 12, 19), 162.05, 98.58, 63.48, 23531.34),
  ChartData(DateTime(2020, 12, 20), 149.11, 93.21, 55.89, 22895.93),
  ChartData(DateTime(2020, 12, 21), 148.90, 100.35, 48.55, 23741.30),
  ChartData(DateTime(2020, 12, 22), 147.21, 96.59, 50.62, 23295.80),
  ChartData(DateTime(2020, 12, 23), 146.93, 100.15, 46.78, 23717.67),
  ChartData(DateTime(2020, 12, 24), 154.11, 108.52, 45.58, 24710.10),
  ChartData(DateTime(2020, 12, 25), 162.25, 122.99, 39.26, 26423.83),
  ChartData(DateTime(2020, 12, 26), 178.13, 123.10, 55.04, 26436.92),
  ChartData(DateTime(2020, 12, 27), 177.57, 128.55, 49.02, 27083.03),
  ChartData(DateTime(2020, 12, 28), 186.48, 129.97, 56.52, 27250.92),
  ChartData(DateTime(2020, 12, 29), 187.92, 143.65, 44.26, 28872.84),
  ChartData(DateTime(2020, 12, 30), 199.81, 144.21, 55.60, 28938.96),
  ChartData(DateTime(2020, 12, 31), 200.29, 147.51, 52.79, 29329.45),
  ChartData(DateTime(2021, 1, 01), 202.46, 169.87, 32.59, 31979.60),
  ChartData(DateTime(2021, 1, 02), 224.71, 179.34, 45.37, 33101.63),
  ChartData(DateTime(2021, 1, 03), 240.38, 169.39, 70.99, 31922.75),
  ChartData(DateTime(2021, 1, 04), 226.27, 187.51, 38.76, 34070.20),
  ChartData(DateTime(2021, 1, 05), 239.57, 209.90, 29.67, 36723.55),
  ChartData(DateTime(2021, 1, 06), 290.76, 233.38, 57.37, 39505.86),
  ChartData(DateTime(2021, 1, 07), 292.13, 243.24, 48.89, 40674.00),
  ChartData(DateTime(2021, 1, 08), 282.45, 238.48, 43.97, 40110.03),
  ChartData(DateTime(2021, 1, 09), 302.30, 223.11, 79.18, 38289.11),
  ChartData(DateTime(2021, 1, 10), 290.68, 200.48, 90.20, 35606.42),
  ChartData(DateTime(2021, 1, 11), 254.44, 186.31, 68.13, 33927.81),
  ChartData(DateTime(2021, 1, 12), 261.49, 190.49, 71.00, 34423.10),
  ChartData(DateTime(2021, 1, 13), 273.59, 209.52, 64.07, 36678.68),
  ChartData(DateTime(2021, 1, 15), 282.31, 205.63, 76.68, 36217.19),
  ChartData(DateTime(2021, 1, 16), 288.80, 201.90, 86.90, 35774.99),
  ChartData(DateTime(2021, 1, 17), 298.13, 209.59, 88.54, 36686.24),
  ChartData(DateTime(2021, 1, 18), 300.59, 206.51, 94.08, 36321.85),
  ChartData(DateTime(2021, 1, 19), 295.16, 200.61, 94.55, 35621.90),
  ChartData(DateTime(2021, 1, 20), 242.66, 159.07, 83.60, 30699.56),
  ChartData(DateTime(2021, 1, 21), 262.03, 177.39, 84.64, 32870.73),
  ChartData(DateTime(2021, 1, 22), 270.97, 170.40, 100.57, 32041.93),
  ChartData(DateTime(2021, 1, 23), 273.92, 172.20, 101.71, 32256.19),
  ChartData(DateTime(2021, 1, 24), 265.43, 172.92, 92.50, 32341.53),
  ChartData(DateTime(2021, 1, 25), 265.85, 174.39, 91.46, 32515.47),
  ChartData(DateTime(2021, 1, 26), 241.97, 156.42, 85.55, 30385.24),
  ChartData(DateTime(2021, 1, 27), 272.30, 180.00, 92.30, 33179.98),
  ChartData(DateTime(2021, 1, 28), 300.20, 188.36, 111.84, 34170.50),
  ChartData(DateTime(2021, 1, 29), 291.94, 188.27, 103.67, 34160.00),
  ChartData(DateTime(2021, 1, 30), 293.61, 180.08, 113.53, 33188.97),
  ChartData(DateTime(2021, 1, 31), 307.08, 182.79, 124.29, 33511.16),
  ChartData(DateTime(2021, 2, 01), 321.50, 193.58, 127.92, 34789.47),
  ChartData(DateTime(2021, 2, 02), 348.44, 215.53, 132.91, 37389.86),
  ChartData(DateTime(2021, 2, 03), 340.50, 211.85, 128.66, 36953.81),
  ChartData(DateTime(2021, 2, 04), 367.49, 221.51, 145.98, 38098.84),
  ChartData(DateTime(2021, 2, 05), 377.89, 239.76, 138.12, 40262.00),
  ChartData(DateTime(2021, 2, 06), 379.58, 229.23, 150.34, 39014.32),
  ChartData(DateTime(2021, 2, 07), 419.68, 288.03, 131.64, 45981.86),
  ChartData(DateTime(2021, 2, 08), 451.31, 292.77, 158.54, 46543.44),
  ChartData(DateTime(2021, 2, 09), 463.62, 280.00, 183.62, 45030.04),
  ChartData(DateTime(2021, 2, 10), 501.97, 303.48, 198.49, 47812.54),
  ChartData(DateTime(2021, 2, 11), 530.72, 300.70, 230.02, 47482.86),
  ChartData(DateTime(2021, 2, 12), 579.13, 297.20, 281.93, 47067.94),
  ChartData(DateTime(2021, 2, 13), 553.68, 311.37, 242.31, 48747.45),
  ChartData(DateTime(2021, 2, 14), 529.76, 304.94, 224.83, 47984.95),
  ChartData(DateTime(2021, 2, 15), 534.60, 314.99, 219.61, 49175.90),
  ChartData(DateTime(2021, 2, 16), 550.78, 339.98, 210.79, 52138.04),
  ChartData(DateTime(2021, 2, 17), 580.20, 335.86, 244.34, 51649.58),
  ChartData(DateTime(2021, 2, 18), 616.49, 370.69, 245.81, 55776.19),
  ChartData(DateTime(2021, 2, 19), 612.57, 373.71, 238.86, 56134.54),
  ChartData(DateTime(2021, 2, 20), 636.08, 385.12, 250.96, 57487.04),
  ChartData(DateTime(2021, 2, 21), 598.30, 356.48, 241.82, 54092.69),
  ChartData(DateTime(2021, 2, 22), 487.39, 309.70, 177.69, 48548.96),
  ChartData(DateTime(2021, 2, 23), 518.22, 319.25, 198.97, 49681.16),
  ChartData(DateTime(2021, 2, 24), 495.37, 298.39, 196.98, 47209.54),
  ChartData(DateTime(2021, 2, 25), 486.18, 290.24, 195.93, 46243.95),
  ChartData(DateTime(2021, 2, 26), 517.61, 290.88, 226.73, 46319.70),
  ChartData(DateTime(2021, 2, 27), 486.82, 280.75, 206.07, 45119.13),
  ChartData(DateTime(2021, 2, 28), 537.35, 319.98, 217.37, 49768.16),
  ChartData(DateTime(2021, 3, 01), 525.33, 308.45, 216.87, 48401.73),
  ChartData(DateTime(2021, 3, 02), 547.04, 326.27, 220.76, 50513.15),
  ChartData(DateTime(2021, 3, 03), 528.59, 309.51, 219.09, 48526.53),
  ChartData(DateTime(2021, 3, 04), 541.61, 312.55, 229.06, 48887.58),
  ChartData(DateTime(2021, 3, 05), 542.62, 312.73, 229.89, 48908.25),
  ChartData(DateTime(2021, 3, 06), 555.64, 333.94, 221.70, 51422.10),
  ChartData(DateTime(2021, 3, 07), 566.52, 341.13, 225.40, 52273.37),
  ChartData(DateTime(2021, 3, 08), 583.65, 354.57, 229.08, 53867.02),
  ChartData(DateTime(2021, 3, 09), 586.05, 372.21, 213.84, 55956.38),
  ChartData(DateTime(2021, 3, 10), 606.70, 387.64, 219.06, 57785.25),
  ChartData(DateTime(2021, 3, 11), 590.11, 383.36, 206.75, 57278.17),
  ChartData(DateTime(2021, 3, 12), 641.16, 417.36, 223.81, 61306.62),
  ChartData(DateTime(2021, 3, 13), 625.27, 401.27, 224.00, 59400.01),
  ChartData(DateTime(2021, 3, 14), 619.43, 370.22, 249.21, 55720.69),
  ChartData(DateTime(2021, 3, 15), 625.61, 377.32, 248.29, 56562.12),
  ChartData(DateTime(2021, 3, 16), 654.51, 395.25, 259.27, 58686.73),
  ChartData(DateTime(2021, 3, 17), 635.66, 386.88, 248.78, 57694.73),
  ChartData(DateTime(2021, 3, 18), 646.46, 389.91, 256.54, 58054.71),
  ChartData(DateTime(2021, 3, 19), 654.18, 390.93, 263.26, 58174.71),
  ChartData(DateTime(2021, 3, 20), 669.84, 384.75, 285.09, 57442.36),
  ChartData(DateTime(2021, 3, 21), 628.07, 357.82, 270.25, 54252.01),
  ChartData(DateTime(2021, 3, 22), 631.02, 360.47, 270.55, 54565.83),
  ChartData(DateTime(2021, 3, 23), 599.28, 343.79, 255.49, 52588.55),
  ChartData(DateTime(2021, 3, 24), 587.51, 334.20, 253.31, 51452.50),
  ChartData(DateTime(2021, 3, 25), 638.33, 363.91, 274.42, 54973.66),
  ChartData(DateTime(2021, 3, 26), 676.57, 372.01, 304.56, 55933.04),
  ChartData(DateTime(2021, 3, 27), 683.27, 370.74, 312.53, 55782.51),
  ChartData(DateTime(2021, 3, 28), 705.78, 386.68, 319.10, 57672.14),
  ChartData(DateTime(2021, 3, 29), 724.63, 395.48, 329.15, 58714.13),
  ChartData(DateTime(2021, 3, 30), 731.79, 395.53, 336.25, 58720.86),
  ChartData(DateTime(2021, 3, 31), 750.04, 395.79, 354.25, 58751.32),
  ChartData(DateTime(2021, 4, 01), 783.31, 397.54, 385.77, 58958.75),
  ChartData(DateTime(2021, 4, 02), 724.64, 382.24, 342.40, 57146.01),
  ChartData(DateTime(2021, 4, 03), 782.96, 391.01, 391.95, 58185.01),
  ChartData(DateTime(2021, 4, 04), 854.56, 395.78, 458.78, 58750.43),
  ChartData(DateTime(2021, 4, 05), 855.88, 389.82, 466.06, 58043.49),
  ChartData(DateTime(2021, 4, 06), 793.45, 374.32, 419.13, 56207.00),
  ChartData(DateTime(2021, 4, 07), 858.62, 389.91, 468.72, 58054.00),
  ChartData(DateTime(2021, 4, 08), 850.82, 390.89, 459.92, 58171.00),
  ChartData(DateTime(2021, 4, 09), 890.90, 404.44, 486.46, 59776.00),
  ChartData(DateTime(2021, 4, 10), 902.20, 406.23, 495.97, 59988.00),
  ChartData(DateTime(2021, 4, 11), 887.09, 405.58, 481.51, 59911.00),
  ChartData(DateTime(2021, 4, 12), 924.59, 435.63, 488.96, 63472.00),
  ChartData(DateTime(2021, 4, 13), 940.89, 429.74, 511.15, 62774.00),
  ChartData(DateTime(2021, 4, 14), 972.29, 433.05, 539.25, 63166.00),
  ChartData(DateTime(2021, 4, 15), 960.59, 418.75, 541.84, 61472.00),
  ChartData(DateTime(2021, 4, 16), 959.51, 408.64, 550.87, 60274.00),
  ChartData(DateTime(2021, 4, 17), 881.83, 375.83, 506.00, 56386.00),
  ChartData(DateTime(2021, 4, 18), 823.73, 370.78, 452.94, 55788.00),
  ChartData(DateTime(2021, 4, 19), 865.45, 375.06, 490.38, 56295.00),
  ChartData(DateTime(2021, 4, 20), 867.46, 374.66, 492.80, 56247.00),
  ChartData(DateTime(2021, 4, 21), 747.51, 339.50, 408.00, 52081.00),
  ChartData(DateTime(2021, 4, 22), 725.56, 331.11, 394.45, 51087.00),
  ChartData(DateTime(2021, 4, 23), 687.04, 324.34, 362.70, 50284.00),
  ChartData(DateTime(2021, 4, 24), 678.65, 312.38, 366.27, 48867.00),
  ChartData(DateTime(2021, 4, 25), 793.56, 355.52, 438.04, 53979.00),
  ChartData(DateTime(2021, 4, 26), 844.73, 363.67, 481.05, 54945.00),
  ChartData(DateTime(2021, 4, 27), 829.56, 362.51, 467.05, 54808.00),
  ChartData(DateTime(2021, 4, 28), 826.58, 352.18, 474.40, 53583.00),
  ChartData(DateTime(2021, 4, 29), 891.76, 387.96, 503.80, 57823.00),
];