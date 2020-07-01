import { useState, useCallback } from 'react'

const useHttp = () => {
	const [loading, setLoading] = useState(false)
	const [error, setError] = useState(null)
	const request = useCallback(async (url, method = 'GET', body = null, headers = {}) => {
		try {
			setLoading(true)
			if (body) {
				body = JSON.stringify(body)
				headers['Content-Type'] = 'application/json'
			}
			const response = await fetch(url, { method, body, headers })
			const data = await response.json()

			if (!response.ok) {
				throw new Error(data.message || 'Неизвестная ошибка')
			}

			setLoading(false)
			return data
		} catch (e) {
			setLoading(false)
			setError(e.message)
			throw e
		}
	}, [])

	const clearError = () => setError(null)

	return { loading, request, error, clearError }
}

export default useHttp