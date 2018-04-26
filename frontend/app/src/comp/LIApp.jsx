import React, { Component } from "react";
import NaviBarLI from "./NaviBarLI.jsx";
import {Route} from "react-router-dom";
import {isLogged} from "../func/LoginTools.jsx";
import PropTypes from "prop-types";
import Orders from "./Orders.jsx";
import Meals from "./Meals.jsx";
import Employees from "./Employees.jsx";
import Deliveries from "./Deliveries.jsx";
import Warehouses from "./Warehouses.jsx";


class LIApp extends Component {
  constructor(props) {
    super(props);
    if(!isLogged())
      this.props.history.push("/nli/login");

    this.state = {signed: true};
  }

  render() {
//    const rights = "menager"; // Change this to response depended;
    const rights = "kucharz"; // Change this to response depended;
    return (
      <div className="App">
      <NaviBarLI rights={rights}/>
        <Route exact path="/li/orders" render={()=><Orders rights={rights} />} />
        <Route exact path="/li/meals" render={()=><Meals rights={rights} />} />
        <Route exact path="/li/employees" render={()=><Employees rights={rights} />} />
        <Route exact path="/li/deliveries" render={()=><Deliveries rights={rights} />} />
        <Route exact path="/li/warehouses" render={()=><Warehouses rights={rights} />} />
      </div>
    );
  }
}

LIApp.propTypes = {
  history: PropTypes.object.isRequired,
};

export default LIApp;
