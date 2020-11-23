import * as React from 'react'
import { GlobalStyles } from '../styles/global'
import { AppPropsType } from 'next/dist/next-server/lib/utils'
import Head from 'next/head'
import { useFathom } from '@/analytics'
import { SmallPrint } from '@/components/small-print'

const App = ({ Component, pageProps }: AppPropsType) => {
  useFathom()

  return (
  <>
    <Head>
      <title>Music Practice: Practice your instrument</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;500&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" href="/favicon.png" />
    </Head>
    <GlobalStyles />
    <Component {...pageProps} />
    <SmallPrint />
  </>
)
}

export default App
