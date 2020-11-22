import { useEffect } from "react"
import { useRouter } from 'next/router'
import * as Fathom from 'fathom-client'

export const useFathom = () => {
  const router = useRouter()

  useEffect(() => {
    Fathom.load('RIKVKQZN', {
      includedDomains: ['musicpractice.app'],
      url: "https://prawn.samgarson.com/script.js"
    })

    const onRouteChangeComplete = () => {
      Fathom.trackPageview()
    }

    router.events.on('routeChangeComplete', onRouteChangeComplete)

    return () => {
      router.events.off('routeChangeComplete', onRouteChangeComplete)
    }
  }, [])
}
