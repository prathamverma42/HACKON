import React from "react";
import logo from '..../assets/logo.png';
import "bootstrap/dist/css/bootstrap.min.css";
import {
  Container,Row,Col,Button
} from "react-bootstrap";
function Home() {
    return  <Container>
    <center>
  <div>
    <Row className='mt-5'>
      <Col sm={2}></Col>
      <Col sm={6}>
      <img src={logo} width="40%" />
      </Col>
      <Col sm={2}></Col>
    </Row>
    <Row className="mt-5">
      <Col sm={2}><Button
                    size="lg"
                    variant="dark"
                  >
                    Login{" "}
                  </Button>
                  </Col>
                  <Col sm={2}>
                    <Button
                    size="lg"
                    variant="dark"
                  >
                    Sign Up{" "}
                  </Button>
                  </Col>
    </Row>
  </div>
    </center>
  </Container>
}
export default Home;