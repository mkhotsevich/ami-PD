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
		required: true
	},
	surname: {
		type: String,
		required: true
	},
	birthday: {
		type: Number,
		required: true
	},
	weigth: {
		type: Number,
		required: true
	},
	appleId: {
		type: String
	},
	vkId: {
		type: String
	}
})

module.exports = model('User', userSchema)
