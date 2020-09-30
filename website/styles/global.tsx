import * as React from 'react'
import { Global } from '@emotion/react'
import { Colors } from './vars'

export const GlobalStyles = () => {
  return (
    <Global
      styles={{
        'html, body': {
          backgroundColor: Colors.Background,
          color: Colors.Primary,
          fontFamily: 'Inter, sans-serif',
          fontWeight: 300,
          fontSize: '18px',
          lineHeight: 1.5,
          margin: 0,
          padding: 0,
          WebkitFontSmoothing: `antialiased`,
          MozOsxFontSmoothing: `grayscale`
        },
        a: {
          color: `inherit`
        }
      }}
    />
  )
}
