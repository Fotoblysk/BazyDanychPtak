import React, { Component } from "react";
import { withRouter } from "react-router";
import { Table, Modal, Button } from "react-bootstrap";


class OrderDetails extends Component {

  constructor(props) {
    super(props);
  }
  
  render() {
    return (
		<div>
  <Modal show={this.props.details} onHide={this.props.hide}>
          <Modal.Header closeButton>
            <Modal.Title>Modal heading</Modal.Title>
          </Modal.Header>
          <Modal.Body>
			<Table responsive hover>
				<thead className="tableLeft">
					<tr>
						<th>#</th>
						<th>Dania</th>
						<th>Płatność</th>
						<th>Stan Płatności</th>
						<th>Stolik</th>
						<th>Stan</th>
					</tr>
				</thead>
				<tbody className="tableLeft">
					<tr>
						<td>1</td>
						<td>Zupa ogórkowa</td>
						<td>100zł</td>
						<td>Zrealizowano</td>
						<td>5</td>
						<td>Czeka na zamówienie</td>
					</tr>
				</tbody>
			</Table>
     </Modal.Body>
          <Modal.Footer>
            <Button onClick={this.props.hide}>Close</Button>
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
      <OrderDetails hide={this.hideDetails} details={this.state.details}/>
			<Table responsive hover>
				<thead className="tableLeft">
					<tr onClick={this.showDetails}>
						<th>#</th>
						<th>Dania</th>
						<th>Płatność</th>
						<th>Stan Płatności</th>
						<th>Stolik</th>
						<th>Stan</th>
					</tr>
				</thead>
				<tbody className="tableLeft">
					<tr>
						<td>1</td>
						<td>Zupa ogórkowa</td>
						<td>100zł</td>
						<td>Zrealizowano</td>
						<td>5</td>
						<td>Czeka na zamówienie</td>
					</tr>
				</tbody>
			</Table>
		</div>
    );
  }
}


export default withRouter(Orders);
