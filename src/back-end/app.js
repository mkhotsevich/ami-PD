const express = require('express')
const config = require('config')
const mongoose = require('mongoose')
 
const app = express()

const PORT = config.get('PORT') || process.env.PORT

async function start() {
	try {
		await mongoose.connect(
			config.get('MONGO_URI'), {
			useNewUrlParser: true
		})
		app.listen(PORT, () => console.log(`Server has been started on PORT ${PORT}...`))
	} catch (e) {
		console.log('Server error ', e.message)
		process.exit(1)
	}
}

start()