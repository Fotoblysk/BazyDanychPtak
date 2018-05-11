import React, { Component } from "react";
import { withRouter } from "react-router";
import {Row, Col, Pager, Table, Modal, Button } from "react-bootstrap";


class MealsDetails extends Component {

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
			<li>Nazwa: Zupa ogórkowa</li>
			<li>Cena: 8zł</li>
            </ul>
            Składniki: 
            <ul className="tableLeft">
              <li><span className="link blue">Ogórki kiszone</span>: 50 mg</li>
              <li><span className="link blue">Śmietana</span>: 1 łyżeczki</li>
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

class Meals extends Component {
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
            <Button bsStyle="info" >Dodaj danie</Button>
	    </div>
	    </div>
      <MealsDetails hide={this.hideDetails} details={this.state.details}/>
			<Table responsive hover>
				<thead className="tableLeft">
					<tr>
						<th>Nr.</th>
						<th>Nazwa</th>
						<th>Cena</th>
					</tr>
				</thead>
				<tbody className="tableLeft">
					<tr onClick={this.showDetails} className="link">
						<td>1</td>
						<td>Zupa ogórkowa</td>
						<td>8zł</td>
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


export default withRouter(Meals);
