import React, { Component, Fragment } from 'react'
import image from '../src/home.jpg'
import { Image, Grid,  Header, Icon , Divider} from 'semantic-ui-react'

class Home extends Component {

  constructor(props){
      super(props);

      this.state = {
        is_admin: this.props.user_data.admin,
        username: this.props.user_data.name
      };

  }

  render(){
    return(
          <>
          <Grid>
            <Grid.Row />
            <Grid.Row />
            <Grid.Column width={2} />

            <Grid.Column width={13} >
                <Grid>
                    <Grid.Column width={5}>
                    <Grid.Row />
                    <Grid.Row />
                    <Grid.Row />
                    <Grid.Row />
                      <Header as='h3' style={{color: "#dbdbdb", fontFamily: "'Roboto Slab', serif" }} >
                            <Icon color='red' name='quote left' />
                      </Header>
                      <Header as='h2' style={{color: "#dbdbdb", fontFamily: "'Roboto Slab', serif" }} >

                      Здравствуйте, {
                        this.state.is_admin ? "администратор " : " "
                      } {this.state.username}!

                      </Header>

                        <Header as='h3' style={{color: "#dbdbdb", fontFamily: "'Roboto Slab', serif" }} >
                      <Divider horizontal></Divider>
                        Выберите год для получения доступа к отчётам.
                        {
                          this.state.is_admin ? " Работа с данными - в режиме администратора." : ""
                        }

                      <Divider horizontal></Divider>
                      Хорошего дня и плодотворной работы сегодня!
                      <Divider horizontal></Divider>
                      <Icon color='red' name='quote right' />

                      </Header>

                    </Grid.Column>
                    <Grid.Column width={11}>
                        <Image src={image} size='huge' circular />
                    </Grid.Column>
                  </Grid>



            </Grid.Column>

            <Grid.Column width={1} />


            </Grid>


          </>
    )
  }
}



export default Home
