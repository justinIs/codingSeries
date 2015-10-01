var userProfile;
function loadLeaderBoardData() {
  userProfile = new UserProfile();
  //return $.when(easyQuestions.fetch(), mediumQuestions.fetch(), hardQuestions.fetch());
}

var UserProfile = Backbone.Model.extend({
  defaults: {
    username: 'user'
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
      return memo - (model.get('questionStatus')==='correct' ? 1 : 0);
    }, this.models.length);
  },
  score: function () {
    return _.reduce(this.models, function (memo, model) {
      return memo + (model.get('questionStatus')==='correct' ? model.get('points'):0);
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

//var allQuestions = $.get('http://justinpaulin.com/demos/dev/codingchamps/api/index.php/challenges');
//var allAttempts = $.get('http://justinpaulin.com/demos/dev/codingchamps/api/index.php/attempts');

var easyQuestions = new Questions();
var mediumQuestions = new Questions();
var hardQuestions = new Questions();
var attempts = [
  {
    "id": 1,
    "time": "2015-09-30 04:02:35",
    "user": 12,
    "challenge": 1,
    "code": "NULL",
    "output": "NULL",
    "points": 0
  },
  {
    "id": 2,
    "time": "2015-09-30 04:03:17",
    "user": 12,
    "challenge": 2,
    "code": "",
    "output": "",
    "points": 3
  },
  {
    "id": 3,
    "time": "2015-09-30 04:03:17",
    "user": 12,
    "challenge": 3,
    "code": "",
    "output": "",
    "points": 9
  }
];
var challenges = [
  {
    "id": 1,
    "points": 1,
    "title": "Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1Question 1",
    "description": "Do things",
    "input": "12341234",
    "output": "4321"
  },
  {
    "id": 2,
    "points": 3,
    "title": "Question 2",
    "description": "Do things2",
    "input": "asdfasdfasdf",
    "output": "fdsa"
  },
  {
    "id": 3,
    "points": 9,
    "title": "Question 3",
    "description": "Do things3",
    "input": "abcdabcdabcd",
    "output": "dcba"
  },
  {
    "id": 4,
    "points": 3,
    "title": "12",
    "description": "One more time",
    "input": "We're gona celebrate",
    "output": ""
  },
  {
    "id": 5,
    "points": 1,
    "title": "Question 1",
    "description": "Do things",
    "input": "12341234",
    "output": "4321"
  },
  {
    "id": 6,
    "points": 3,
    "title": "Question 2",
    "description": "Do things2",
    "input": "asdfasdfasdf",
    "output": "fdsa"
  },
  {
    "id": 7,
    "points": 9,
    "title": "Question 3",
    "description": "Do things3",
    "input": "abcdabcdabcd",
    "output": "dcba"
  },
  {
    "id": 8,
    "points": 3,
    "title": "12",
    "description": "One more time",
    "input": "We're gona celebrate",
    "output": ""
  },
  {
    "id": 9,
    "points": 1,
    "title": "Question 1",
    "description": "Do things",
    "input": "12341234",
    "output": "4321"
  },
  {
    "id": 10,
    "points": 3,
    "title": "Question 2",
    "description": "Do things2",
    "input": "asdfasdfasdf",
    "output": "fdsa"
  },
  {
    "id": 11,
    "points": 9,
    "title": "Question 3",
    "description": "Do things3",
    "input": "abcdabcdabcd",
    "output": "dcba"
  },
  {
    "id": 12,
    "points": 9,
    "title": "New One",
    "description": "One more time",
    "input": "We're gona celebrate",
    "output": ""
  }
];

_.forEach(challenges, function (challenge) {
  var question = new Question(challenge);
  var currentAttempt = _.find(attempts, function (attempt) {
    return attempt.challenge == challenge.id;
  });
  if (currentAttempt) {
    question.set('questionStatus', currentAttempt.points == question.get('points') ? 'correct':'incorrect');
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

//$.when(allQuestions, allAttempts).done(function (questions, attempts) {
//  debugger;
//});