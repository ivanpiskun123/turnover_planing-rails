import React from 'react'
import { Route, Switch } from 'react-router-dom'

import About from './Home/About'

const App = () => {
  return (
  <Switch>
    <Route exact path="/" component={About} />
  </Switch>
)
}

export default App
