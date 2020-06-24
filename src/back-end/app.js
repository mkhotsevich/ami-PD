const express = require('express')
const config = require('config')
const mongoose = require('mongoose')
const session = require('express-session')
const MongoStore = require('connect-mongodb-session')(session)

const authRoutes = require('./routes/auth')

const PORT = config.get('PORT') || process.env.PORT
const app = express()
const store = new MongoStore({
	collection: 'sessions',
	uri: config.get('MONGODB_URI')
})
app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use(session({
	secret: config.get('SECRET'),
	resave: false,
	saveUninitialized: false,
	store
}))


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