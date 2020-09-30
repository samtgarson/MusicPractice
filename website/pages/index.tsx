import { Apple } from '@/components/apple'
import { Container } from '@/components/container'
import { CTA } from '@/components/cta'
import { Colors, maxWidth } from '@/styles/vars'
import styled from '@emotion/styled'
import React, { FunctionComponent } from 'react'
import { ArrowRight, Icon, Heart, GitHub, Twitter, Shield } from 'react-feather'

const HeaderSection = styled.header({
  textAlign: 'center',
  margin: '0 auto 60px',
  padding: '50px 80px',
  background: Colors.Success,
  color: 'white',
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
  margin: '30px auto 0'
})

const SmallPrint = styled.p({
  maxWidth: maxWidth,
  margin: '0 auto',
  display: 'flex',
  justifyContent: 'space-between',
  marginBottom: 30,
  fontSize: '0.9em',
  span: {
    display: 'inline-flex',
    alignItems: 'center'
  }
})

const DownloadButton = () => (
  <CTA href="">
    <Apple color={Colors.Primary} style={{ marginRight: 14 }} />
    Download on the App Store
    <ArrowRight style={{ marginLeft: 14 }} size={22} />
  </CTA>
)

const IconLink: FunctionComponent<{ icon: Icon, href: string }> = ({ icon: Icon, href, children }) => (
  <a href={href} style={{ display: 'inline-flex', alignItems: 'center', textDecoration: 'none', margin: '0 8px' }}>
    <Icon size={16} style={{ marginRight: 6 }}/>
    { children }
  </a>
)

const RAG = styled.strong<{ color: keyof typeof Colors }>({}, props => ({
  color: Colors[props.color]
}))

const Home = () => (
  <>
    <Container>
      <HeaderSection>
        <img className="icon" src="/icon.png" />
        <h1>Music Practice</h1>
        <p style={{ marginBottom: 40 }}>A friendly assistant to help keep track of your music practice.</p>
        <DownloadButton />
      </HeaderSection>
      <section>
        <p>I recently set myself the goal of learning piano. I&apos;m kinda familiar with music theory but my self-discipline is terrible, and I needed someone to keep track of the songs and scales I&apos;m practicing, remember how I&apos;m doing and tell me what to practice next.</p>
        <p><strong>This app does that.</strong> It will keep track of your progress so you don&apos;t have to, and it knows just enough music theory to know what you should practice next.</p>
        <p>It uses a simple rating system (<RAG color="Error">red</RAG>, <RAG color="Warning">amber</RAG>, and <RAG color="Success">green</RAG>) so you get an immediate idea of what&apos;s going well (and not so well), and even has a handy practice timer to keep you honest.</p>
      </section>
      <FooterSection>
        <img className="icon" src="/icon.png" />
        <h2>No frills. No shortcuts. Just you getting better at your instrument.</h2>
        <DownloadButton />
      </FooterSection>
    </Container>
    <SmallPrint>
      <span>Built by <IconLink icon={Heart} href="https://samgarson.com">Sam Garson</IconLink></span>
      <span>
        <IconLink icon={GitHub} href="https://github.com/samtgarson/MusicPractice">Code</IconLink>
        <IconLink icon={Twitter} href="https://twitter.com/samtgarson">Twitter</IconLink>
        <IconLink icon={Shield} href="/privacy-policy">Privacy Policy</IconLink>
      </span>
    </SmallPrint>
  </>
)

export default Home
