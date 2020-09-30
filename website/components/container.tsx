import styled from "@emotion/styled"
import { maxWidth } from "@/styles/vars"

export const Container = styled.div({
  maxWidth: maxWidth,
  margin: '50px auto',
  backgroundColor: 'white',
  borderRadius: 8,
  overflow: 'hidden',
  section: {
    padding: 20,
    maxWidth: 500,
    margin: '0 auto'
  },
  '.icon': {
    display: 'block',
    height: 30,
    margin: '30px auto'
  },
  strong: {
    fontWeight: 500
  }
})


