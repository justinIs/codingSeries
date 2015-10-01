$(document).ready(function() {

  // Place JavaScript code here...
  var app = new Marionette.Application();
  //loadLeaderBoardData().then(function () {
  //  app.start();
  //});
  app.on('start', function () {
    new AppView().render();
  });
  app.start();
});