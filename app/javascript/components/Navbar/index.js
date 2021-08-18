import React, { Component } from 'react'
import { Button, Dropdown, Menu, Icon, Divider } from 'semantic-ui-react'
import { Link } from 'react-router-dom'
import styled from 'styled-components'

import { Query} from 'react-apollo';

import yearsQuery from '../../queries/yearsQuery'
import Provider from '../Provider'

import { useQuery } from 'graphql-hooks'

const reportsList = [
  "Динамика выполнения плана продаж",
  "Динамика товарооборота в сопоставимых ценах",
  "Товарно-групповая структура товарооборота",
  "Структура товарооборота по формам оплаты",
  "Структура товарооборота по формам торговли",
  "Сезонность товарооборота",
  "Средняя цена реализации товаров"
]


export default class MenuExampleSizeHuge extends Component {

  constructor(props){
    super(props);

    if(typeof this.state === 'undefined' ){
      console.log("dfdfdfdfdf");
      this.state = {
        yearState: "не выбран",
        reportName: "common",
        user_data: this.props.user_data
      };
    }
  }

  handleYearItemClick = (e, { name }) => {
            this.setState({ yearState: name });
            console.log("/years/"+name)
            window.location.href=("/api/v1/years/"+name)
  }

  handleReportItemClick = (e, { name }) => {
            this.setState({ reportName: name });
            console.log(this.state.reportName);
  }

  handleAdminClick = (e, { name }) => {
             window.location.href="/admin"
  }

  handleSignOutClick = (e, { name }) => {
             window.location.href="/users/sign_out"
  }

  handleABCClick = (e, { name }) => {
    if(this.state.yearState != "не выбран"){
        window.location.href=("/api/v1/years/"+this.state.yearState+"/abc-product-analysis")
    }
  }



  render() {


    return (
      <div>
      <Menu size='huge' style={{backgroundColor: "#282442" }}>

      <Menu.Item  name = { this.state.yearState } style={{  color: "white", fontSize: "145%", textDecoration: "underline" }}/>


        <Menu.Item>
          <Divider vertical></Divider>
        </Menu.Item>


          <Menu.Menu position='left' >
            <Dropdown item text='Год' style={{color: "white", fontSize: "120%" }}>
              <Dropdown.Menu>


                    <Query query={yearsQuery}>
                      {({ data, loading }) => (
                        <div>
                          {loading
                            ? ''
                            :  data.yearsList.map((  yearNumber, index ) => (
                              <div key={ index }>
                              <Link to={"/api/v1/years/"+yearNumber }  >
                                  <Dropdown.Item onClick={this.handleYearItemClick} name = { yearNumber+'' }  >{ yearNumber }</Dropdown.Item>
                                  </Link>
                              </div>
                              ))

                          }
                        </div>
                      )}
                    </Query>

              </Dropdown.Menu>
            </Dropdown>
          </Menu.Menu>

          <Menu.Menu position='left' >
            <Dropdown item text='Отчёты' style={{color: "#dbdbdb" }}>
              <Dropdown.Menu>

               {
                  reportsList.map((reportName, index) =>
                (
                  <div key={ index }>
                      <Dropdown.Item onClick={this.handleReportItemClick} name = { reportName }>{ reportName }</Dropdown.Item>
                  </div>
                ))
                }

              </Dropdown.Menu>
            </Dropdown>
          </Menu.Menu>

        {
          this.state.yearState != "не выбран" ?
          <Menu.Item style={{color: "#dbdbdb" }} name  = "ABC-анализ">
          <Link to={"/api/v1/years/"+this.state.yearState+"/abc-product-analysis" } style={{color: "#dbdbdb" }} >
                ABC-анализ
                  </Link>
          </Menu.Item> :

          <Menu.Item style={{color: "#dbdbdb" }} name  = "ABC-анализ">
          </Menu.Item>

        }



        <Menu.Menu position='right'>

          {
              this.state.user_data.admin ? <Menu.Item>
                 <Button  color='red' onClick={ this.handleAdminClick} icon >
                  <Link to="/admin"  style={{color: "#dbdbdb" }} ><Icon name="database"   /></Link>
                 </Button>
              </Menu.Item> : ''

          }

          <Menu.Item>
          <Button inverted color='grey' icon labelPosition='right' onClick={ this.handleSignOutClick}>
            <Link to="/users/sign_out"  > Выход </Link>
            <Icon name='right arrow' />
          </Button>
          </Menu.Item>
        </Menu.Menu>


      </Menu>

      </div>
    )
  }
}
