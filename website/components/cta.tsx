import styled from "@emotion/styled"
import { Colors } from "@/styles/vars"

export const CTA = styled.a<{ outlined?: boolean, inverted?: boolean }>({}, props => ({
  color: props.inverted ? 'white' : Colors.Primary,
  borderRadius: 50,
  padding: '12px 24px',
  background: props.outlined ? 'transparent' : props.inverted ? Colors.Primary : 'white',
  fontWeight: 500,
  textDecoration: 'none',
  letterSpacing: -0.5,
  display: 'inline-flex',
  alignItems: 'center',
  border: props.outlined ? `1px solid ${props.inverted ? 'white' : Colors.Primary}` : '',
  '&::after': {
    content: 'none'
  },
  svg: {
    flexShrink: 0
  }
}))

