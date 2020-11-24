import { Apple } from '@/components/apple'
import { Container } from '@/components/container'
import { CTA } from '@/components/cta'
import { Colors, smallScreen } from '@/styles/vars'
import styled from '@emotion/styled'
import React from 'react'
import { ArrowRight } from 'react-feather'
import { Images } from '@/components/images'
import { Airport } from '@/components/airport'

const HeaderSection = styled.header({
  textAlign: 'center',
  margin: '0 auto 60px',
  padding: '50px 80px',
  background: Colors.Success,
  color: 'white',
  [smallScreen]: {
    padding: '50px 30px',
    margin: '0 auto 30px'
  },
  h1: {
    fontWeight: 500,
    letterSpacing: -1,
    marginBottom: 0
  },
  h2: {
    fontWeight: 500,
    letterSpacing: -0.5,
    marginBottom: 50
  }

})

const FooterSection = styled(HeaderSection)({
  background: Colors.Primary,
  color: 'white',
  margin: '0 auto !important'
})

const RAG = styled.strong<{ color: keyof typeof Colors }>({}, props => ({
  color: Colors[props.color]
}))

const Home = () => (
  <Container>
    <HeaderSection>
      <img className="icon" src="/icon.png" />
      <h1>Music Practice</h1>
      <p style={{ marginBottom: 40 }}>A friendly assistant to help keep track of your music practice.</p>
    <CTA href="#download">
      <Apple color={Colors.Primary} style={{ marginRight: 14 }} />
      Download on the App Store
      <ArrowRight style={{ marginLeft: 14 }} size={22} />
    </CTA>
    </HeaderSection>
    <section>
      <p>I recently set myself the goal of learning piano. I&apos;m kinda familiar with music theory but my self-discipline is terrible, and I needed someone to keep track of the songs and scales I&apos;m practicing, remember how I&apos;m doing and tell me what to practice next.</p>
      <p><strong>This app does that.</strong> It will keep track of your progress so you don&apos;t have to, and it knows just enough music theory to know what you should practice next.</p>
      <p>It uses a simple rating system (<RAG color="Error">red</RAG>, <RAG color="Warning">amber</RAG>, and <RAG color="Success">green</RAG>) so you get an immediate idea of what&apos;s going well (and not so well), and even has a handy practice timer to keep you honest.</p>
    </section>
    <section className="images">
      <Images />
    </section>
    <FooterSection id="download">
      <img className="icon" src="/icon.png" />
      <h2>No frills. No shortcuts. Just you getting better at your instrument.</h2>
      <CTA style={{ opacity: .5, marginBottom: 20 }}>
        <Apple color={Colors.Primary} style={{ marginRight: 14 }} />
        Coming soon to the App Store
      </CTA>
      <CTA href="https://app.airport.community/app/reczeEl5koVpn2tPn">
        <Airport color={Colors.Primary} style={{ marginRight: 14 }} />
        Help us test on Airport
        <ArrowRight style={{ marginLeft: 14 }} size={22} />
      </CTA>
      <br />
      <a href="mailto:sam@sam@samgarson.com" style={{ margin: 30, display: 'inline-block' }}>
        Get in touch
      </a>
    </FooterSection>
  </Container>
)

export default Home
