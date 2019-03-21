export default function Error() {
  return <h1>Home Service Error</h1>
}

Error.getInitialProps = ({ res, err }) => {
  const statusCode = res ? res.statusCode : err ? err.statusCode : null
  return { statusCode }
}
