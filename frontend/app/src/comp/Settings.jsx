import React, { Component } from "react";
import NaviBarNLI from "./NaviBarNLI.jsx";
import LoggingWindow from "./LoggingWindow.jsx";
import RegisterWindow from "./RegisterWindow.jsx";
import AboutWindow from "./AboutWindow.jsx";
import HomeWindow from "./HomeWindow.jsx";
import {Route} from "react-router-dom";
import {isLogged} from "../func/LoginTools.jsx";
import PropTypes from "prop-types";


class Settings extends Component {
  constructor(props) {
    super(props);
    if(isLogged())
      this.props.history.push("/li/dashboard");

    this.state = {signed: true};
  }

  render() {
    return (
      <form onSubmit={this.onSubmitClick}>
        Nowy Login:<br />
        <input type="text" name="login" onChange={this.onLoginChange} /><br />
        Nowy Email:<br />
        <input type="text" name="email" onChange={this.onEmailChange} /><br />
        Nowe Hasło:<br />
        <input type="password" name="password" onChange={this.onPasswordChange} /><br />
        Stare Hasło:<br />
        <input type="password" name="password" onChange={this.onPasswordChange} /><br />
        Powtórz Hasło:<br />
        <input type="password" name="password" onChange={this.onPasswordChange} /><br />
        <input type="submit" value="Zatwierdź" />
      </form>
    );
  }
}

Settings.propTypes = {
};

export default Settings;
