const express = require('express')
const config = require('config')

const app = express()

const PORT = config.get('PORT') || 5000

async function start() {
	try {
		app.listen(PORT, () => console.log(`Server has been started on PORT ${PORT}...`))
	} catch (e) {
		console.log('Server error ', e.message)
		process.exit(1)
	}
}
start()