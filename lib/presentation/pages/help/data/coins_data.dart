class CoinsData {
  static const Map<String, List<Map<String, String>>> investmentTrackRecord = {
    "data": [
      {"title": "Weekly Return >33bps", "sign": "", "coins": "500"},
      {"title": "Weekly Return >50bps", "sign": "", "coins": "1000"},
      {"title": "Weekly Return >75bps", "sign": "", "coins": "1500"},
      {"title": "Weekly Return >1%", "sign": "", "coins": "2000"},
      {"title": "Monthly Return >1%", "sign": "", "coins": "500"},
      {"title": "Monthly Return >2%", "sign": "", "coins": "1000"},
      {"title": "Monthly Return >3%", "sign": "", "coins": "1500"},
      {"title": "Monthly Return >4%", "sign": "", "coins": "2000"},
      {"title": "Quarterly Return >5%", "sign": "", "coins": "1000"},
      {"title": "Quarterly Return >10%", "sign": "", "coins": "1500"},
      {"title": "Quarterly Return >15%", "sign": "", "coins": "2000"},
      {"title": "Annual Return >15%", "sign": "", "coins": "1500"},
      {"title": "Annual Return >20%", "sign": "", "coins": "2000"},
      {"title": "Annual Return >30%", "sign": "", "coins": "3000"},
      {"title": "Annual Return >40%", "sign": "", "coins": "4000"},
      {"title": "Annual Return >50%", "sign": "", "coins": "5000"},
      {
        "title": "Sharpe Ratio >1,Annual return >15",
        "sign": "",
        "coins": "2000"
      },
      {"title": "Sharpe Ratio <05", "sign": "*", "coins": "-1500"},
      {"title": "Sharpe Ratio >2, Return >15%", "sign": "*", "coins": "3000"},
      {"title": "Sharpe Ratio >1, Return >20%", "sign": "*", "coins": "4000"},
      {"title": "Sharpe Ratio >2, Return >20%", "sign": "*", "coins": "5000"}
    ],
    "note": [
      {
        "sign": "*",
        "note":
            "These rewards are only earned when Portfolio has been managed for for more than 3 Years"
      }
    ]
  };

  static const Map<String, List<Map<String, String>>> investmentStockPitch = {
    "data": [
      {"title": "Approve Long", "sign": "", "coins": "500"},
      {
        "title": "1 Year Long Target Price Achieved (+-3%)",
        "sign": "*",
        "coins": "1500"
      },
      {
        "title": "1 Year Short Target Price Achieved (+-3%)",
        "sign": "",
        "coins": "2500"
      },
      {"title": "1 Year Long Loses Money", "sign": "", "coins": "-1500"},
      {"title": "1 Year Short Loses Money", "sign": "", "coins": "-1500"},
      {"title": "1 Year Revenue Achieved (+-3%)", "sign": "", "coins": "1500"},
      {"title": "1 Year EPS Achieved (+-3%)", "sign": "", "coins": "2000"},
      {
        "title": "Investment Thesis Peer Review -True",
        "sign": "**",
        "coins": "2000"
      },
      {
        "title": "Investment Thesis Peer Review -False",
        "sign": "#",
        "coins": "-1000"
      },
      {
        "title": "Closing a Loss-Making Long Trade Before 1 Year",
        "sign": "",
        "coins": "-1000"
      },
      {
        "title": "Closing a Loss-Making Short Trade Before 1 Year",
        "sign": "",
        "coins": "-500"
      },
      {
        "title": "Breaching Max Drawdown on Long",
        "sign": "##",
        "coins": "-2000"
      },
      {
        "title": "Breaching Max Drawdown on Short",
        "sign": "^",
        "coins": "-1000"
      }
    ],
    "note": [
      {"sign": "*", "note": "Minimum return of 15%"},
      {"sign": "**", "note": "Atleast 10 reviews,  >50% True"},
      {"sign": "#", "note": "Atleast 10 reviews,  <50% True"},
      {"sign": "##", "note": "Value falls by more than 50%"},
      {"sign": "^", "note": "Value goes up by more than 50%"}
    ]
  };
  static const Map<String, List<Map<String, String>>> investmentQA = {
    "data": [
      {"title": "Ask a Question", "sign": "", "coins": "0"},
      {"title": "Answer a Question", "sign": "", "coins": "1"},
      {"title": "Answer a Question with Video", "sign": "", "coins": "25"},
      {"title": "Question is Upvoted", "sign": "", "coins": "1"},
      {"title": "Answer is Upvoted", "sign": "*", "coins": "3"},
      {"title": "Answer with Highest Net Score", "sign": "**", "coins": "25"},
      {"title": "Comments Added to Above answer", "sign": "", "coins": "1"},
      {
        "title": "Answer is Marked Accepted (Bounty)",
        "sign": "",
        "coins": "50-500"
      },
      {"title": "Award a Bounty for Answer", "sign": "", "coins": "50-500"},
      {
        "title": "Award a Bounty for Chat Room",
        "sign": "",
        "coins": "500-5000"
      },
      {
        "title": "Bounty Awarded to Your Answer",
        "sign": "",
        "coins": "Full Bounty"
      },
      {
        "title": "If Bounty Owner Does not Award",
        "sign": "",
        "coins": "Half Bounty"
      },
      {"title": "Question is Voted Down", "sign": "", "coins": "-1"},
      {"title": "Answer is Downvoted", "sign": "#", "coins": "-1"},
      {"title": "Answer is Voted Down", "sign": "##", "coins": "-5"},
      {
        "title": "One of Your Posts Recieves 6 Flags",
        "sign": "",
        "coins": "-100"
      },
      {"title": "Your Comment Receieves a Like", "sign": "", "coins": "1"},
      {"title": "Your Comment Receieves a Dislike", "sign": "", "coins": "-1"},
      {
        "title": "10+ Dislikes.Downvotes in a Month",
        "sign": "",
        "coins": "Q/A Removed"
      },
      {"title": "Sharpe ratio >2, Return > 20%", "sign": "", "coins": "5000"}
    ],
    "note": [
      {
        "sign": "*",
        "note": "If it is not the highest upvoted answer as given below"
      },
      {"sign": "**", "note": "Net Score = number of upvotes-downvotes"},
      {"sign": "#", "note": "If it is not answer with lowest score as below"},
      {
        "sign": "##",
        "note":
            "Only for answer with lowest net score and if there are more than 5 answers to the question"
      }
    ]
  };
  static const Map<String, List<Map<String, String>>> enagagement = {
    "data": [
      {"title": "Referring a Friend", "sign": "", "coins": "100"},
      {"title": "Daily Login Bonus", "sign": "", "coins": "1"},
      {"title": "Weekly Login Bonus", "sign": "", "coins": "10"},
      {"title": "Go Pro", "sign": "", "coins": "50"},
      {
        "title": "Go Live and Make First Cash Deposite",
        "sign": "",
        "coins": "100"
      },
      {
        "title": "Raise your Question to Top of All Questions Page",
        "sign": "",
        "coins": "-500"
      },
      {
        "title": "Raise your Question to Top of Questions Page",
        "sign": "",
        "coins": "-100"
      },
      {
        "title": "Raise your Profile to Top of All Profile Page",
        "sign": "",
        "coins": "-1000"
      },
      {
        "title": "Raise your Profile to Top of Profiles Page",
        "sign": "",
        "coins": "-1000"
      }
    ],
    "note": []
  };
}
