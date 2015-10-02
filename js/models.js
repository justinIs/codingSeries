var userProfile;
function loadLeaderBoardData() {
  userProfile = new UserProfile();
  //return $.when(easyQuestions.fetch(), mediumQuestions.fetch(), hardQuestions.fetch());
}

var UserProfile = Backbone.Model.extend({
  defaults: {
    username: 'user'
  },
  initialize: function () {
    this.loggedIn = true;
  },
  isLoggedIn: function () {
    return this.loggedIn;
  },
  username: function () {
    return this.get('username');
  }
});

userProfile = new UserProfile();

var Question = Backbone.Model.extend({
  initialize: function () {
    var difficulty = 'easy';
    if (this.get('points') == 3) difficulty = 'medium';
    else if (this.get('points') == 9) difficulty = 'hard';
  },
  submit: function () {
    // TODO: post submit
    return {
      then: function (cb) {
        this.trigger('questionResponse', {status: 'correct'});

        if (typeof cb === 'function') cb();
      }
    }
  },
  isCorrect: function () {
    //this.set('questionStatus', 'incorrect');
    return false;
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

var allQuestions = $.get('http://159.203.3.189/api/index.php/challenges');
var allAttempts = $.get('http://159.203.3.189/api/index.php/attempts');
//var allAttempts = $.get('http://159.203.3.189/api/index.php/attempts/user/'+userProfile.username());

var easyQuestions = new Questions();
var mediumQuestions = new Questions();
var hardQuestions = new Questions();

$.when(allQuestions, allAttempts).done(function (questionsResponse, attemptsResponse) {
  if (questionsResponse[1] === 'success' && attemptsResponse[1] === 'success' && questionsResponse[0].error === undefined) {
    questionsResponse[0].forEach(function (rawQuestion) {
      var question = new Question(rawQuestion);
      if (attemptsResponse[0].error === undefined) {
        var currentAttempt = _.find(attemptsResponse[0], function (attempt) {
          return attempt.challenge == rawQuestion.id;
        });
        if (currentAttempt) {
          question.set('questionStatus', currentAttempt.points == question.get('points') ? 'correct' : 'incorrect');
        } else {
          question.set('questionStatus', 'unanswered');
        }
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