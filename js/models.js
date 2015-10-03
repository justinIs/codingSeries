var UserProfile = Backbone.Model.extend({
  initialize: function () {
    var userInfo = Cookies.getJSON('userInfo');
    this.loggedIn = false;
    if (userInfo) {
      this.set('username', userInfo.username);
      this.set('password', userInfo.password);
      this.set('id', userInfo.id);
      this.loggedIn = true;
    }
  },
  loginSuccess: function (credentials) {
    this.set('username', credentials.username);
    this.set('password', credentials.password);
    this.set('id', credentials.id);
    Cookies.set('userInfo', credentials, {expires: 1, path: '/'});
    this.loggedIn = true;
    window.location.reload();
  },
  logout: function () {
    Cookies.remove('userInfo');
    window.location.reload();
  },
  isLoggedIn: function () {
    return this.loggedIn;
  },
  username: function () {
    return this.get('username');
  }
});
var userProfile = new UserProfile();

var Question = Backbone.Model.extend({
  initialize: function () {
    var difficulty = 'easy';
    if (this.get('points') == 3) difficulty = 'medium';
    else if (this.get('points') == 9) difficulty = 'hard';
  },
  submit: function () {
    var self = this;
    return $.post('http://codingseries.xyz/api/ndb/', {
      user_id: userProfile.get('id'),
      challenge_id: self.get('id'),
      source_file: self.get('source'),
      output_file: self.get('output')
    }).then(function (result, status) {
      if (status === "success") {
        window.location.reload();
      }
    }).fail(function () {
      self.set('questionStatus', 'incorrect');
    });
  },
  isCorrect: function () {
    return this.model.get('questionStatus') === 'correct';
  },
  sourceFileSubmitted: function () {
    return !!this.get('sourceFile')
  },
  outputFileSubmitted: function () {
    return !!this.get('outputFile')
  }
});

var Questions = Backbone.Collection.extend({
  model: Question,
  totalUnanswered: function () {
    return _.reduce(this.models, function (memo, model) {
      return memo - (model.get('questionStatus') === 'correct' ? 1 : 0);
    }, this.models.length);
  },
  score: function () {
    return _.reduce(this.models, function (memo, model) {
      return memo + (model.get('questionStatus') === 'correct' ? Number(model.get('points')) : 0);
    }, 0);
  },
  questionManager: function (difficulty) {
    var value = 1;
    if (difficulty === 'Medium') value = 3;
    else if (difficulty === 'Hard') value = 9;
    return new Backbone.Model({
      unanswered: this.totalUnanswered(),
      difficulty: difficulty,
      value: value
    });
  }
});

var easyQuestions = new Questions();
var mediumQuestions = new Questions();
var hardQuestions = new Questions();
if (userProfile.isLoggedIn()) {
  var allQuestions = $.get('http://www.codingseries.xyz/api/index.php/challenges');
  var allAttempts = $.get('http://www.codingseries.xyz/api/index.php/attempts/user/'+userProfile.get('id'));

  $.when(allQuestions, allAttempts).done(function (questionsResponse, attemptsResponse) {
    if (questionsResponse[1] === 'success' && attemptsResponse[1] === 'success' && questionsResponse[0].error === undefined) {
      questionsResponse[0].forEach(function (rawQuestion) {
        var question = new Question(rawQuestion);
        if (attemptsResponse[0].error === undefined) {
          var thisQuestionAttempts = _.filter(attemptsResponse[0], function (attempt) {
            return attempt.challenge == rawQuestion.id;
          });
          question.set('questionStatus', 'unanswered');
          thisQuestionAttempts.forEach(function (questionAttempt) {
            if (question.get('questionStatus') !== "correct")
              question.set('questionStatus', questionAttempt.points == question.get('points') ? 'correct' : 'incorrect')
          });
        } else {
          question.set('questionStatus', 'unanswered');
        }
        if (question.get('points') == 1)
          easyQuestions.add(question);
        else if (question.get('points') == 3)
          mediumQuestions.add(question);
        else
          hardQuestions.add(question);
      });
      userProfile.trigger('questions-loaded');
    }
  });
}