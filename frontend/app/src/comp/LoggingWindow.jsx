import React, { Component } from "react";
import { authStore } from "../stores/authStore.jsx";
import PropTypes from "prop-types";

class LoggingWindow extends Component {

  constructor(props) {
    super(props);
    let state = {resp: "", jwt: authStore.getState().jwt};
    if(state.jwt !== "")
      state.onTopOfFormMsg = "Your session has expired please log in to continue.";
    this.state = state;
  }

  onSubmitClick = (e) => {
    e.preventDefault();
    fetch("/api/login", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        login: this.state.login,
        password: this.state.password,
      })
    }).then( (response) => {
      return response.json()
    }).then( (response) => {
      if(response.status ===  "Ok"){
        authStore.dispatch({type: "", jwt: response.tocken});
        this.setState({
          resp: response.status,
          jwt: authStore.getState().jwt
        });
        this.props.history.push("/li/dashboard");
      }else{
        authStore.dispatch({type: "", jwt: ""});
        this.setState({
          resp: response.status,
          jwt: authStore.getState().jwt
        });
      }
    });
  }

  onLoginChange = (e) => {
    this.setState({
      login: e.target.value
    });
  }

  onPasswordChange = (e) => {
    this.setState({
      password: e.target.value
    });
  }

  render() {
    return (
      <div>
        <form onSubmit={this.onSubmitClick}>
          login:<br />
          <input type="text" name="login" onChange={this.onLoginChange} /><br />
          password:<br />
          <input type="password" name="password" onChange={this.onPasswordChange} /><br />
          <input type="submit" value="Submit" />
        </form>
        {this.state.resp} <br />
        {this.state.jwt}
      </div>
    );
  }
}

LoggingWindow.propTypes = {
  history: PropTypes.object.isRequired,
};

export default LoggingWindow;
