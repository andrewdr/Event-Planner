const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const db = require('./queries')
const port = 3000

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {
  response.json({ info: 'Node.js, Express, and Postgres API' })
})

app.get('/eventinfo', db.getEvents)
app.get('/eventinfo/:id', db.getEventsById)
app.post('/eventinfo', db.createEvent)
app.put('/eventinfo/:id', db.updateEvent)
app.delete('/eventinfo/:id', db.deleteEvent)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})