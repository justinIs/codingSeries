var AppView = Marionette.LayoutView.extend({
  className: 'row',
  template: util.template('app-view'),
  regions: {
    questions: '#questions',
    leaderboard: '#leaderboard'
  },
  initialize: function () {
    this.listenTo(userProfile, 'questionResponse', this.render);
  },
  onRender: function () {
    $('#application').append(this.el);
    if (userProfile.isLoggedIn()) {
      this.showChildView('questions', new QuestionSetView());
      var $loginul = $('#loginView').find('ul');
      $loginul.empty();
      $('#userTitle').text(userProfile.username());
    } else {
      new LogInView().render();
    }
  }
});

var LogInView = Marionette.ItemView.extend({
  template: false,
  el: '#loginView',
  ui: {
    username: '#username',
    password: '#password',
    submit: '#submitLogin'
  },
  events: {
    'keyup input': 'handleKeyup',
    'click #submitLogin': 'submitLogin'
  },
  handleKeyup: function (e) {
    if (e.keyCode === 13) {
      this.submitLogin();
    }
  },
  submitLogin: function () {
    var username = this.ui.username.val(), password = this.ui.password.val();
    if ((username && username.length > 0) && (password && password.length)) {
      var userInfo = {
        username: username.trim(),
        password: password
      };
      $.get('http://codingseries.xyz/api/index.php/users/username/' + userInfo.username).then(function (response) {
        if (response.length === 1 && response[0].username === userInfo.username && response[0].password === userInfo.password) {
          userInfo.id = response[0].id;
          userProfile.loginSuccess(userInfo);
        }
      });
    } else {
      alert('please enter a username and/or password');
    }
  }
});

var QuestionSetView = Marionette.LayoutView.extend({
  className: 'row',
  template: function () {
    return util.renderTemplate('question-set', {
      score: easyQuestions.score() + mediumQuestions.score() + hardQuestions.score()
    });
  },
  regions: {
    easyQuestions: '#easyQuestions',
    mediumQuestions: '#mediumQuestions',
    hardQuestions: '#hardQuestions'
  },
  initialize: function () {
    this.listenTo(userProfile, 'questions-loaded', this.render);
  },
  onRender: function () {
    this.showChildView('easyQuestions', new QuestionsView({collection: easyQuestions,
      model: easyQuestions.questionManager('Easy')}));
    this.showChildView('mediumQuestions', new QuestionsView({collection: mediumQuestions,
      model: mediumQuestions.questionManager('Medium')}));
    this.showChildView('hardQuestions', new QuestionsView({collection: hardQuestions,
      model: hardQuestions.questionManager('Hard')}));
  }
});

var QuestionModal = Marionette.ItemView.extend({
  id: 'base-modal',
  className: 'modal fade',
  template: util.template('question-modal'),
  ui: {
    fileinput: '#fileinput',
    dismissModal: '#dismissModal',
    errors: '.errors',
    errorMessages: '#errorMessages',
    sourceCode: '#sourceFile',
    outputFile: '#outputFile'
  },
  events: {
    'hidden': 'teardown',
    'click .nope': 'noped',
    'click .submit': 'submitFiles',
    'click .close': 'noped',
    'change @ui.fileinput': 'submitFiles'
  },
  initialize: function () {
    this.render();
  },
  submitFiles: function (e) {
    this.ui.errorMessages.empty();
    this.ui.errors.hide();

    var sourceCode = this.ui.sourceCode.val();
    var outputFile = this.ui.outputFile.val();

    if (!sourceCode) {
      this.ui.errorMessages.append('<p>Source code missing!</p>');
    }
    if (!outputFile) {
      this.ui.errorMessages.append('<p>Output missing!</p>');
    }
    var self = this;
    if (!sourceCode || !outputFile) {
      this.ui.errors.show();
      $('.modal-body').scrollTop($(document).height()*3);
    } else {
      this.model.set('source', sourceCode);
      this.model.set('output', outputFile);
      this.model.submit().then(function () {
        self.teardown();
      });
    }
  },
  yepd: function () {
    this.ui.fileinput.click();
  },
  noped: function () {
    this.teardown();
  },
  show: function() {
    this.$el.modal('show');
  },
  teardown: function() {
    this.ui.dismissModal.click();
  },
  onRender: function () {
    $('body').append(this.el);
    if (this.model.get('questionStatus') === 'correct') {

    }
    this.$el.modal({show: false});
    this.show();
  }
});

var QuestionView = Marionette.ItemView.extend({
  className: 'question col-sm-2',
  template: util.template('question'),
  events: {
    'click': 'showQuestion'
  },
  modelEvents: {
    'questionResponse': 'render'
  },
  showQuestion: function () {
    new QuestionModal({model: this.model});
  }
});

var QuestionsView = Marionette.CompositeView.extend({
  className: 'container questions-view',
  template: util.template('questions'),
  childView: QuestionView,
  childViewContainer: '.questions'
});