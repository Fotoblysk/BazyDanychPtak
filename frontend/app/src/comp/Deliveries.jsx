import React, { Component } from "react";
import { withRouter } from "react-router";
import PropTypes from "prop-types";
import {Row, Col, Pager, Table, Modal, Button } from "react-bootstrap";

class ProductDetails extends Component {

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
		<li>Nr.: 1</li>
		<li>Czas dostarczenia: 10:00 2018-01-22</li>
		<li>Zamówiono: 10:00 2018-01-20</li>
		<li>Pozostało: 1d 0h</li>
            </ul>
            Produkty: 
            <ul className="tableLeft">
              <li><span className="link blue">Ogórki</span> - 2kg</li>
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

class Deliveries extends Component {
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
            <Button bsStyle="info" >Dodaj dostawe</Button>
	    </div>
	    </div>
	    <ProductDetails hide={this.hideDetails} details={this.state.details}/>
			<Table responsive hover>
				<thead className="tableLeft">
					<tr>
						<th>Nr.</th>
						<th>Czas dostarczenia</th>
						<th>Zamówiono</th>
						<th>Pozostało</th>
					</tr>
				</thead>
				<tbody className="tableLeft">
					<tr onClick={this.showDetails} className="link">
						<td>1</td>
						<td>10:00 2018-01-22</td>
						<td>10:00 2018-01-20</td>
						<td>1d 0h</td>
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

Deliveries.propTypes = {
  rights: PropTypes.string.isRequired,
};

export default withRouter(Deliveries);
