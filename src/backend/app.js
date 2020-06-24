const express = require('express')
const mongoose = require('mongoose')
const helmet = require('helmet')
const compression = require('compression')
const morgan = require('morgan')

const keys = require('./keys/index')
const authRoutes = require('./routes/auth')

const PORT = process.env.PORT || 5000

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(express.text())
app.use(express.json({ type: 'application/json' }))


app.use(helmet())
app.use(compression())

app.use('/api/auth', authRoutes)

if (process.env.NODE_ENV !== 'test') {
	app.use(morgan('combined'));
}

async function start() {
	try {
		await mongoose.connect(keys.MONGODB_URI, {
			useNewUrlParser: true,
			useUnifiedTopology: true
		})
		app.listen(PORT, () => console.log(`Server has been started on PORT ${PORT}...`))
	} catch (e) {
		console.log('Server error ', e.message)
		process.exit(1)
	}
}

start()

module.exports = app