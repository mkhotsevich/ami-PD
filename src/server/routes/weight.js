const WeightHistory = require('../models/WeightHistory')
const auth = require('../middleware/auth.middleware')
const { Router } = require('express')

const router = Router()

router.get('/', auth, async (req, res) => {
	try {
		const weightHistory = await WeightHistory.find({ userId: req.user.userId })

		res.status(200).json(
			weightHistory
		)

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})
router.post('/', auth, async (req, res) => {
	try {
		const { amount, weighedAt } = req.body

		const weightHistory = new WeightHistory({
			userId: req.user.userId,
			amount,
			weighedAt
		})
		await weightHistory.save()

		res.status(201).json({
			weightHistory
		})

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

router.put('/:id', auth, async (req, res) => {
	try {
		const { amount, weighedAt } = req.body

		const weightHistory = await WeightHistory.findById(req.params.id, (err) => {
			if (err) return res.status(404).json({ message: 'Объект с данным ID не найден' })
		})

		weightHistory.amount = amount || weightHistory.amount
		weightHistory.weighedAt = weighedAt || weightHistory.weighedAt

		await weightHistory.save()

		res.status(200).json({
			weightHistory
		})

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

router.delete('/:id', auth, async (req, res) => {
	try {

		await WeightHistory.deleteOne({ _id: req.params.id }, (err) => {
			if (err) return res.status(404).json({ message: 'Объект с данным ID не найден' })
		})

		res.status(200).json({
			message: "Успешно"
		})

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})


module.exports = router