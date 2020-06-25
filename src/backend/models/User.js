const { Schema, model } = require('mongoose')

const userSchema = new Schema({
	email: {
		type: String,
		required: true,
		unique: true
	},
	password: {
		type: String,
		required: true
	},
	name: {
		type: String,
	},
	surname: {
		type: String,
	},
	birthdate: {
		type: Number,
	}
})

module.exports = model('User', userSchema)
