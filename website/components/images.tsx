import React from 'react'
import { CarouselProvider, Slider, Slide, Image, DotGroup } from 'pure-react-carousel'
import 'pure-react-carousel/dist/react-carousel.es.css'
import styled from '@emotion/styled'
import { Colors } from '@/styles/vars'

const slides = [
  { src: "/web-shot-1.png", alt: "" },
  { src: "/web-shot-2.png", alt: "" },
  { src: "/web-shot-3.png", alt: "" }
]

const Slides = slides.map((s, i) => (
  <Slide key={s.src} index={i}>
    <Image hasMasterSpinner={false} src={s.src} alt={s.alt} />
  </Slide>
))

const Buttons = styled(DotGroup)({
  background: Colors.Primary,
  margin: '0 -20px',
  padding: 10,
  textAlign: 'center',
  button: {
    borderRadius: 10,
    padding: 0,
    height: 10,
    width: 10,
    background: 'white',
    border: 'none',
    margin: '0 10px',
    transition: 'opacity .4s ease',
    '&[disabled]': {
      opacity: .4
    }
  }
})

export const Images = () => (
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
)
