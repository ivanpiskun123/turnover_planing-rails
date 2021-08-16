import React from 'react'

import { Query } from 'react-apollo';
import gql from 'graphql-tag';


const AboutQuery = gql`
{
  dynamicPlanExecution(year:"2020")
    {
        monthNumber
        russianNameOfMonth
        salesSum
        salesPlan
        planComplPercent
    }
  }
`;



export default () => (
  <Query query={AboutQuery}>
    {({ data, loading }) => (
      <div>
        {loading
          ? ''
          :  data.dynamicPlanExecution.map(({  monthNumber, russianNameOfMonth, salesSum, salesPlan, planComplPercent }) => (
              <div key={ monthNumber}>
                <b>{ monthNumber}</b> {russianNameOfMonth} {salesSum} {salesPlan} {planComplPercent}

              </div>
            ))
        }
      </div>
    )}
  </Query>
);
