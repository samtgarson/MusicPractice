import styled from "@emotion/styled"
import { maxWidth, smallScreen } from "@/styles/vars"

export const Container = styled.div({
  maxWidth: maxWidth,
  margin: '50px auto',
  backgroundColor: 'white',
  borderRadius: 8,
  overflow: 'hidden',
  [smallScreen]: {
    margin: '0 auto',
    borderRadius: 0
  },
  section: {
    padding: 20,
    maxWidth: 500,
    margin: '0 auto'
  },
  'section.images': {
    margin: '0 auto',
    maxWidth: 'none',
    /* background: 'linear-gradient(180deg, rgba(247,248,250,0) 0%, rgba(247,248,250,1) 100%)', */
    paddingBottom: 0
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


