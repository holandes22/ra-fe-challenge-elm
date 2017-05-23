import Elm from "../src/Main.elm";

let key = "fe-ch-elm-session"
let session = window.localStorage.getItem(key);

if (session) {
  session = JSON.parse(session);
}

let elmApp = Elm.Main.embed(document.querySelector("div"), { session });

elmApp.ports.setSession.subscribe((session) => {
  window.console.log("Storing session", session);
  window.localStorage.setItem(key, JSON.stringify(session));
});

elmApp.ports.removeSession.subscribe(() => {
  window.console.log("Removing session");
  window.localStorage.removeItem(key);
});
