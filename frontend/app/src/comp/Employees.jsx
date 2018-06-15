import React, {Component} from "react";
import {withRouter} from "react-router";
import PropTypes from "prop-types";
import {Row, Col, Pager, Table, Modal, Button} from "react-bootstrap";
import {isLogged} from "../func/LoginTools.jsx";

class EmployeesDetails extends Component {

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
            <ul className="tableLeft">
              <li>Nr.: 1</li>
              <li>Imie: Jan:</li>
              <li>Drugie Imie: Adam</li>
              <li>Nazwisko: Kowalski</li>
              <li>Pensja: 2000</li>
              <li>Zatrudniono: 2017-05-11</li>
              <li>Kraj: Polska</li>
              <li>Miasto: Świdnica</li>
              <li>Ulica: Śliczna</li>
              <li>Kod Pocztowy: 11-222</li>
              <li>Rola: kelner</li>
            </ul>
            Zamówienia:
            <ul className="tableLeft">
              <li><span className="link blue">1</span><br/>Tu może bd krótki opis lub podpodpunkty</li>
              <li><span className="link blue">2</span><br/>Tu może bd krótki opis lub podpodpunkty</li>
            </ul>

            Dane logowania:
            <ul className="tableLeft">
              <li>1
                <ul className="tableLeft">
                  <li><span className="">Login</span>: jak</li>
                  <li><span className="">email</span>: tararara@example.com</li>
                </ul>
              </li>
              {//<span className="link red">&#128465; ta ikonka bd dopiero widooczna w edycji</span> </li>
              }
              <li>2 <span className="link green">&#10003;</span>

                <ul className="tableLeft">
                  <li><span className="">Login</span>: jak2</li>
                  <li><span className="">email</span>: tararara2@example.com</li>
                </ul>
              </li>
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

class Employees extends Component {
  constructor(props) {
    super(props);
    if (!isLogged())
      window.history.pushState("", "", "/nli/login"); // TODO not good
    this.state = {details: false};
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
        <Row>
          <Col xs={0} md={2}> </Col>
          <Col xs={12} md={8}>
            <div className="centerO">
              <div className="centerI">
                <Button bsStyle="info">Dodaj pracownika</Button>
              </div>
            </div>
            <EmployeesDetails hide={this.hideDetails} details={this.state.details}/>
            <Table responsive hover>
              <thead className="tableLeft">
              <tr>
                <th>Nr.</th>
                <th>Imie</th>
                <th>Drugie Imie</th>
                <th>Nazwisko</th>
                <th>Pensja</th>
                <th>Zatrudniono</th>
                <th>Kraj</th>
                <th>Miasto</th>
                <th>Ulica</th>
                <th>Kod Pocztowy</th>
                <th>Rola</th>
              </tr>
              </thead>
              <tbody className="tableLeft">
              <tr onClick={this.showDetails} className="link">
                <td>1</td>
                <td>Jan</td>
                <td>Adam</td>
                <td>Kowalski</td>
                <td>2000</td>
                <td>2017-05-11</td>
                <td>Polska</td>
                <td>Świdnica</td>
                <td>Śliczna</td>
                <td>11-222</td>
                <td>kelner</td>
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

Employees.propTypes = {
  rights: PropTypes.string.isRequired,
};

export default withRouter(Employees);
