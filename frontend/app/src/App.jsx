import React, { Component } from "react";
import "./App.css";
import {BrowserRouter, Route} from "react-router-dom";
import NLIApp from "./comp/NLIApp.jsx";
import LIApp from "./comp/LIApp.jsx";


class App extends Component {
  constructor(props) {
    super(props);
    this.state = {signed: true};
    if(window.location.pathname === "/")  // TODO not good
      window.history.pushState("", "", "/nli"); // TODO not good
  }

  render() {
    return (
      <BrowserRouter>
        <div className="App">
          <Route path="/nli" component={NLIApp} />
          <Route path="/li" component={LIApp} />
        </div>
      </BrowserRouter>
    );
  }
}

export default App;
