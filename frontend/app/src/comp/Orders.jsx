import React, { Component } from "react";
import { withRouter } from "react-router";
import {Row, Col, Pager, Table, Modal, Button } from "react-bootstrap";


class OrderDetails extends Component {

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
              <li>Nr: 1</li>
              <li>Płatność: 100zł</li>
              <li>Stan Płatności: Zrealizowano</li>
              <li>Stolik: 5</li>
              <li>Stan: Czeka na zamówienie</li>
              <li>Kwota: 100zł</li>
            </ul>
            Dania: 
            <ul className="tableLeft">
              <li className="link blue">Zupa ogórkowa</li>
              <li className="link blue">Zupa pomidorowa</li>
	    </ul>
            Przypisani pracownicy: 
            <ul className="tableLeft">
              <li className="link blue">Joanna Kowalsa</li>
              <li className="link blue">Jan Prusak</li>
	    </ul>
	    Uwagi:
            <ul className="tableLeft">
	    <li><span>brak</span></li>
	    </ul>
	    Klienci
            <ul className="tableLeft">
	    <li className="link blue">Jarosław</li>
	    </ul>
          </Modal.Body>
          <Modal.Footer>
            <Button bsStyle="success" onClick={this.props.hide}>Zrealizowano</Button>
            <Button bsStyle="primary" onClick={this.props.hide}>Płatność</Button>
            <Button bsStyle="warning" onClick={this.props.hide}>Zmień zamówienie</Button>
          </Modal.Footer>
        </Modal>
		  </div>
    );
  }
}

class Orders extends Component {
  constructor(props) {
    super(props);
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
            <Button bsStyle="info" >Dodaj zamówienie</Button>
	    </div>
	    </div>
      <OrderDetails hide={this.hideDetails} details={this.state.details}/>
			<Table responsive hover>
				<thead className="tableLeft">
					<tr>
						<th>Nr.</th>
						<th>Rachunek</th>
						<th>Stan Płatności</th>
						<th>Stolik</th>
						<th>Stan</th>
					</tr>
				</thead>
				<tbody className="tableLeft">
					<tr onClick={this.showDetails} className="link">
						<td>1</td>
						<td>100zł</td>
						<td>Zrealizowano</td>
						<td>5</td>
						<td>Czeka na zamówienie</td>
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


export default withRouter(Orders);
