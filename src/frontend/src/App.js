import React from 'react'
import useRoutes from './routes'

const App = () => {
	const routes = useRoutes(false, false)
	return (
		<div className={'container h-100'}>
			{routes}
		</div>
	)
}

export default App