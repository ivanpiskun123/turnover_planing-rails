import React, { Component, Fragment } from 'react'
import { Route, Switch } from 'react-router-dom'

import Navbar from './Navbar/index'
import Provider from './Provider'
import Common from './Reports/Common'
import Home from './Home'
import DynamicPlanExecution from './Reports/DynamicPlanExecution'
import DynamicIndexedSales from './Reports/DynamicIndexedSales'
import ProductGroup from './Reports/ProductGroup'
import PaymentMethod from './Reports/PaymentMethod'
import TradeForm from './Reports/TradeForm'
import Seasonality from './Reports/Seasonality'
import AveragePrices from './Reports/AveragePrices'
import ABCProductAnalysis from './Reports/ABCProductAnalysis'

import { Grid } from 'semantic-ui-react'

class App extends Component {

  constructor(props){
    super(props);
    console.log(this.props.user_data);
    this.state = {
      user_data: this.props.user_data
    };
  }

  render(){
    return(
      <>
      <Grid>
        <Grid.Row />
        <Grid.Column width={1} />
          
        <Grid.Column width={14} >
            <Provider>
            <Navbar user_data={this.state.user_data} />
              <Switch>
                <Route exact path="/" render={() => <Home user_data={this.state.user_data}  />} />
                <Route exact path="/api/v1/years/:year" component={Common}  />
                <Route exact path="/api/v1/years/:year/dynamic-plan-execution" component={DynamicPlanExecution}  />
                <Route exact path="/api/v1/years/:year/dynamic-indexed-sales" component={DynamicIndexedSales}  />
                <Route exact path="/api/v1/years/:year/product-group-structure" component={ProductGroup}  />
                <Route exact path="/api/v1/years/:year/payment-method-structure" component={PaymentMethod}  />
                <Route exact path="/api/v1/years/:year/trade-form-structure" component={TradeForm}  />
                <Route exact path="/api/v1/years/:year/seasonality-structure" component={Seasonality}  />
                <Route exact path="/api/v1/years/:year/average-prices" component={AveragePrices}  />
                <Route exact path="/api/v1/years/:year/abc-product-analysis" component={ABCProductAnalysis}  />
              </Switch>
            </Provider>
        </Grid.Column>

          <Grid.Column width={1} />

      </Grid>

      </>
    )
  }
}

export default App
