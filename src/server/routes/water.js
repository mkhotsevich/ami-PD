const WaterHistory = require('../models/WaterHistory')
const auth = require('../middleware/auth.middleware')
const User = require('../models/User')
const { Router } = require('express')

const router = Router()

router.get('/', auth, async (req, res) => {
	try {
		const waterHistory = await WaterHistory.find({ userId: req.user.userId })

		res.status(200).json(
			waterHistory
		)

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})
router.post('/', auth, async (req, res) => {
	try {
		const { amount, drinkedAt } = req.body

		const waterHistory = new WaterHistory({
			userId: req.user.userId,
			amount,
			drinkedAt
		})
		await waterHistory.save()

		res.status(201).json({
			id: waterHistory._id,
			amount: waterHistory.amount,
			drinkedAt: waterHistory.drinkedAt
		})

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

router.put('/:id', auth, async (req, res) => {
	try {
		const { amount, drinkedAt } = req.body

		const waterHistory = await WaterHistory.findById(req.params.id, (err) => {
			if (err) return res.status(404).json({ message: 'Объект с данным ID не найден' })
		})

		waterHistory.amount = amount || waterHistory.amount
		waterHistory.drinkedAt = drinkedAt || waterHistory.drinkedAt

		await waterHistory.save()

		res.status(200).json({
			id: waterHistory._id,
			amount: waterHistory.amount,
			drinkedAt: waterHistory.drinkedAt
		})

	} catch (e) {
		console.log(e)
		return res.status(500).json({ message: 'Что-то пошло не так, попробуйте позже' })
	}
})

router.delete('/:id', auth, async (req, res) => {
	try {

		await WaterHistory.deleteOne({ _id: req.params.id }, (err) => {
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