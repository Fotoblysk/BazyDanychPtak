import React, {Component} from "react";
import {withRouter} from "react-router";
import {PageHeader, Row, Col, Pager, Table, Modal, Button} from "react-bootstrap";
import {getTocken, isLogged} from "../func/LoginTools.jsx";

let statemap = {0: "zapłacono", 1: "obsłużono"};

class OrderDetails extends Component {

  constructor(props) {
    super(props);
    console.log("dupa");
    if (!isLogged())
      window.history.pushState("", "", "/nli/login"); // TODO not good
    this.state = {orderDetails: {state: "loading..."}};
  }

  getDetails = () => {
    fetch("/api/orders/details", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        tocken: getTocken(),
        id: this.props.currentId,
      })
    }).then((response) => response.json()).then((response) => {
      console.log(response);
      this.setState({orderDetails: response.details});
    });
  }

  componentDidMount() {
    if (this.props.details) {
      this.initDataUpdater = setTimeout(this.getDetails());
      this.dataUpdater = setInterval(this.getDetails, 2000);
    }
  }

  componentWillUnmount() {
    if (this.initDataUpdater)
      clearTimeout(this.initDataUpdater);
    if (this.dataUpdater)
      clearInterval(this.dataUpdater);
  }

  componentDidUpdate() {
    if (this.props.details && !this.dataUpdater) {
      this.initDataUpdater = setTimeout(this.getDetails());
      this.dataUpdater = setInterval(this.getDetails, 2000);
    } else if (!this.props.details) {
      if (this.initDataUpdater)
        clearTimeout(this.initDataUpdater);
      if (this.dataUpdater)
        clearInterval(this.dataUpdater);
    }
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
              <li>Nr: {this.props.currentId}</li>
              <li>Płatność: 100zł</li>
              <li>Stan Płatności: Zrealizowano</li>
              <li>Stolik: 5</li>
              <li>Stan: {this.state.orderDetails.state}</li>
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

class OrderLine extends Component {

  render() {
    return (
      <tr onClick={() => this.props.detailsFn(this.props.data.id)} className="link">
        <td>{this.props.data.id}</td>
        <td>{this.props.data.paid_money} / {this.props.data.bill_money}</td>
        <td>{this.props.data.table}</td>
        <td>{statemap[this.props.data.state]}</td>
        <td>{this.props.data.order_date}</td>
        <td>{this.props.data.finish_date}</td>
      </tr>
    );
  }
}

class Orders extends Component {
  constructor(props) {
    super(props);
    if (!isLogged())
      window.history.pushState("", "", "/nli/login"); // TODO not good
    this.state = {details: false, currentId: null, orderAdd: false};
  }

  componentDidMount = () => {
    this.initDataUpdater = setTimeout(this.getOrders);
    this.dataUpdater = setInterval(this.getOrders, 2000);
  }

  componentWillUnmount() {
    clearTimeout(this.initDataUpdater);
    clearInterval(this.dataUpdater);
  }

  showDetails = (id) => {
    this.setState({details: true, currentId: id});
  }

  hideDetails = () => {
    this.setState({details: false});
  }

  getOrders = () => { // TODO DRY
    fetch("/api/orders/ls", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        tocken: getTocken(),
        start: this.state.start,
        end: this.state.end,
      })
    }).then((response) => response.json()).then((response) => {
      console.log("disp");
      console.log(response.orders);
      this.setState({orders: response.orders});
    });
  }

  ordersList = (orders) => { // TODO DRY
    if (orders == undefined)
      return <tr>
        <td>loading...</td>
      </tr>
    let norders = orders.map((el) => {
      return (
        <OrderLine key={el.id} data={el}
                   detailsFn={this.showDetails}/>
      )
    })
    return norders;
  }
  orderHide = () => {
    this.setState({orderAdd: false});
  }

  render() {
    console.log(this.state.orders);
    console.log(this.state.details);
    console.log(this.state.currentId);
    return (
      <div>
        <Row>
          <Col xs={0} md={2}> </Col>
          <Col xs={12} md={8}>
            <PageHeader>Zamówienia<br/>
              <small>Przeglądanie złożonych zamówień</small>
            </PageHeader>
            <OrderDetails hide={this.hideDetails} details={this.state.details} currentId={this.state.currentId}/>
            <Table responsive hover>
              <thead className="tableLeft">
              <tr>
                <th>Nr.</th>
                <th>Stan Płatności</th>
                <th>Stolik</th>
                <th>Stan</th>
                <th>Data złożenia</th>
                <th>Data zakończenia</th>
              </tr>
              </thead>
              <tbody className="tableLeft">
              {
                // <OrderLine data={{id: 1, name: "dupa1", bill: "dupa", paymentState: "dupa", table: "dupa", state: "dupa"}}
                //     onClick={this.showDetails}/>
              }
              {this.ordersList(this.state.orders)}
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
            <div className="centerO">
              <div className="centerI">
                <Button bsStyle="info" onClick={() => this.setState({orderAdd: true})}>Dodaj zamówienie</Button>
                <Modal show={this.state.orderAdd} onHide={this.orderHide}>
                  <Modal.Header closeButton>
                    <Modal.Title>Dodawanie zamówienia</Modal.Title>
                  </Modal.Header>
                  <Modal.Body>
                    Dane:
                    <ul className="tableLeft">
                      <li>Płatność: <input type="text" name="id_pracownika" onChange={this.onBillChange}/></li>
                      <li>Stolik: <input type="text" name="id_pracownika" onChange={this.onTableChange}/></li>
                      <li>Stan: <input type="text" name="id_pracownika" onChange={this.onStateChange}/></li>
                    </ul>
                  </Modal.Body>
                  <Modal.Footer>
                    <Button bsStyle="success" onClick={this.submitOrder}>Zrealizowano</Button>
                  </Modal.Footer>
                </Modal>
              </div>
            </div>
          </Col>
          <Col xs={0} md={2}> </Col>
        </Row>
      </div>
    );
  }

  submitOrder = (e) => {
    fetch("/api/orders/add", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        tocken: getTocken(),
        newbill: this.state.newbill,
        newtable: this.state.newtable,
        newstate: this.state.newstate,
      })
    }).then((response) => response.json()).then((response) => {
      console.log(response);
      this.orderHide();
    });
  }

  onBillChange = (e) => {
    this.setState({newbill: e.target.value});
  }

  onTableChange = (e) => {
    this.setState({newtable: e.target.value});
  }

  onStateChange = (e) => {
    this.setState({newstate: e.target.value});
  }
}


export default withRouter(Orders);
