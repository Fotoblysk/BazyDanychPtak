import React, { Component } from "react";
import "../css/NaviBar.css";
import PropTypes from "prop-types";
import { Navbar, Nav, NavItem } from "react-bootstrap";
import { LinkContainer } from "react-router-bootstrap";
import { logOut } from "../func/LoginTools.jsx";

class NaviButtonLIGenerator extends Component {
  render() {
    const buttons = this.props.buttons.map((button, i) => 
          <LinkContainer key={i} to={button.route}>
            <NavItem key={i}>{button.txt}</NavItem>
          </LinkContainer>
          );
    return ( 
        <Nav>
          {buttons}
        </Nav>
    );
  }
}

class NaviBarLI extends Component {

  getButtons = (rights) => {
    switch (rights) {
        case "menager": {
          return [
            {txt: "Zamówienia", route: "/li/orders"}, {txt: "Dania", route: "/li/meals"},
            {txt: "Pracownicy", route: "/li/employees"}, {txt: "Dostawy", route: "/li/deliveries"},
            {txt: "Magazyn", route: "/li/warehouses"}
          ];
        }
        case "kucharz": {
          return [
            {txt: "Zamówienia", route: "/li/orders"}, {txt: "Dania", route: "/li/meals"},
            {txt: "Dostawy", route: "/li/deliveries"}, {txt: "Magazyn", route: "/li/warehouses"}
          ];
        }
        case "kelner": {
          return [
            {txt: "Zamówienia", route: "/li/orders"}, {txt: "Dania", route: "/li/meals"}
          ];
        }
    }
  }

  render() {
    const buttons = this.getButtons(this.props.rights);
    return (
      <div>
        <Navbar inverse collapseOnSelect>
            <Navbar.Header>
              <Navbar.Brand>
                <LinkContainer to={"/li"}>
                  <a>Lokal w domu</a>
                </LinkContainer>
              </Navbar.Brand>
              <Navbar.Toggle />
            </Navbar.Header>
            <Navbar.Collapse>
              <NaviButtonLIGenerator buttons={buttons} />
            <Nav pullRight>
            <LinkContainer to={"/nli/"} onClick={logOut}>
              <NavItem>LogOut</NavItem>
            </LinkContainer>
            </Nav>
            </Navbar.Collapse>
          </Navbar>
      </div>
    );
  }
}

NaviBarLI.propTypes = {
  rights: PropTypes.string.isRequired,
};

export default NaviBarLI;
