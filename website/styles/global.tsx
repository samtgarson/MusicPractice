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
          WebkitFontSmoothing: 'antialiased',
          MozOsxFontSmoothing: 'grayscale',
          scrollBehavior: 'smooth'
        },
        a: {
          color: 'inherit',
          position: 'relative',
          textDecoration: 'none',
            '&::after': {
              content: '""',
              position: 'absolute',
              left: 0,
              right: 0,
              bottom: 0,
              height: 1,
              backgroundColor: 'currentColor'
            }
        }
      }}
    />
  )
}
