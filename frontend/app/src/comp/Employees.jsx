import React, { Component } from "react";
import { withRouter } from "react-router";
import PropTypes from "prop-types";


class Employees extends Component {

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
      </div>
    );
  }
}

Employees.propTypes = {
  rights: PropTypes.string.isRequired,
};

export default withRouter(Employees);
