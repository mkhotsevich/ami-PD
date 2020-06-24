const { Schema, Types, model } = require('mongoose')

const taskHistorySchema = new Schema({
	userId: {
		type: Types.ObjectId,
		ref: 'User',
		required: true
	},
	title: {
		type: String,
		required: true
	},
	notificationTime: {
		type: Number,
		required: true
	},
	createdAt: {
		type: Number,
		default: Date.now(),
		required: true
	}
})

module.exports = model('TaskHistory', taskHistorySchema)
