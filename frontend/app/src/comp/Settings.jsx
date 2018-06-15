import React, {Component} from "react";
import NaviBarNLI from "./NaviBarNLI.jsx";
import LoggingWindow from "./LoggingWindow.jsx";
import RegisterWindow from "./RegisterWindow.jsx";
import AboutWindow from "./AboutWindow.jsx";
import HomeWindow from "./HomeWindow.jsx";
import {Route} from "react-router-dom";
import {isLogged, getTocken} from "../func/LoginTools.jsx";
import PropTypes from "prop-types";


class Settings extends Component {
  constructor(props) {
    super(props);
    if (!isLogged())
      window.history.pushState("", "", "/nli/login"); // TODO not good
    this.state = {
      newlogin: "", newpassword: "", newemail: "", newpassword: "", newpassword2: "",
      oldpassword: "", localmsg: "", status: ""
    }
  }

  onSubmitClick = (e) => {
    e.preventDefault();
    if (this.state.newpassword != this.state.newpassword2)
      return;
    fetch("/api/change", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        newlogin: this.state.newlogin,
        oldlogin: this.state.oldlogin,
        oldpassword: this.state.oldpassword,
        newpassword: this.state.newpassword,
        newemail: this.state.newemail,
        tocken: getTocken(),
      })
    }).then((response) => {
      return response.json()
    }).then((response) => {
      this.setState({status: response.status});
    });
  }

  onNewLoginChange = (e) => {
    this.setState({
      newlogin: e.target.value
    });
  }

  onOldLoginChange = (e) => {
    this.setState({
      oldlogin: e.target.value
    });
  }

  onOldPasswordChange = (e) => {
    this.setState({
      oldpassword: e.target.value
    });
  }

  onNewPasswordChange = (e) => {
    let localmsg = "";
    console.log(e.target.value)
    console.log(this.state.newpassword)
    if (e.target.value != this.state.newpassword2)
      localmsg = "Hasła różnią się."
    else
      localmsg = ""
    this.setState({
      localmsg: localmsg,
      newpassword: e.target.value
    });
  }

  onNewPasswordChange2 = (e) => {
    let localmsg = "";
    if (e.target.value != this.state.newpassword)
      localmsg = "Hasla różnią się."
    else
      localmsg = ""

    this.setState({
      localmsg: localmsg,
      newpassword2: e.target.value
    });
  }

  onNewEmailChange = (e) => {
    this.setState({
      newemail: e.target.value
    });
  }

  render() {

    return (
      <div>
        <span className="red">
          {this.state.localmsg}
        </span>
        <div>
          {this.state.status}
        </div>
        <form onSubmit={this.onSubmitClick}>
          Stary Login:<br/>
          <input type="text" name="login" onChange={this.onOldLoginChange}/><br/>
          Nowy Login:<br/>
          <input type="text" name="login" onChange={this.onNewLoginChange}/><br/>
          Nowy Email:<br/>
          <input type="text" name="email" onChange={this.onNewEmailChange}/><br/>
          Stare Hasło:<br/>
          <input type="password" name="password" onChange={this.onOldPasswordChange}/><br/>
          Nowe Hasło:<br/>
          <input type="password" name="password" onChange={this.onNewPasswordChange}/><br/>
          Powtórz Nowe Hasło:<br/>
          <input type="password" name="password" onChange={this.onNewPasswordChange2}/><br/>
          <input type="submit" value="Zatwierdź" onClick={this.onSubmitClick}
                 disabled={this.state.localmsg != ""}/>
        </form>
      </div>
    );
  }
}

Settings.propTypes = {};

export default Settings;
