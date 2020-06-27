const { Schema, Types, model } = require('mongoose')

const sleepHistorySchema = new Schema({
	userId: {
		type: Types.ObjectId,
		ref: 'User',
		required: true
	},
	endTime: {
		type: Number,
		required: true
	},
	riseTime: {
		type: Number,
		required: true
	}
})

module.exports = model('SleepHistory', sleepHistorySchema)
