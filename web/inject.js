// This script will dynamically load your Flutter web app into a sidebar container

var sidebar = document.createElement('div'); 

sidebar.id = 'flutter-sidebar';

document.body.appendChild(sidebar);



// Load your Flutter web app bundle (replace with your actual bundle path)

var script = document.createElement('script');

script.src = '/flutter_web_bundle.js';

document.body.appendChild(script);