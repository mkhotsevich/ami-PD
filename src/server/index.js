const compression = require('compression')
const mongoose = require('mongoose')
const express = require('express')
const helmet = require('helmet')
const morgan = require('morgan')
const config = require('config')
const path = require('path')
const https = require("https")
const http = require('http')
const fs = require("fs")

const httpApp = express()
const app = express()

const HTTP_PORT = config.get('HTTP_PORT')
const HTTPS_PORT = config.get('HTTPS_PORT')

const httpsOptions = { key: fs.readFileSync("server.key"), cert: fs.readFileSync("server.crt") }

httpApp.set('port', HTTP_PORT || 80)
httpApp.get("*", (req, res) => { res.redirect("https://" + req.headers.host + "/" + req.path) })

app.set('port', HTTPS_PORT || 443)
app.enable('trust proxy')

app.use(express.json({ extended: true, type: 'application/json' }))
app.use(express.urlencoded({ extended: true }));
app.use(express.text());


app.use(helmet())
app.use(compression())

app.use('/api/auth', require('./routes/auth'))
app.use('/api/users', require('./routes/users'))
app.use('/api/history/water', require('./routes/water'))
app.use('/api/history/sleep', require('./routes/sleep'))
app.use('/api/history/weight', require('./routes/weight'))
app.use('/api/history/tasks', require('./routes/tasks'))
// app.use('/api/articles', require('./routes/articles'))
// app.use('/api/token', require('./routes/token'))
//

if (process.env.NODE_ENV !== 'test') app.use(morgan('combined'))

if (process.env.NODE_ENV === 'production') {
	app.use('/', express.static(path.join(__dirname, 'client', 'build')))
	app.get('*', (req, res) => res.sendFile(path.resolve(__dirname, 'client', 'build', 'index.html')))
}

async function start() {
	try {
		await mongoose.connect(config.get('MONGODB_URI'), {
			useNewUrlParser: true,
			useUnifiedTopology: true,
			useCreateIndex: true
		})

		http.createServer(httpApp).listen(httpApp.get('port'), function () {
			console.log('Express HTTP server listening on port ' + httpApp.get('port'));
		});

		https.createServer(httpsOptions, app).listen(app.get('port'), function () {
			console.log('Express HTTPS server listening on port ' + app.get('port'));
		});
		// https.createServer(httpsOptions, app).listen(PORT, () => console.log(`Server has been started on PORT ${PORT}...`))
	} catch (e) {
		console.log('Неизвестная ошибка', e.message)
		process.exit(1)
	}
}

start()

module.exports = app