import React from 'react'
import useRoutes from './routes'
import useAuth from './hooks/auth.hook'
import AuthContext from './context/AuthContext'
import Navbar from './components/Navbar/Navbar'

const App = () => {
	const { login, logout, token, userId } = useAuth()
	const isAuthenticated = !!token
	const routes = useRoutes(isAuthenticated, false)
	return (
		<AuthContext.Provider value={
			{ login, logout, token, userId, isAuthenticated }
		}>
			<div className={'container h-100'}>
				{isAuthenticated && <Navbar />}
				{routes}
			</div>
		</AuthContext.Provider>
	)
}

export default App