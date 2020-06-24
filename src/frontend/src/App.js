import React from 'react'
import useRoutes from './routes'

const App = () => {
	const routes = useRoutes(false, false)
	return (
		<div>
			{routes}
		</div>
	)
}

export default App