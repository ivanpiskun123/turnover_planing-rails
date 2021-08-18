import React, { Component, Fragment } from 'react'

import { Query } from 'react-apollo';
import gql from 'graphql-tag';

import { LineChart, PieChart } from 'react-chartkick'
import 'chartkick/chart.js'

// const CommonQuery = gql`
// {
//   dynamicPlanExecution(year:"2020")
//     {
//         monthNumber
//         russianNameOfMonth
//         salesSum
//         salesPlan
//         planComplPercent
//     }
//   }
// `;

class ABCProductAnalysis extends Component {

  constructor(props){
    super(props);

    console.log(this.props)

  }


  render(){
    return(
      <>
      <div>
        Hello, World! ABCABC
      </div>

      </>
    )
  }
}



export default ABCProductAnalysis
// <Query query={CommonQuery}>
//   {({ data, loading }) => (
//     <div>
//       {loading
//         ? ''
//         :  data.dynamicPlanExecution.map(({  monthNumber, russianNameOfMonth, salesSum, salesPlan, planComplPercent }) => (
//             <div key={ monthNumber}>
//               <b>{ monthNumber}</b> {russianNameOfMonth} {salesSum} {salesPlan} {planComplPercent}
//             </div>
//           ))
//       }
//       <LineChart data={data} />
//     </div>
//   )}
// </Query>
