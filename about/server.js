const { createServer } = require('http')
const { parse } = require('url')
const next = require('next')

const dev = process.env.NODE_ENV !== 'production'
const app = next({ dev })
const handle = app.getRequestHandler()

const PORT = process.env.ABOUT_SERVICE_PORT || 8080

console.log(`Will start on port: ${PORT}`)

app.prepare().then(() => {
  createServer((req, res) => {
    handle(req, res)
  }).listen(PORT, err => {
    if (err) throw err
    console.log(`> Ready on http://localhost:${PORT}`)
  })
})
