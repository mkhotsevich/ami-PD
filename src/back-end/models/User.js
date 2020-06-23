const { Schema, Types, model } = require('mongoose')

const userSchema = new Schema({
	nickname: { type: String, required: true },
	surname: { type: String },
	name: { type: String },
	patronymic: { type: String },
	height: { type: Number },
	weight: { type: Number }
})

module.exports = model('User', userSchema)
