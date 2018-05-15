import React, { Component } from "react";

class RegisterWindow extends Component {

  onSubmitClick = (e) => {
    e.preventDefault();
    fetch("/api/register", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        login: this.state.login,
        password: this.state.password,
        email: this.state.email,
      })
    });
  }

  onLoginChange = (e) => {
    this.setState({
      login: e.target.value
    });
  }

  onIdChange = (e) => {
    this.setState({
      login: e.target.value
    });
  }

  onRolaChange = (e) => {
    this.setState({
      rola: e.target.value
    });
  }

  onPasswordChange = (e) => {
    this.setState({
      password: e.target.value
    });
  }

  onEmailChange = (e) => {
    this.setState({
      email: e.target.value
    });
  }

  render() {
    return (
      <form onSubmit={this.onSubmitClick}>
          Id pracownika:<br />
          <input type="text" name="id" onChange={this.onIdChange} /><br />
        Login:<br />
        <input type="text" name="login" onChange={this.onLoginChange} /><br />
        Rola:<br />
        <input type="text" name="login" onChange={this.onRolaChange} /><br />
        Email:<br />
        <input type="text" name="email" onChange={this.onEmailChange} /><br />
        Password:<br />
        <input type="password" name="password" onChange={this.onPasswordChange} /><br />
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

export default RegisterWindow;
