const express = require('express')
const config = require('config')
const firebase = require('firebase')
const bodyParser = require('body-parser')

const app = express()
app.use(bodyParser.json())

const PORT = config.get('PORT') || 5000

app.get('/', function (req, res) {
	console.log("HTTP Get Request");
	res.send("HTTP GET Request");
	firebase.database().ref('/TestMessages').set({ TestMessage: 'GET Request' });
});

async function start() {
	try {
		firebase.initializeApp(config.get('firebaseConfig'))
		app.listen(PORT, () => console.log(`Server has been started on PORT ${PORT}...`))
	} catch (e) {
		console.log('Server error ', e.message)
		process.exit(1)
	}
}
start()