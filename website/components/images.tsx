import React from 'react'
import { CarouselProvider, Slider, Slide, Image, DotGroup } from 'pure-react-carousel'
import 'pure-react-carousel/dist/react-carousel.es.css'
import styled from '@emotion/styled'
import { Colors } from '@/styles/vars'

const slides = [
  { src: "/web-shot-1.png", alt: "Two iPhones with the Music Practice app home screen showing progress at a glance, and the theory screen showing a summary of progress with music theory." },
  { src: "/web-shot-2.png", alt: "Two iPhones showing the practice timer, and the practice feedback screen asking how the practice went." },
  { src: "/web-shot-3.png", alt: "Two iPhones showing the scales progress screen, and the songs screen with a summary of all the songs currently practiced." }
]

const Slides = slides.map((s, i) => (
  <Slide key={s.src} index={i}>
    <Image hasMasterSpinner={false} src={s.src} alt={s.alt} />
  </Slide>
))

const Buttons = styled(DotGroup)({
  position: 'absolute',
  bottom: 10,
  left: '50%',
  transform: 'translateX(-50%)',
  padding: '10px 0',
  textAlign: 'center',
  background: 'white',
  maxHeight: 20,
  display: 'flex',
  borderRadius: 20,
  button: {
    borderRadius: 10,
    padding: 0,
    height: 10,
    width: 10,
    background: Colors.Primary,
    border: 'none',
    margin: '0 10px',
    transition: 'opacity .4s ease',
    '&[disabled]': {
      opacity: .4,
      cursor: 'initial'
    }
  }
})

export const Images = () => (
  <div style={{ position: 'relative' }}>
    <CarouselProvider
      naturalSlideWidth={700}
      naturalSlideHeight={450}
      totalSlides={slides.length}
      isPlaying={true}
      infinite={true}
    >
      <Slider>
        { Slides }
      </Slider>
      <Buttons />
    </CarouselProvider>
  </div>
)
