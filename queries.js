const Pool = require('pg').Pool
const pool = new Pool({
  user: 'epadmin',
  host: 'localhost',
  database: 'eventsdb',
  password: 'G10b2Pa&&rIY#ho',
  port: 5432,
})
const getEvents = (request, response) => {
  pool.query('SELECT * FROM eventinfo ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getEventsById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT * FROM eventinfo WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const createEvent = (request, response) => {
  const { eventname, eventdescription, eventdate, eventstarttime, eventendtime, eventvenue, eventaddress } = request.body

  pool.query('INSERT INTO eventinfo (eventname, eventdescription, eventdate, eventstarttime, eventendtime, eventvenue, eventaddress) VALUES ($1, $2, $3, $4, $5, $6, $7)', 
    [eventname, eventdescription, eventdate, eventstarttime, eventendtime, eventvenue, eventaddress], (error, results) => {
    if (error) {
      throw error
    }
    response.status(201).send(`User added with ID: ${result.insertId}`)
  })
}

const updateEvent = (request, response) => {
  const id = parseInt(request.params.id)
  const { eventname, eventdescription, eventdate, eventstarttime, eventendtime, eventvenue, eventaddress } = request.body

  pool.query(
    'UPDATE eventinfo SET eventname = $1, eventdescription = $2, eventdate = $3, eventstarttime = $4, eventendtime = $5, eventvenue =$6, eventaddress = $7  WHERE id = $8',
    [eventname, eventdescription, eventdate, eventstarttime, eventendtime, eventvenue, eventaddress, id],
    (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deleteEvent = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM eventinfo WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}

module.exports = {
  getEvents,
  getEventsById,
  createEvent,
  updateEvent,
  deleteEvent,
}