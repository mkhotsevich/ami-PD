const express = require('express')
const mongoose = require('mongoose')
const session = require('express-session')
const MongoStore = require('connect-mongodb-session')(session)

const keys = require('./keys')
const authRoutes = require('./routes/auth')

const PORT = process.env.PORT || 5000

const app = express()

const store = new MongoStore({
	collection: 'sessions',
	uri: config.get('MONGODB_URI')
})

app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use(session({
	secret: keys.SECRET,
	resave: false,
	saveUninitialized: false,
	store
}))


app.use('/api/auth', authRoutes)


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