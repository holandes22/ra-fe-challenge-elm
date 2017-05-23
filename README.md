# FE challenge


This is an implementation in Elm-lang of the challenge

# Running the app in dev

You need the following installed in your system:

- nodejs 6+ https://nodejs.org/en/download/
- yarn https://yarnpkg.com/lang/en/docs/install/
- elm https://guide.elm-lang.org/install.html

After cloning the repo:
```
$ cd ra-fe-challenge-elm
$ yarn install
$ yarn start
```

Yarn start will run the webpack-dev-server and precompile all the necessary
files (elm, ES6, sass, etc)


The app will be served at http://localhost:8080/ (or a higher port if that is in
use)

# Building the app

The build system uses webpack as build pipeline. You can build the app with:

```
$ yarn build
```

the dist output will be located under the `build` folder.


# Overview of the app

The notes below are to explain the layout of the project and the architecture of
the main App (Elm).

## Layout

- src: contains all the Elm source code. Code is compile in webpack using the
  elm-webpack-loader
- app: contains js (ES6) and sass files as well as the HTML template where the
  bundled assets are injected. All the files here are transpiled using their
  respective webpack loaders. The `app.js` contains the entry point for the elm app
  (where it is embeded and passed down the initial parameters), as well as the `ports`
  to interact with LocalStorage
- public: static assets such as pics (only one in this case)
- root folder: config files mostly such as yarn.lock, package.json, elm-package.json, etc


## Frontend (Elm app)

The fronted is a typical Elm app, that cleanly separates 3 main parts

- **Model**: holds the state of the app
- **Update**: handles events to modify the state
- **View**: represents the state as HTML

The source code lives under `src` and has the following modules:

- *Main.elm*     main entry point to wire up the app. Subscriptions to listen to
  mouse events are set here (this is used to implement Drag and Drop
  functionality)
- *Model.elm*    the data structure holding the entire app state
- *Msg.elm*      messages definitions to be passed to the update function,
  representing interactive events
- *Types.elm*    type aliases to convey a clearer meaning of the data structures
- *Update.elm*   the update function handling the messages such as request to
  Login or update the position of an element
- *View.elm*     functions that help represent the state as HTML
- *Ports.elm*    functions to deal with LocalStorage on the javascript side

There is no real need to break down the app into several modules but this helps
with organization and readability.
