const { Schema, Types, model } = require('mongoose')

const userStateSchema = new Schema({
	userId: {
		type: Types.ObjectId,
		ref: 'User',
		required: true
	},
	weight: {
		type: Number,
		required: true
	},
	height: {
		type: Number,
		required: true
	}
}, { versionKey: false })

module.exports = model('UserState', userStateSchema)
