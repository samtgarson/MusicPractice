import * as React from 'react'
import { GlobalStyles } from '../styles/global'
import { AppPropsType } from 'next/dist/next-server/lib/utils'
import Head from 'next/head'

const App = ({ Component, pageProps }: AppPropsType) => (
  <>
    <Head>
      <title>Music Practice: Practice your instrument</title>
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500&display=swap" rel="stylesheet" />
    </Head>
    <GlobalStyles />
    <Component {...pageProps} />
  </>
)

export default App
