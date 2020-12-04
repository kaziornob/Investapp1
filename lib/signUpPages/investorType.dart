import 'package:auro/signUpPages/piEmpStatus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as AppTheme;


class InvestorType extends StatefulWidget {
  @override
  _InvestorTypeState createState() => _InvestorTypeState();
}

class _InvestorTypeState extends State<InvestorType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1.1,
            decoration: new BoxDecoration(
              color: AppTheme.Colors.backgroundColor,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0,left: 5.0,right: 5.0,bottom: 5.0),
                  child: new Image(
                      width: 300.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/login_logo.png')),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.25,
                  child:  Container(
                      margin: EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0,left: 70.0,right: 50.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFfec20f),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "Accredited Investor",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "WorkSansBold"),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PiEmpStatus(parentFrom: 'Accredited Investor')));
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:10.0,left: 35.0,right: 5.0,bottom: 15.0),
                            child: new Column(
                              children: <Widget>[
                                DefaultTextStyle.merge(
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: .4,
                                    ),
                                    child: Scrollbar(
                                      child: ReadMoreText(
                                        'Net worth > 1 million, either individually, or jointly with your spouse '
                                            'Net worth > 1 million, either individually, or jointly with your spouse'
                                            'Net worth > 1 million, either individually, or jointly with your spouse',
                                        trimLines: 1,
                                        colorClickableText: Colors.orange,
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: '...See more',
                                        trimExpandedText: ' See less',
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.25,
                  child: Container(
                      margin: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5.0,bottom: 10.0,left: 70.0,right: 50.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFfec20f),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "Retail Investor",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "WorkSansBold"),
                              ),
                              onPressed: () async {

                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top:5.0, left: 30.0,bottom: 5.0,right: 5.0),
                              child: Text(
                                '(select this option if you do not meet the criterion of Accredited Investor defined above And are not a student)',
                                style: new TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    color: Color(0xFFFFFFFF), fontSize: 16.0,
                                    letterSpacing: 0.2
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.25,
                  child: Container(
                      margin: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(top: 45.0,bottom: 5.0,left: 70.0,right: 50.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFFfec20f),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "Student",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "WorkSansBold"),
                              ),
                              onPressed: () async {

                              },
                            ),
                          ),
                        ],
                      )
                  ),
                ),

              ],
            ),
          ),
        ],

      ),
    );
  }
}

enum TrimMode {
  Length,
  Line,
}

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
      this.data, {
        Key key,
        this.trimExpandedText = ' read less',
        this.trimCollapsedText = ' ...read more',
        this.colorClickableText,
        this.trimLength = 240,
        this.trimLines = 2,
        this.trimMode = TrimMode.Length,
        this.style,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.textScaleFactor,
        this.semanticsLabel,
      })  : assert(data != null),
        super(key: key);

  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color colorClickableText;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final double textScaleFactor;
  final String semanticsLabel;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale =
        widget.locale ?? Localizations.localeOf(context, nullOk: true);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).accentColor;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;


        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                    (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return RichText(
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          //softWrap,
          overflow: TextOverflow.clip,
          //overflow,
          textScaleFactor: textScaleFactor,
          text: textSpan,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}