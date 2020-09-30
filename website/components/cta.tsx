import styled from "@emotion/styled"
import { Colors } from "@/styles/vars"

export const CTA = styled.a<{ outlined?: boolean }>({}, props => ({
  color: Colors.Primary,
  borderRadius: 50,
  padding: '12px 24px',
  background: 'white',
  fontWeight: 500,
  textDecoration: 'none',
  letterSpacing: -0.5,
  display: 'inline-flex',
  alignItems: 'center',
  border: props.outlined ? `1px solid ${Colors.Primary}` : ''
}))

