var AppView = Marionette.LayoutView.extend({
  className: 'row',
  template: util.template('app-view'),
  regions: {
    questions: '#questions',
    leaderboard: '#leaderboard'
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
    password: '#password'
  },
  events: {
    'keyup input': 'handleKeyup'
  },
  handleKeyup: function (e) {
    if (e.keyCode === 13) {
      this.submitLogin();
    }
  },
  submitLogin: function () {
    var username = this.ui.username.val(), password = this.ui.password.val();
    if ((username && username.length > 0) && (password && password.length())) {
      $.post('/sessions', {
        username: username,
        password: password
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
    errorMessages: '#errorMessages'
  },
  events: {
    'hidden': 'teardown',
    'click .nope': 'noped',
    'click .submit': 'yepd',
    'click .close': 'noped',
    'change @ui.fileinput': 'submitFiles'
  },
  initialize: function () {
    this.render();
  },
  submitFiles: function (e) {
    this.ui.errorMessages.empty();
    this.ui.errors.hide();

    var sourceFileRgx = /q(.*)\.[^\.out$].*/gi;
    var files = e.target.files;
    var outputFileRgx = /q(.*)\.out$/g;
    var sourceFile = this.model.sourceFileSubmitted(), outputFile = this.model.outputFileSubmitted();
    var self = this;
    var iterateOver = files.length === 2 ? ['0', '1'] : ['0'];
    _.forEach(iterateOver, function (index) {
      var file = files[index];
      var matched = sourceFileRgx.exec(file.name);
      if (matched && !sourceFile) {
        if (matched[1] == self.model.get('id')) {
          sourceFile = true;
          self.model.set('sourceFile', file);
        } else {
          alert('Your source file id (' + matched[1] + ') doesn\'t match the question\'s id (' + self.model.get('id')
            + ')');
        }
        return;
      }
      matched = outputFileRgx.exec(file.name);
      if (matched && !outputFile) {
        if (matched[1] == self.model.get('id')) {
          outputFile = true;
          self.model.set('outputFile', file);
        } else {
          alert('Your output file id (' + matched[1] + ') doesn\'t match the question\'s id (' + self.model.get('id')
            + ')');
        }
      }
    });
    if (!sourceFile) {
      this.$el.find('#source-file').show();
      this.ui.errorMessages.append('<p>You need to resubmit your source file</p>');
    }
    if (!outputFile) {
      this.ui.errorMessages.append('<p>You need to resubmit your output file</p>');
      this.$el.find('#output-file').show();
    }
    if (!sourceFile || !outputFile) this.ui.errors.show();
    else this.model.submit().then(function () {
      self.teardown();
    });
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
  className: 'question col-sm-3',
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