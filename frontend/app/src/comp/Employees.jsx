import React, { Component } from "react";
import { withRouter } from "react-router";
import PropTypes from "prop-types";
import {Row, Col, Pager, Table, Modal, Button } from "react-bootstrap";


class Employees extends Component {
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
            <Button bsStyle="info" >Dodaj pracownika</Button>
	    </div>
	    </div>
	    {//      <MealsDetails hide={this.hideDetails} details={this.state.details}/>
	    }
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
