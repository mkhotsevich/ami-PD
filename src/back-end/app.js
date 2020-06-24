const express = require('express')
const config = require('config')
const mongoose = require('mongoose')
const session = require('express-session')
const flash = require('connect-flash')

const authRoutes = require('./routes/auth')

const PORT = config.get('PORT') || process.env.PORT
const app = express()

app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use(session({
	secret: config.get('SECRET'),
	resave: false,
	saveUninitialized: false
}))

app.use(flash())

app.use('/api/auth', authRoutes)


async function start() {
	try {
		await mongoose.connect(config.get('MONGODB_URI'), {
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