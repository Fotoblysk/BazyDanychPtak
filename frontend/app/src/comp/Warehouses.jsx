import React, {Component} from "react";
import {withRouter} from "react-router";
import PropTypes from "prop-types";
import {Row, Col, Pager, Table, Modal, Button} from "react-bootstrap";
import {isLogged} from "../func/LoginTools.jsx";

class DeliveryDetails extends Component {

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <Modal show={this.props.details} onHide={this.props.hide}>
          <Modal.Header closeButton>
            <Modal.Title>Szczegóły zamówienia</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            Dane:
            <ul>
              <li>Nr: 1</li>
              <li>Nazwa produktu: Jabłka</li>
              <li>Ilość: 2 - kg</li>
            </ul>
            Dostawy z tym produktem:
            <ul className="tableLeft">
              <li><span className="link blue">1.</span></li>
              <ul className="tableLeft">
                <li>Nr: 2</li>
                <li>Czas dostarczenia</li>
                <li>Ilość produktu w dostawie: 10 - kg</li>
              </ul>
            </ul>

          </Modal.Body>
          <Modal.Footer>
            <Button bsStyle="warning" onClick={this.props.hide}>Zmień</Button>
            <Button bsStyle="danger" onClick={this.props.hide}>Usuń</Button>
          </Modal.Footer>
        </Modal>
      </div>
    );
  }
}

class Warehouses extends Component {
  constructor(props) {
    super(props);
    this.state = {details: false};
    if (!isLogged())
      window.history.pushState("", "", "/nli/login"); // TODO not good
  }

  showDetails = () => {
    this.setState({details: true});
  }

  hideDetails = () => {
    this.setState({details: false});
  }

  render() {
    return (
      <div>
        <Button bsStyle="info">Dodaj produkt</Button>
        <Row>
          <Col xs={0} md={2}> </Col>
          <Col xs={12} md={8}>
            <div className="centerO">
              <div className="centerI">
              </div>
            </div>
            <DeliveryDetails hide={this.hideDetails} details={this.state.details}/>
            <Table responsive hover>
              <thead className="tableLeft">
              <tr>
                <th>Nazwa produktu</th>
                <th>Ilość</th>
              </tr>
              </thead>
              <tbody className="tableLeft">
              <tr onClick={this.showDetails} className="link">
                <td>Jabłka</td>
                <td>2 - kg</td>
              </tr>
              </tbody>
            </Table>
            <Pager>
              <Pager.Item disabled previous href="#">
                Previous
              </Pager.Item>
              <Pager.Item disabled next href="#">
                Next
              </Pager.Item>
            </Pager>
          </Col>
          <Col xs={0} md={2}> </Col>
        </Row>
      </div>
    );
  }
}

Warehouses.propTypes = {
  rights: PropTypes.string.isRequired,
};

DeliveryDetails.propTypes = {
  details: PropTypes.bool.isRequired
};

export default withRouter(Warehouses);
