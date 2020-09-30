import { keyframes, CSSObject } from "@emotion/react"

export const stretch = keyframes({
  from: {
    fontVariationSettings: `'wdth' 100, 'wght' 0`
  },
  to: {
    fontVariationSettings: `'wdth' -80, 'wght' 0`
  }
})

export const stretchAnimation = {
  animationName: stretch,
  animationDuration: `1.5s`,
  animationFillMode: `both`,
  animationDirection: `alternate`,
  animationIterationCount: `infinite`,
  animationTimingFunction: `cubic-bezier(0.860, 0.000, 0.070, 1.000)`
}

